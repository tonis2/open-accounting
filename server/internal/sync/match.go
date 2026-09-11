package sync

import (
	"context"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	"open-accounting/server/internal/db"
)

// OpenInvoice is the subset of an invoice the matcher needs.
type OpenInvoice struct {
	ID          int64
	Number      string
	TotalCents  int64
	Currency    string
	IssueDate   time.Time
	ProjectName string
}

// Candidate is an incoming, unlinked bank transaction.
type Candidate struct {
	ID               int64
	AmountCents      int64
	Currency         string
	BookedAt         time.Time
	Description      string
	Reference        string
	CounterpartyName string
}

// Matches returns true when tx plausibly pays inv: same amount and currency, booked after the
// invoice was issued (3 days slack), and either the invoice number appears in the payment text
// or the payer name matches the project.
func Matches(inv OpenInvoice, tx Candidate) bool {
	if tx.AmountCents != inv.TotalCents || !strings.EqualFold(strings.TrimSpace(tx.Currency), strings.TrimSpace(inv.Currency)) {
		return false
	}
	if tx.BookedAt.Before(inv.IssueDate.AddDate(0, 0, -3)) {
		return false
	}
	text := normalize(tx.Reference + " " + tx.Description)
	if num := normalize(inv.Number); num != "" && strings.Contains(text, num) {
		return true
	}
	payer := normalize(tx.CounterpartyName)
	project := normalize(inv.ProjectName)
	if len(payer) >= 4 && len(project) >= 4 && (strings.Contains(payer, project) || strings.Contains(project, payer)) {
		return true
	}
	return false
}

// normalize lowercases and strips spaces/punctuation so "INV-0007" matches "inv 0007".
func normalize(s string) string {
	var b strings.Builder
	for _, r := range strings.ToLower(s) {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') || r > 127 {
			b.WriteRune(r)
		}
	}
	return b.String()
}

// MatchInvoices links open invoices to unlinked incoming transactions. Returns the number linked.
func MatchInvoices(ctx context.Context, pool *pgxpool.Pool, companyID int64) (int, error) {
	rows, err := pool.Query(ctx, `SELECT i.id, i.number, i.total_cents, i.currency, i.issue_date, p.name
		FROM invoices i JOIN projects p ON p.id=i.project_id WHERE i.company_id=$1 AND i.status='open' AND i.number IS NOT NULL`, companyID)
	if err != nil {
		return 0, err
	}
	var open []OpenInvoice
	for rows.Next() {
		var inv OpenInvoice
		if err := rows.Scan(&inv.ID, &inv.Number, &inv.TotalCents, &inv.Currency, &inv.IssueDate, &inv.ProjectName); err != nil {
			rows.Close()
			return 0, err
		}
		open = append(open, inv)
	}
	rows.Close()
	if len(open) == 0 {
		return 0, nil
	}

	rows, err = pool.Query(ctx, `SELECT id, amount_cents, currency, booked_at, description, reference, counterparty_name
		FROM bank_transactions WHERE company_id=$1 AND amount_cents > 0 AND invoice_id IS NULL ORDER BY booked_at`, companyID)
	if err != nil {
		return 0, err
	}
	var candidates []Candidate
	for rows.Next() {
		var c Candidate
		if err := rows.Scan(&c.ID, &c.AmountCents, &c.Currency, &c.BookedAt, &c.Description, &c.Reference, &c.CounterpartyName); err != nil {
			rows.Close()
			return 0, err
		}
		candidates = append(candidates, c)
	}
	rows.Close()

	linked := 0
	used := map[int64]bool{}
	for _, inv := range open {
		for _, c := range candidates {
			if used[c.ID] || !Matches(inv, c) {
				continue
			}
			err := db.WithTx(ctx, pool, func(tx pgx.Tx) error {
				tag, err := tx.Exec(ctx, "UPDATE invoices SET status='paid', paid_at=$2, paid_transaction_id=$3 WHERE id=$1 AND status='open'", inv.ID, c.BookedAt, c.ID)
				if err != nil || tag.RowsAffected() == 0 {
					return err
				}
				_, err = tx.Exec(ctx, `UPDATE bank_transactions SET invoice_id=$2,
					category_id = COALESCE(category_id, (SELECT id FROM categories WHERE company_id=$3 AND kind='income' ORDER BY sort_order LIMIT 1)),
					status = CASE WHEN status='unexplained' THEN 'explained' ELSE status END
					WHERE id=$1 AND invoice_id IS NULL`, c.ID, inv.ID, companyID)
				return err
			})
			if err != nil {
				return linked, err
			}
			used[c.ID] = true
			linked++
			break
		}
	}
	return linked, nil
}
