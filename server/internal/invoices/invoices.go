package invoices

import (
	"context"
	"fmt"
	"time"

	"github.com/jackc/pgx/v5"

	"open-accounting/server/internal/money"
)

type Status string

const (
	StatusDraft     Status = "draft"
	StatusOpen      Status = "open"
	StatusPaid      Status = "paid"
	StatusCancelled Status = "cancelled"
)

// Item is one invoice line. Quantity is in thousandths, VAT rate in basis points.
type Item struct {
	ID            int64
	Position      int
	Description   string
	QuantityMilli int64
	UnitCents     int64
	VatRateBp     int64
	NetCents      int64
	VatCents      int64
}

type Invoice struct {
	ID            int64
	CompanyID     int64
	ProjectID     int64
	ProjectName   string
	Number        string
	Status        Status
	IssueDate     time.Time
	DueDate       time.Time
	Currency      string
	SubtotalCents int64
	VatCents      int64
	TotalCents    int64
	Notes         string
	Reference     string
	PaidAt        *time.Time
	PaidTxID      *int64
	SentAt        *time.Time
	CreatedAt     time.Time
	Items         []Item
}

// Company/Project carry only what the PDF and emails need.
type Company struct {
	Name, RegNumber, VatNumber, Address, Email, Phone, IBAN, BankName string
}

type Project struct {
	Name, ContactName, Email, Address, RegNumber, VatNumber string
}

// Totals recomputes per-line and invoice totals in place (per-line rounding, then sum).
func Totals(items []Item) (subtotal, vat, total int64) {
	for i := range items {
		items[i].NetCents = money.Net(items[i].QuantityMilli, items[i].UnitCents)
		items[i].VatCents = money.Vat(items[i].NetCents, items[i].VatRateBp)
		subtotal += items[i].NetCents
		vat += items[i].VatCents
	}
	return subtotal, vat, subtotal + vat
}

// NextNumber atomically reserves the next invoice number for a company.
func NextNumber(ctx context.Context, tx pgx.Tx, companyID int64) (string, error) {
	var prefix string
	var n int
	err := tx.QueryRow(ctx, `UPDATE companies SET next_invoice_number = next_invoice_number + 1
		WHERE id = $1 RETURNING invoice_prefix, next_invoice_number - 1`, companyID).Scan(&prefix, &n)
	if err != nil {
		return "", err
	}
	return fmt.Sprintf("%s%04d", prefix, n), nil
}

func (inv Invoice) IsOverdue(now time.Time) bool {
	return inv.Status == StatusOpen && inv.DueDate.Before(now.Truncate(24*time.Hour))
}
