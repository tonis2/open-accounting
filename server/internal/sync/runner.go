package sync

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"strconv"
	"strings"
	gosync "sync"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"

	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/crypto"
	"open-accounting/server/internal/money"
)

// Runner periodically pulls transactions from every active bank connection and matches invoices.
type Runner struct {
	DB       *pgxpool.Pool
	Banks    *banks.Registry
	Box      *crypto.Box
	Interval time.Duration

	mu     gosync.Mutex // one sync at a time keeps provider rate limits predictable
	locked map[int64]bool
}

type Summary struct {
	Connections  int
	Transactions int
	Matched      int
	Errors       []string
}

func (r *Runner) Start(ctx context.Context) {
	if r.Interval <= 0 {
		r.Interval = time.Hour
	}
	go func() {
		// First pass shortly after boot so a fresh install shows data quickly.
		timer := time.NewTimer(30 * time.Second)
		defer timer.Stop()
		for {
			select {
			case <-ctx.Done():
				return
			case <-timer.C:
			}
			r.syncAll(ctx)
			timer.Reset(r.Interval)
		}
	}()
}

func (r *Runner) syncAll(ctx context.Context) {
	rows, err := r.DB.Query(ctx, "SELECT DISTINCT company_id FROM bank_connections WHERE status='active'")
	if err != nil {
		slog.Error("[SYNC] list companies", "err", err)
		return
	}
	var ids []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err == nil {
			ids = append(ids, id)
		}
	}
	rows.Close()
	for _, id := range ids {
		if _, err := r.SyncCompany(ctx, id, false); err != nil {
			slog.Error("[SYNC] company failed", "company", id, "err", err)
		}
	}
}

// SyncCompany syncs every active connection of the company, then runs the invoice matcher.
// force ignores provider minimum intervals (used by the manual "Sync now" button).
func (r *Runner) SyncCompany(ctx context.Context, companyID int64, force bool) (Summary, error) {
	r.mu.Lock()
	defer r.mu.Unlock()
	var sum Summary
	rows, err := r.DB.Query(ctx, "SELECT id FROM bank_connections WHERE company_id=$1 AND status IN ('active','error') ORDER BY id", companyID)
	if err != nil {
		return sum, err
	}
	var ids []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err == nil {
			ids = append(ids, id)
		}
	}
	rows.Close()
	for _, id := range ids {
		added, err := r.syncConnection(ctx, id, force)
		sum.Connections++
		sum.Transactions += added
		if err != nil {
			sum.Errors = append(sum.Errors, err.Error())
		}
	}
	matched, err := MatchInvoices(ctx, r.DB, companyID)
	if err != nil {
		sum.Errors = append(sum.Errors, "matching: "+err.Error())
	}
	sum.Matched = matched
	return sum, nil
}

// SyncConnection is used right after a connection is created or re-authorised.
func (r *Runner) SyncConnection(ctx context.Context, connID int64) (int, error) {
	r.mu.Lock()
	defer r.mu.Unlock()
	added, err := r.syncConnection(ctx, connID, true)
	if err == nil {
		var companyID int64
		if e := r.DB.QueryRow(ctx, "SELECT company_id FROM bank_connections WHERE id=$1", connID).Scan(&companyID); e == nil {
			_, _ = MatchInvoices(ctx, r.DB, companyID)
		}
	}
	return added, err
}

type connRow struct {
	id, companyID int64
	provider      string
	name          string
	cfg           banks.Config
	state         json.RawMessage
	lastSync      *time.Time
}

func (r *Runner) loadConnection(ctx context.Context, id int64) (connRow, banks.Provider, error) {
	var c connRow
	var enc []byte
	err := r.DB.QueryRow(ctx, "SELECT id, company_id, provider, name, config_enc, state, last_sync_at FROM bank_connections WHERE id=$1", id).
		Scan(&c.id, &c.companyID, &c.provider, &c.name, &enc, &c.state, &c.lastSync)
	if err != nil {
		return c, nil, err
	}
	plain, err := r.Box.Open(enc)
	if err != nil {
		return c, nil, fmt.Errorf("decrypt config: %w", err)
	}
	if err := json.Unmarshal(plain, &c.cfg); err != nil {
		return c, nil, err
	}
	p, ok := r.Banks.Get(c.provider)
	if !ok {
		return c, nil, fmt.Errorf("provider %q is not enabled on this server", c.provider)
	}
	// Providers such as the mock need to know which company they serve.
	c.cfg["_company_id"] = strconv.FormatInt(c.companyID, 10)
	return c, p, nil
}

func (r *Runner) syncConnection(ctx context.Context, id int64, force bool) (int, error) {
	c, p, err := r.loadConnection(ctx, id)
	if err != nil {
		return 0, fmt.Errorf("connection %d: %w", id, err)
	}
	if t, ok := p.(banks.SyncThrottler); ok && !force && c.lastSync != nil && time.Since(*c.lastSync) < t.MinSyncInterval() {
		return 0, nil
	}
	added, soft, err := r.pull(ctx, c, p)
	if err != nil {
		st, msg := "error", err.Error()
		if errors.Is(err, banks.ErrConsentExpired) {
			st, msg = "expired", "Bank consent expired — please update the connection."
		}
		_, _ = r.DB.Exec(ctx, "UPDATE bank_connections SET status=$2, status_message=$3 WHERE id=$1", id, st, msg)
		slog.Warn("[SYNC] connection failed", "connection", id, "provider", c.provider, "err", err)
		return added, fmt.Errorf("%s: %s", c.name, msg)
	}
	// A soft outcome keeps the connection active but remembers that rows come from uploads.
	msg, flag := "", "state - 'statements_unavailable'"
	if soft != nil {
		msg, flag = strings.TrimPrefix(soft.Error(), banks.ErrStatementsUnavailable.Error()+": "), `state || '{"statements_unavailable": true}'`
		slog.Info("[SYNC] statements unavailable", "connection", id, "provider", c.provider, "err", soft)
	}
	_, _ = r.DB.Exec(ctx, "UPDATE bank_connections SET status='active', status_message=$2, last_sync_at=now(), state = "+flag+" WHERE id=$1", id, msg)
	slog.Info("[SYNC] connection synced", "connection", id, "provider", c.provider, "added", added)
	return added, nil
}

// pull upserts accounts and transactions; soft reports providers that refused statements
// for at least one account without that being a connection failure.
func (r *Runner) pull(ctx context.Context, c connRow, p banks.Provider) (added int, soft, err error) {
	accounts, err := p.ListAccounts(ctx, c.cfg, c.state)
	if err != nil {
		return 0, nil, err
	}
	ids := make([]string, 0, len(accounts))
	for _, a := range accounts {
		ids = append(ids, a.ExternalID)
		var acctID int64
		var lastSync *time.Time
		var hasPrimary bool
		_ = r.DB.QueryRow(ctx, "SELECT EXISTS(SELECT 1 FROM bank_accounts WHERE company_id=$1 AND is_primary)", c.companyID).Scan(&hasPrimary)
		err := r.DB.QueryRow(ctx, `INSERT INTO bank_accounts (connection_id, company_id, external_id, name, iban, currency, balance_cents, balance_at, is_primary)
			VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)
			ON CONFLICT (connection_id, external_id) DO UPDATE SET name=EXCLUDED.name, iban=EXCLUDED.iban, balance_cents=EXCLUDED.balance_cents, balance_at=EXCLUDED.balance_at
			RETURNING id, last_sync_at`,
			c.id, c.companyID, a.ExternalID, a.Name, a.IBAN, strings.ToUpper(a.Currency), a.BalanceCents, nullTime(a.BalanceAt), !hasPrimary).Scan(&acctID, &lastSync)
		if err != nil {
			return added, soft, err
		}
		to := time.Now()
		from := to.AddDate(0, 0, -90)
		if lastSync != nil && lastSync.AddDate(0, 0, -7).After(from) {
			from = lastSync.AddDate(0, 0, -7)
		}
		txs, err := p.FetchTransactions(ctx, c.cfg, c.state, a, from, to)
		if errors.Is(err, banks.ErrStatementsUnavailable) {
			soft = err
			continue
		}
		if err != nil {
			return added, soft, err
		}
		for _, t := range txs {
			// xmax = 0 is only true for rows created by this statement, so it tells insert from update.
			var inserted bool
			err := r.DB.QueryRow(ctx, `INSERT INTO bank_transactions (account_id, company_id, external_id, booked_at, value_date, amount_cents, currency, description, counterparty_name, counterparty_iban, reference, raw)
				VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
				ON CONFLICT (account_id, external_id) DO UPDATE SET amount_cents=EXCLUDED.amount_cents, booked_at=EXCLUDED.booked_at, raw=EXCLUDED.raw
				RETURNING (xmax = 0)`,
				acctID, c.companyID, t.ExternalID, t.BookedAt, nullDate(t.ValueDate), t.AmountCents, strings.ToUpper(orDefault(t.Currency, a.Currency)),
				t.Description, t.CounterpartyName, t.CounterpartyIBAN, t.Reference, nullJSON(t.Raw)).Scan(&inserted)
			if err != nil {
				return added, soft, err
			}
			if inserted {
				added++
			}
		}
		_, _ = r.DB.Exec(ctx, "UPDATE bank_accounts SET last_sync_at=now() WHERE id=$1", acctID)
		if bp, ok := p.(banks.BalanceFromTransactions); ok && bp.BalanceFromTransactions() {
			RecomputeBalance(ctx, r.DB, acctID, c.cfg["opening_balance"])
		}
	}
	// Accounts the bank no longer lists (e.g. after switching profile) go away unless they hold data.
	_, _ = r.DB.Exec(ctx, `DELETE FROM bank_accounts WHERE connection_id=$1 AND external_id <> ALL($2)
		AND NOT EXISTS (SELECT 1 FROM bank_transactions t WHERE t.account_id = bank_accounts.id)`, c.id, ids)
	return added, soft, nil
}

// RecomputeBalance sets an upload-only account's balance to opening + sum of its transactions.
func RecomputeBalance(ctx context.Context, pool *pgxpool.Pool, accountID int64, opening string) {
	openingCents, _ := money.ParseCents(strings.TrimSpace(orDefault(opening, "0")))
	_, _ = pool.Exec(ctx, `UPDATE bank_accounts SET balance_cents = $2 + COALESCE((SELECT SUM(amount_cents) FROM bank_transactions WHERE account_id=$1),0),
		balance_at = now() WHERE id=$1`, accountID, openingCents)
}

func nullTime(t time.Time) *time.Time {
	if t.IsZero() {
		return nil
	}
	return &t
}

func nullDate(t time.Time) *time.Time { return nullTime(t) }

func nullJSON(raw json.RawMessage) any {
	if len(raw) == 0 {
		return nil
	}
	return raw
}

func orDefault(v, def string) string {
	if strings.TrimSpace(v) == "" {
		return def
	}
	return v
}
