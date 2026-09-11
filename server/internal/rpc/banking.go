package rpc

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log/slog"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"open-accounting/server/internal/auth"
	"open-accounting/server/internal/banks"
	"open-accounting/server/pb"
)

func fieldKindToPB(k banks.FieldKind) pb.FieldKind {
	switch k {
	case banks.FieldSecret:
		return pb.FieldKind_FIELD_KIND_SECRET
	case banks.FieldMultiline:
		return pb.FieldKind_FIELD_KIND_MULTILINE
	case banks.FieldSelect:
		return pb.FieldKind_FIELD_KIND_SELECT
	case banks.FieldBool:
		return pb.FieldKind_FIELD_KIND_BOOL
	}
	return pb.FieldKind_FIELD_KIND_TEXT
}

func providerToPB(p banks.Provider) *pb.BankProvider {
	out := &pb.BankProvider{Id: p.ID(), Name: p.Name(), Description: p.Description(), NeedsRedirect: p.NeedsRedirect()}
	_, out.HasInstitutions = p.(banks.InstitutionLister)
	for _, f := range p.ConfigFields() {
		out.ConfigFields = append(out.ConfigFields, &pb.ConfigField{Key: f.Key, Label: f.Label, Hint: f.Hint, Kind: fieldKindToPB(f.Kind), Options: f.Options, Required: f.Required, DefaultValue: f.Default})
	}
	return out
}

func connStatusToPB(s string) pb.ConnectionStatus {
	switch s {
	case "pending":
		return pb.ConnectionStatus_CONNECTION_STATUS_PENDING
	case "active":
		return pb.ConnectionStatus_CONNECTION_STATUS_ACTIVE
	case "expired":
		return pb.ConnectionStatus_CONNECTION_STATUS_EXPIRED
	case "error":
		return pb.ConnectionStatus_CONNECTION_STATUS_ERROR
	}
	return pb.ConnectionStatus_CONNECTION_STATUS_UNSPECIFIED
}

func (s *Server) ListBankProviders(_ context.Context, _ *pb.Empty) (*pb.ListBankProvidersResponse, error) {
	out := &pb.ListBankProvidersResponse{}
	for _, p := range s.Banks.All() {
		out.Items = append(out.Items, providerToPB(p))
	}
	return out, nil
}

func (s *Server) ListInstitutions(ctx context.Context, req *pb.ListInstitutionsRequest) (*pb.ListInstitutionsResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	p, ok := s.Banks.Get(req.Provider)
	if !ok {
		return nil, invalid("unknown provider")
	}
	lister, ok := p.(banks.InstitutionLister)
	if !ok {
		return &pb.ListInstitutionsResponse{}, nil
	}
	country := strings.ToUpper(req.Country)
	if country == "" {
		country = "EE"
	}
	list, err := lister.ListInstitutions(ctx, banks.Config(req.Config), country)
	if err != nil {
		return nil, status.Error(codes.Unavailable, err.Error())
	}
	out := &pb.ListInstitutionsResponse{}
	for _, i := range list {
		out.Items = append(out.Items, &pb.Institution{Id: i.ID, Name: i.Name, Bic: i.BIC, LogoUrl: i.LogoURL, TransactionTotalDays: uint32(i.TransactionTotalDays)})
	}
	return out, nil
}

const connCols = `c.id, c.company_id, c.provider, c.name, c.status, c.status_message, c.consent_expires_at, c.last_sync_at, c.created_at,
	(SELECT COUNT(*) FROM bank_accounts a WHERE a.connection_id=c.id), c.config_enc, COALESCE((c.state->>'statements_unavailable')::bool, false)`

func (s *Server) scanConnection(row pgx.Row) (*pb.BankConnection, error) {
	var c pb.BankConnection
	var st string
	var consent, last *time.Time
	var created time.Time
	var enc []byte
	var noStatements bool
	if err := row.Scan(&c.Id, &c.CompanyId, &c.Provider, &c.Name, &st, &c.StatusMessage, &consent, &last, &created, &c.AccountCount, &enc, &noStatements); err != nil {
		return nil, err
	}
	c.Status = connStatusToPB(st)
	c.ConsentExpiresAt = ts(consent)
	c.LastSyncAt = ts(last)
	c.CreatedAt = tsv(created)
	c.ProviderName = c.Provider
	if p, ok := s.Banks.Get(c.Provider); ok {
		c.ProviderName = p.Name()
		c.StatementsOnly = noStatements || statementsOnly(p, enc, s)
		// Expose current settings so they can be edited, but never echo secrets back.
		if cfg, err := s.openConfig(enc); err == nil {
			c.Config = map[string]string{}
			for _, f := range p.ConfigFields() {
				if isSecretField(f) {
					c.Config[f.Key] = ""
				} else {
					c.Config[f.Key] = cfg[f.Key]
				}
			}
		}
	}
	return &c, nil
}

// statementsOnly reports whether transactions for this connection come from uploads: upload-only
// providers always, Wise when no signing key is configured.
func statementsOnly(p banks.Provider, enc []byte, s *Server) bool {
	if bp, ok := p.(banks.BalanceFromTransactions); ok && bp.BalanceFromTransactions() {
		return true
	}
	if p.ID() == "wise" {
		cfg, err := s.openConfig(enc)
		return err == nil && strings.TrimSpace(cfg["private_key_pem"]) == ""
	}
	return false
}

// isSecretField covers passwords/tokens and pasted key material.
func isSecretField(f banks.ConfigField) bool {
	return f.Kind == banks.FieldSecret || f.Kind == banks.FieldMultiline
}

// UpdateBankConnection changes the name and settings of an existing connection. Empty values
// keep the stored value, so the form never has to re-send secrets. A successful update clears
// the error state and syncs immediately.
func (s *Server) UpdateBankConnection(ctx context.Context, req *pb.UpdateBankConnectionRequest) (*pb.UpdateBankConnectionResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	var provider string
	var enc []byte
	err := s.DB.QueryRow(ctx, "SELECT provider, config_enc FROM bank_connections WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId).Scan(&provider, &enc)
	if err != nil {
		return nil, dbErr(err)
	}
	p, ok := s.Banks.Get(provider)
	if !ok {
		return nil, invalid("provider not enabled")
	}
	cfg, err := s.openConfig(enc)
	if err != nil {
		return nil, internalErr(err)
	}
	for _, f := range p.ConfigFields() {
		if v := strings.TrimSpace(req.Config[f.Key]); v != "" {
			cfg[f.Key] = v
		}
	}
	if err := banks.Validate(p, cfg); err != nil {
		return nil, invalid(err.Error())
	}
	sealed, err := s.sealConfig(cfg)
	if err != nil {
		return nil, internalErr(err)
	}
	name := strings.TrimSpace(req.Name)
	// Providers that connect without a redirect derive their state (e.g. the Wise profile id)
	// from the config, so re-resolve it — otherwise a changed profile keeps the stale id.
	var state json.RawMessage
	if !p.NeedsRedirect() {
		res, err := p.Connect(ctx, cfg, "")
		var choice *banks.ChoiceRequired
		if errors.As(err, &choice) {
			return &pb.UpdateBankConnectionResponse{Choice: choiceToPB(choice)}, nil
		}
		if err != nil {
			return nil, status.Error(codes.FailedPrecondition, "could not connect: "+err.Error())
		}
		state = stateOrEmpty(res.State)
	}
	_, err = s.DB.Exec(ctx, `UPDATE bank_connections SET config_enc=$3, name=COALESCE(NULLIF($4,''), name), state=COALESCE($5, state),
		status = CASE WHEN status='error' THEN 'active' ELSE status END, status_message='' WHERE id=$1 AND company_id=$2`, req.Id, req.CompanyId, sealed, name, state)
	if err != nil {
		return nil, internalErr(err)
	}
	if _, err := s.Sync.SyncConnection(ctx, int64(req.Id)); err != nil {
		slog.Warn("[BANK] sync after update failed", "connection", req.Id, "err", err)
	}
	conn, err := s.getConnection(ctx, req.CompanyId, req.Id)
	if err != nil {
		return nil, err
	}
	return &pb.UpdateBankConnectionResponse{Connection: conn}, nil
}

func (s *Server) getConnection(ctx context.Context, companyID, id uint64) (*pb.BankConnection, error) {
	c, err := s.scanConnection(s.DB.QueryRow(ctx, `SELECT `+connCols+` FROM bank_connections c WHERE c.id=$1 AND c.company_id=$2`, id, companyID))
	if err != nil {
		return nil, dbErr(err)
	}
	return c, nil
}

func (s *Server) callbackURL(reference string) string {
	return fmt.Sprintf("%s/banking/callback?ref=%s", s.Cfg.PublicURL, reference)
}

func (s *Server) CreateBankConnection(ctx context.Context, req *pb.CreateBankConnectionRequest) (*pb.CreateBankConnectionResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	p, ok := s.Banks.Get(req.Provider)
	if !ok {
		return nil, invalid("unknown provider")
	}
	cfg := banks.Config{}
	for _, f := range p.ConfigFields() {
		v := strings.TrimSpace(req.Config[f.Key])
		if v == "" {
			v = f.Default
		}
		cfg[f.Key] = v
	}
	if err := banks.Validate(p, cfg); err != nil {
		return nil, invalid(err.Error())
	}
	name := strings.TrimSpace(req.Name)
	if name == "" {
		name = p.Name()
	}
	reference := auth.RandomToken(18)
	res, err := p.Connect(ctx, cfg, s.callbackURL(reference))
	var choice *banks.ChoiceRequired
	if errors.As(err, &choice) {
		return &pb.CreateBankConnectionResponse{Choice: choiceToPB(choice)}, nil
	}
	if err != nil {
		return nil, status.Error(codes.FailedPrecondition, "could not connect: "+err.Error())
	}
	enc, err := s.sealConfig(cfg)
	if err != nil {
		return nil, internalErr(err)
	}
	st := "active"
	if res.RedirectURL != "" {
		st = "pending"
	}
	var id int64
	err = s.DB.QueryRow(ctx, `INSERT INTO bank_connections (company_id, provider, name, config_enc, state, reference, status, consent_expires_at)
		VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING id`,
		req.CompanyId, p.ID(), name, enc, stateOrEmpty(res.State), reference, st, res.ConsentExpiresAt).Scan(&id)
	if err != nil {
		return nil, dbErr(err)
	}
	if st == "active" {
		if _, err := s.Sync.SyncConnection(ctx, id); err != nil {
			slog.Warn("[BANK] initial sync failed", "connection", id, "err", err)
		}
	}
	conn, err := s.getConnection(ctx, req.CompanyId, uint64(id))
	if err != nil {
		return nil, err
	}
	return &pb.CreateBankConnectionResponse{Connection: conn, RedirectUrl: res.RedirectURL}, nil
}

func choiceToPB(c *banks.ChoiceRequired) *pb.ChoiceRequired {
	out := &pb.ChoiceRequired{Key: c.Field, Label: c.Label}
	for _, o := range c.Options {
		out.Options = append(out.Options, &pb.ChoiceOption{Value: o.Value, Label: o.Label})
	}
	return out
}

func stateOrEmpty(st json.RawMessage) json.RawMessage {
	if len(st) == 0 {
		return json.RawMessage(`{}`)
	}
	return st
}

func (s *Server) sealConfig(cfg banks.Config) ([]byte, error) {
	plain, err := json.Marshal(cfg)
	if err != nil {
		return nil, err
	}
	return s.Box.Seal(plain)
}

func (s *Server) openConfig(enc []byte) (banks.Config, error) {
	plain, err := s.Box.Open(enc)
	if err != nil {
		return nil, err
	}
	var cfg banks.Config
	return cfg, json.Unmarshal(plain, &cfg)
}

// CompleteBankConnection is called by the dashboard when the user returns from the bank.
func (s *Server) CompleteBankConnection(ctx context.Context, req *pb.CompleteBankConnectionRequest) (*pb.BankConnection, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	var id, companyID int64
	var provider string
	var enc []byte
	var state json.RawMessage
	err = s.DB.QueryRow(ctx, `SELECT c.id, c.company_id, c.provider, c.config_enc, c.state FROM bank_connections c
		JOIN company_members m ON m.company_id=c.company_id AND m.user_id=$2 WHERE c.reference=$1`, req.Reference, uid).
		Scan(&id, &companyID, &provider, &enc, &state)
	if errors.Is(err, pgx.ErrNoRows) {
		return nil, status.Error(codes.NotFound, "unknown connection reference")
	}
	if err != nil {
		return nil, internalErr(err)
	}
	p, ok := s.Banks.Get(provider)
	if !ok {
		return nil, invalid("provider not enabled")
	}
	cfg, err := s.openConfig(enc)
	if err != nil {
		return nil, internalErr(err)
	}
	res, err := p.CompleteConnect(ctx, cfg, state, req.Params)
	if err != nil {
		msg := err.Error()
		_, _ = s.DB.Exec(ctx, "UPDATE bank_connections SET status='error', status_message=$2 WHERE id=$1", id, msg)
		return nil, status.Error(codes.FailedPrecondition, msg)
	}
	_, err = s.DB.Exec(ctx, "UPDATE bank_connections SET status='active', status_message='', state=$2, consent_expires_at=COALESCE($3, consent_expires_at) WHERE id=$1",
		id, stateOrEmpty(res.State), res.ConsentExpiresAt)
	if err != nil {
		return nil, internalErr(err)
	}
	if _, err := s.Sync.SyncConnection(ctx, id); err != nil {
		slog.Warn("[BANK] initial sync failed", "connection", id, "err", err)
	}
	return s.getConnection(ctx, uint64(companyID), uint64(id))
}

// ReconnectBankConnection restarts the authorisation flow for an expired connection, keeping its accounts.
func (s *Server) ReconnectBankConnection(ctx context.Context, req *pb.CompanyIdRequest) (*pb.CreateBankConnectionResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	var provider, reference string
	var enc []byte
	err := s.DB.QueryRow(ctx, "SELECT provider, config_enc, COALESCE(reference,'') FROM bank_connections WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId).Scan(&provider, &enc, &reference)
	if err != nil {
		return nil, dbErr(err)
	}
	p, ok := s.Banks.Get(provider)
	if !ok {
		return nil, invalid("provider not enabled")
	}
	cfg, err := s.openConfig(enc)
	if err != nil {
		return nil, internalErr(err)
	}
	if reference == "" {
		reference = auth.RandomToken(18)
	}
	res, err := p.Connect(ctx, cfg, s.callbackURL(reference))
	if err != nil {
		return nil, status.Error(codes.FailedPrecondition, "could not reconnect: "+err.Error())
	}
	st := "active"
	if res.RedirectURL != "" {
		st = "pending"
	}
	_, err = s.DB.Exec(ctx, "UPDATE bank_connections SET status=$2, status_message='', state=$3, reference=$4, consent_expires_at=$5 WHERE id=$1",
		req.Id, st, stateOrEmpty(res.State), reference, res.ConsentExpiresAt)
	if err != nil {
		return nil, internalErr(err)
	}
	if st == "active" {
		_, _ = s.Sync.SyncConnection(ctx, int64(req.Id))
	}
	conn, err := s.getConnection(ctx, req.CompanyId, req.Id)
	if err != nil {
		return nil, err
	}
	return &pb.CreateBankConnectionResponse{Connection: conn, RedirectUrl: res.RedirectURL}, nil
}

func (s *Server) ListBankConnections(ctx context.Context, req *pb.CompanyRequest) (*pb.ListBankConnectionsResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, `SELECT `+connCols+` FROM bank_connections c WHERE c.company_id=$1 ORDER BY c.created_at`, req.CompanyId)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListBankConnectionsResponse{}
	for rows.Next() {
		c, err := s.scanConnection(rows)
		if err != nil {
			return nil, internalErr(err)
		}
		out.Items = append(out.Items, c)
	}
	return out, nil
}

func (s *Server) DeleteBankConnection(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Empty, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if _, err := s.DB.Exec(ctx, "DELETE FROM bank_connections WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId); err != nil {
		return nil, dbErr(err)
	}
	return &pb.Empty{}, nil
}

func (s *Server) ListBankAccounts(ctx context.Context, req *pb.CompanyRequest) (*pb.ListBankAccountsResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, `SELECT a.id, a.connection_id, a.company_id, a.name, a.iban, a.currency, a.balance_cents, a.balance_at, a.is_primary,
		c.provider, c.name, c.status, c.consent_expires_at, a.last_sync_at,
		(SELECT COUNT(*) FROM bank_transactions t WHERE t.account_id=a.id AND t.status='unexplained'),
		(SELECT COUNT(*) FROM bank_transactions t WHERE t.account_id=a.id AND t.status='explained')
		FROM bank_accounts a JOIN bank_connections c ON c.id=a.connection_id WHERE a.company_id=$1 ORDER BY a.is_primary DESC, a.name`, req.CompanyId)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListBankAccountsResponse{}
	for rows.Next() {
		var a pb.BankAccount
		var st string
		var balAt, consent, last *time.Time
		if err := rows.Scan(&a.Id, &a.ConnectionId, &a.CompanyId, &a.Name, &a.Iban, &a.Currency, &a.BalanceCents, &balAt, &a.IsPrimary,
			&a.Provider, &a.ConnectionName, &st, &consent, &last, &a.UnexplainedCount, &a.ForApprovalCount); err != nil {
			return nil, internalErr(err)
		}
		a.Currency = strings.TrimSpace(a.Currency)
		a.BalanceAt = ts(balAt)
		a.ConnectionStatus = connStatusToPB(st)
		a.ConsentExpiresAt = ts(consent)
		a.LastSyncAt = ts(last)
		out.Items = append(out.Items, &a)
	}
	return out, nil
}

func (s *Server) SetPrimaryAccount(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Empty, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if _, err := s.DB.Exec(ctx, "UPDATE bank_accounts SET is_primary = (id=$1) WHERE company_id=$2", req.Id, req.CompanyId); err != nil {
		return nil, dbErr(err)
	}
	return &pb.Empty{}, nil
}

func (s *Server) SyncNow(ctx context.Context, req *pb.CompanyRequest) (*pb.SyncNowResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	sum, err := s.Sync.SyncCompany(ctx, int64(req.CompanyId), true)
	if err != nil {
		return nil, internalErr(err)
	}
	return &pb.SyncNowResponse{ConnectionsSynced: uint32(sum.Connections), TransactionsAdded: uint32(sum.Transactions), InvoicesMatched: uint32(sum.Matched), Errors: sum.Errors}, nil
}

// GetBalanceHistory reconstructs month-end balances from the current balance and later transactions.
func (s *Server) GetBalanceHistory(ctx context.Context, req *pb.BalanceHistoryRequest) (*pb.BalanceHistoryResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	cur, err := s.companyCurrency(ctx, req.CompanyId)
	if err != nil {
		return nil, internalErr(err)
	}
	points, err := s.balanceHistory(ctx, req.CompanyId, req.AccountId, cur, int(req.Months))
	if err != nil {
		return nil, internalErr(err)
	}
	return &pb.BalanceHistoryResponse{Points: points, Currency: cur}, nil
}

func (s *Server) balanceHistory(ctx context.Context, companyID, accountID uint64, currency string, months int) ([]*pb.BalancePoint, error) {
	if months <= 0 || months > 60 {
		months = 12
	}
	rows, err := s.DB.Query(ctx, `
		WITH accts AS (
			SELECT id, balance_cents FROM bank_accounts WHERE company_id=$1 AND currency=$2 AND ($3 = 0 OR id=$3)
		), months AS (
			SELECT generate_series(date_trunc('month', now()) - make_interval(months => $4::int), date_trunc('month', now()), '1 month') AS m
		)
		SELECT to_char(m, 'YYYY-MM'),
			(SELECT COALESCE(SUM(balance_cents),0) FROM accts)
			- COALESCE((SELECT SUM(t.amount_cents) FROM bank_transactions t WHERE t.account_id IN (SELECT id FROM accts) AND t.booked_at >= m + interval '1 month'), 0)
		FROM months ORDER BY m`, companyID, currency, accountID, months-1)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var out []*pb.BalancePoint
	for rows.Next() {
		var p pb.BalancePoint
		if err := rows.Scan(&p.Month, &p.BalanceCents); err != nil {
			return nil, err
		}
		out = append(out, &p)
	}
	return out, rows.Err()
}
