package rpc

import (
	"context"
	"errors"
	"fmt"
	"log/slog"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"open-accounting/server/internal/db"
	"open-accounting/server/internal/invoices"
	"open-accounting/server/internal/mail"
	"open-accounting/server/internal/money"
	"open-accounting/server/pb"
)

func statusToPB(s invoices.Status) pb.InvoiceStatus {
	switch s {
	case invoices.StatusDraft:
		return pb.InvoiceStatus_INVOICE_STATUS_DRAFT
	case invoices.StatusOpen:
		return pb.InvoiceStatus_INVOICE_STATUS_OPEN
	case invoices.StatusPaid:
		return pb.InvoiceStatus_INVOICE_STATUS_PAID
	case invoices.StatusCancelled:
		return pb.InvoiceStatus_INVOICE_STATUS_CANCELLED
	}
	return pb.InvoiceStatus_INVOICE_STATUS_UNSPECIFIED
}

func statusFromPB(s pb.InvoiceStatus) invoices.Status {
	switch s {
	case pb.InvoiceStatus_INVOICE_STATUS_DRAFT:
		return invoices.StatusDraft
	case pb.InvoiceStatus_INVOICE_STATUS_OPEN:
		return invoices.StatusOpen
	case pb.InvoiceStatus_INVOICE_STATUS_PAID:
		return invoices.StatusPaid
	case pb.InvoiceStatus_INVOICE_STATUS_CANCELLED:
		return invoices.StatusCancelled
	}
	return ""
}

func invoiceToPB(inv invoices.Invoice) *pb.Invoice {
	out := &pb.Invoice{
		Id: uint64(inv.ID), CompanyId: uint64(inv.CompanyID), ProjectId: uint64(inv.ProjectID), ProjectName: inv.ProjectName,
		Number: inv.Number, Status: statusToPB(inv.Status), IssueDate: dateStr(inv.IssueDate), DueDate: dateStr(inv.DueDate),
		Currency: inv.Currency, SubtotalCents: inv.SubtotalCents, VatCents: inv.VatCents, TotalCents: inv.TotalCents,
		Notes: inv.Notes, Reference: inv.Reference, PaidAt: ts(inv.PaidAt), PaidTransactionId: ptrInt64(inv.PaidTxID),
		SentAt: ts(inv.SentAt), CreatedAt: tsv(inv.CreatedAt), IsOverdue: inv.IsOverdue(time.Now()),
	}
	for _, it := range inv.Items {
		out.Items = append(out.Items, &pb.InvoiceItem{
			Id: uint64(it.ID), Position: uint32(it.Position), Description: it.Description,
			Quantity: money.FormatDecimal(it.QuantityMilli, 3), UnitPriceCents: it.UnitCents,
			VatRate: money.FormatDecimal(it.VatRateBp, 2), NetCents: it.NetCents, VatCents: it.VatCents,
		})
	}
	return out
}

const invoiceCols = `i.id, i.company_id, i.project_id, p.name, COALESCE(i.number,''), i.status, i.issue_date, i.due_date, i.currency,
	i.subtotal_cents, i.vat_cents, i.total_cents, i.notes, i.reference, i.paid_at, i.paid_transaction_id, i.sent_at, i.created_at`

func scanInvoice(row pgx.Row) (invoices.Invoice, error) {
	var inv invoices.Invoice
	var st string
	err := row.Scan(&inv.ID, &inv.CompanyID, &inv.ProjectID, &inv.ProjectName, &inv.Number, &st, &inv.IssueDate, &inv.DueDate, &inv.Currency,
		&inv.SubtotalCents, &inv.VatCents, &inv.TotalCents, &inv.Notes, &inv.Reference, &inv.PaidAt, &inv.PaidTxID, &inv.SentAt, &inv.CreatedAt)
	inv.Status = invoices.Status(st)
	inv.Currency = strings.TrimSpace(inv.Currency)
	return inv, err
}

func (s *Server) loadInvoice(ctx context.Context, q interface {
	QueryRow(context.Context, string, ...any) pgx.Row
	Query(context.Context, string, ...any) (pgx.Rows, error)
}, companyID, id uint64) (invoices.Invoice, error) {
	inv, err := scanInvoice(q.QueryRow(ctx, `SELECT `+invoiceCols+` FROM invoices i JOIN projects p ON p.id=i.project_id WHERE i.id=$1 AND i.company_id=$2`, id, companyID))
	if err != nil {
		return inv, err
	}
	rows, err := q.Query(ctx, `SELECT id, position, description, quantity_milli, unit_price_cents, vat_rate_bp, net_cents, vat_cents
		FROM invoice_items WHERE invoice_id=$1 ORDER BY position`, id)
	if err != nil {
		return inv, err
	}
	defer rows.Close()
	for rows.Next() {
		var it invoices.Item
		if err := rows.Scan(&it.ID, &it.Position, &it.Description, &it.QuantityMilli, &it.UnitCents, &it.VatRateBp, &it.NetCents, &it.VatCents); err != nil {
			return inv, err
		}
		inv.Items = append(inv.Items, it)
	}
	return inv, rows.Err()
}

// parseItems validates request lines and computes totals.
func parseItems(in []*pb.InvoiceItem) ([]invoices.Item, error) {
	if len(in) == 0 {
		return nil, invalid("an invoice needs at least one line")
	}
	items := make([]invoices.Item, 0, len(in))
	for i, li := range in {
		if strings.TrimSpace(li.Description) == "" {
			return nil, invalid(fmt.Sprintf("line %d: description is required", i+1))
		}
		qty, err := money.ParseDecimal(li.Quantity, 3)
		if err != nil || qty <= 0 {
			return nil, invalid(fmt.Sprintf("line %d: quantity must be a positive number", i+1))
		}
		rate := li.VatRate
		if rate == "" {
			rate = "0"
		}
		bp, err := money.ParseDecimal(rate, 2)
		if err != nil || bp < 0 || bp > 10000 {
			return nil, invalid(fmt.Sprintf("line %d: VAT rate must be between 0 and 100", i+1))
		}
		items = append(items, invoices.Item{Position: i + 1, Description: strings.TrimSpace(li.Description), QuantityMilli: qty, UnitCents: li.UnitPriceCents, VatRateBp: bp})
	}
	invoices.Totals(items)
	return items, nil
}

func (s *Server) validateInvoiceRequest(ctx context.Context, req *pb.Invoice) (issue, due time.Time, cur string, err error) {
	if req.ProjectId == 0 {
		return issue, due, "", invalid("project is required")
	}
	var exists bool
	if err = s.DB.QueryRow(ctx, "SELECT EXISTS(SELECT 1 FROM projects WHERE id=$1 AND company_id=$2)", req.ProjectId, req.CompanyId).Scan(&exists); err != nil {
		return issue, due, "", internalErr(err)
	}
	if !exists {
		return issue, due, "", invalid("project not found")
	}
	if req.IssueDate == "" {
		req.IssueDate = time.Now().Format("2006-01-02")
	}
	if issue, err = parseDate(req.IssueDate); err != nil {
		return issue, due, "", invalid("issue_date must be YYYY-MM-DD")
	}
	if req.DueDate == "" {
		var days int
		_ = s.DB.QueryRow(ctx, "SELECT default_due_days FROM companies WHERE id=$1", req.CompanyId).Scan(&days)
		req.DueDate = issue.AddDate(0, 0, days).Format("2006-01-02")
	}
	if due, err = parseDate(req.DueDate); err != nil {
		return issue, due, "", invalid("due_date must be YYYY-MM-DD")
	}
	if due.Before(issue) {
		return issue, due, "", invalid("due date cannot be before the issue date")
	}
	cur, err = s.companyCurrency(ctx, req.CompanyId)
	if err != nil {
		return issue, due, "", internalErr(err)
	}
	return issue, due, cur, nil
}

func (s *Server) CreateInvoice(ctx context.Context, req *pb.Invoice) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	issue, due, cur, err := s.validateInvoiceRequest(ctx, req)
	if err != nil {
		return nil, err
	}
	items, err := parseItems(req.Items)
	if err != nil {
		return nil, err
	}
	sub, vat, total := invoices.Totals(items)
	var id int64
	err = db.WithTx(ctx, s.DB, func(tx pgx.Tx) error {
		err := tx.QueryRow(ctx, `INSERT INTO invoices (company_id, project_id, status, issue_date, due_date, currency, subtotal_cents, vat_cents, total_cents, notes, reference)
			VALUES ($1,$2,'draft',$3,$4,$5,$6,$7,$8,$9,$10) RETURNING id`,
			req.CompanyId, req.ProjectId, issue, due, cur, sub, vat, total, req.Notes, req.Reference).Scan(&id)
		if err != nil {
			return err
		}
		return insertItems(ctx, tx, id, items)
	})
	if err != nil {
		return nil, dbErr(err)
	}
	return s.getInvoice(ctx, req.CompanyId, uint64(id))
}

func insertItems(ctx context.Context, tx pgx.Tx, invoiceID int64, items []invoices.Item) error {
	for _, it := range items {
		_, err := tx.Exec(ctx, `INSERT INTO invoice_items (invoice_id, position, description, quantity_milli, unit_price_cents, vat_rate_bp, net_cents, vat_cents)
			VALUES ($1,$2,$3,$4,$5,$6,$7,$8)`, invoiceID, it.Position, it.Description, it.QuantityMilli, it.UnitCents, it.VatRateBp, it.NetCents, it.VatCents)
		if err != nil {
			return err
		}
	}
	return nil
}

func (s *Server) UpdateInvoice(ctx context.Context, req *pb.Invoice) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	cur, err := s.loadInvoice(ctx, s.DB, req.CompanyId, req.Id)
	if err != nil {
		return nil, dbErr(err)
	}
	if cur.Status != invoices.StatusDraft {
		return nil, status.Error(codes.FailedPrecondition, "only draft invoices can be edited")
	}
	issue, due, currency, err := s.validateInvoiceRequest(ctx, req)
	if err != nil {
		return nil, err
	}
	items, err := parseItems(req.Items)
	if err != nil {
		return nil, err
	}
	sub, vat, total := invoices.Totals(items)
	err = db.WithTx(ctx, s.DB, func(tx pgx.Tx) error {
		_, err := tx.Exec(ctx, `UPDATE invoices SET project_id=$3, issue_date=$4, due_date=$5, currency=$6, subtotal_cents=$7, vat_cents=$8, total_cents=$9, notes=$10, reference=$11
			WHERE id=$1 AND company_id=$2`, req.Id, req.CompanyId, req.ProjectId, issue, due, currency, sub, vat, total, req.Notes, req.Reference)
		if err != nil {
			return err
		}
		if _, err := tx.Exec(ctx, "DELETE FROM invoice_items WHERE invoice_id=$1", req.Id); err != nil {
			return err
		}
		return insertItems(ctx, tx, int64(req.Id), items)
	})
	if err != nil {
		return nil, dbErr(err)
	}
	return s.getInvoice(ctx, req.CompanyId, req.Id)
}

func (s *Server) ListInvoices(ctx context.Context, req *pb.ListInvoicesRequest) (*pb.ListInvoicesResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	limit, offset := pageArgs(req.Page, req.PageSize)
	st := string(statusFromPB(req.Status))
	where := `i.company_id=$1 AND ($2 = '' OR i.status=$2) AND ($3 = 0 OR i.project_id=$3) AND (NOT $4 OR (i.status='open' AND i.due_date < CURRENT_DATE))`
	args := []any{req.CompanyId, st, req.ProjectId, req.OnlyOverdue}
	var total uint32
	if err := s.DB.QueryRow(ctx, `SELECT COUNT(*) FROM invoices i WHERE `+where, args...).Scan(&total); err != nil {
		return nil, internalErr(err)
	}
	rows, err := s.DB.Query(ctx, `SELECT `+invoiceCols+` FROM invoices i JOIN projects p ON p.id=i.project_id WHERE `+where+
		` ORDER BY i.issue_date DESC, i.id DESC LIMIT $5 OFFSET $6`, append(args, limit, offset)...)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListInvoicesResponse{Total: total}
	for rows.Next() {
		inv, err := scanInvoice(rows)
		if err != nil {
			return nil, internalErr(err)
		}
		out.Items = append(out.Items, invoiceToPB(inv))
	}
	return out, nil
}

func (s *Server) GetInvoice(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	return s.getInvoice(ctx, req.CompanyId, req.Id)
}

func (s *Server) getInvoice(ctx context.Context, companyID, id uint64) (*pb.Invoice, error) {
	inv, err := s.loadInvoice(ctx, s.DB, companyID, id)
	if err != nil {
		return nil, dbErr(err)
	}
	return invoiceToPB(inv), nil
}

func (s *Server) IssueInvoice(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	err := db.WithTx(ctx, s.DB, func(tx pgx.Tx) error {
		var st string
		var number *string
		if err := tx.QueryRow(ctx, "SELECT status, number FROM invoices WHERE id=$1 AND company_id=$2 FOR UPDATE", req.Id, req.CompanyId).Scan(&st, &number); err != nil {
			return err
		}
		if st != string(invoices.StatusDraft) {
			return status.Error(codes.FailedPrecondition, "invoice is already issued")
		}
		num := ""
		if number != nil {
			num = *number
		}
		if num == "" {
			n, err := invoices.NextNumber(ctx, tx, int64(req.CompanyId))
			if err != nil {
				return err
			}
			num = n
		}
		_, err := tx.Exec(ctx, "UPDATE invoices SET status='open', number=$3 WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId, num)
		return err
	})
	if err != nil {
		if _, ok := status.FromError(err); ok {
			return nil, err
		}
		return nil, dbErr(err)
	}
	// Render and cache the PDF; failures are logged, not fatal.
	if _, err := s.renderInvoicePDF(ctx, req.CompanyId, req.Id); err != nil {
		slog.Warn("[INVOICE] pdf render failed", "invoice", req.Id, "err", err)
	}
	return s.getInvoice(ctx, req.CompanyId, req.Id)
}

func (s *Server) renderInvoicePDF(ctx context.Context, companyID, id uint64) ([]byte, error) {
	inv, err := s.loadInvoice(ctx, s.DB, companyID, id)
	if err != nil {
		return nil, err
	}
	var co invoices.Company
	err = s.DB.QueryRow(ctx, "SELECT name, reg_number, vat_number, address, email, phone, iban, bank_name FROM companies WHERE id=$1", companyID).
		Scan(&co.Name, &co.RegNumber, &co.VatNumber, &co.Address, &co.Email, &co.Phone, &co.IBAN, &co.BankName)
	if err != nil {
		return nil, err
	}
	var pr invoices.Project
	err = s.DB.QueryRow(ctx, "SELECT name, contact_name, email, address, reg_number, vat_number FROM projects WHERE id=$1", inv.ProjectID).
		Scan(&pr.Name, &pr.ContactName, &pr.Email, &pr.Address, &pr.RegNumber, &pr.VatNumber)
	if err != nil {
		return nil, err
	}
	if inv.Number == "" {
		inv.Number = fmt.Sprintf("DRAFT-%d", inv.ID)
	}
	data, err := invoices.RenderPDF(inv, co, pr)
	if err != nil {
		return nil, err
	}
	if inv.Status != invoices.StatusDraft {
		if err := s.Store.Write(s.Store.InvoicePDFPath(int64(companyID), inv.Number), data); err != nil {
			slog.Warn("[INVOICE] pdf cache write failed", "err", err)
		}
	}
	return data, nil
}

func (s *Server) GetInvoicePdf(ctx context.Context, req *pb.CompanyIdRequest) (*pb.FileResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	inv, err := s.loadInvoice(ctx, s.DB, req.CompanyId, req.Id)
	if err != nil {
		return nil, dbErr(err)
	}
	var data []byte
	if inv.Status != invoices.StatusDraft {
		data, _ = s.Store.Read(s.Store.InvoicePDFPath(int64(req.CompanyId), inv.Number))
	}
	if len(data) == 0 {
		if data, err = s.renderInvoicePDF(ctx, req.CompanyId, req.Id); err != nil {
			return nil, internalErr(err)
		}
	}
	name := inv.Number
	if name == "" {
		name = fmt.Sprintf("draft-%d", inv.ID)
	}
	return &pb.FileResponse{Data: data, Filename: "invoice-" + name + ".pdf", Mime: "application/pdf"}, nil
}

func (s *Server) SendInvoice(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if !s.Mail.Enabled() {
		return nil, status.Error(codes.FailedPrecondition, "email is not configured on this server (SMTP_HOST)")
	}
	inv, err := s.loadInvoice(ctx, s.DB, req.CompanyId, req.Id)
	if err != nil {
		return nil, dbErr(err)
	}
	if inv.Status == invoices.StatusDraft {
		return nil, status.Error(codes.FailedPrecondition, "issue the invoice before sending it")
	}
	var to, companyName string
	if err := s.DB.QueryRow(ctx, "SELECT email FROM projects WHERE id=$1", inv.ProjectID).Scan(&to); err != nil {
		return nil, dbErr(err)
	}
	if !validEmail(to) {
		return nil, status.Error(codes.FailedPrecondition, "the project has no email address")
	}
	_ = s.DB.QueryRow(ctx, "SELECT name FROM companies WHERE id=$1", req.CompanyId).Scan(&companyName)
	pdfBytes, err := s.renderInvoicePDF(ctx, req.CompanyId, req.Id)
	if err != nil {
		return nil, internalErr(err)
	}
	body := fmt.Sprintf("Hello,\n\nPlease find attached invoice %s from %s for %s, due on %s.\n\nPayment reference: %s\n\nKind regards,\n%s",
		inv.Number, companyName, money.Format(inv.TotalCents, inv.Currency), inv.DueDate.Format("02 Jan 2006"), inv.Number, companyName)
	subject := fmt.Sprintf("Invoice %s from %s", inv.Number, companyName)
	if err := s.Mail.Send(ctx, to, subject, body, mail.Attachment{Name: "invoice-" + inv.Number + ".pdf", Data: pdfBytes}); err != nil {
		slog.Error("[MAIL] invoice send failed", "err", err)
		return nil, status.Error(codes.Unavailable, "sending the email failed: "+err.Error())
	}
	if _, err := s.DB.Exec(ctx, "UPDATE invoices SET sent_at=now() WHERE id=$1", req.Id); err != nil {
		return nil, internalErr(err)
	}
	return s.getInvoice(ctx, req.CompanyId, req.Id)
}

func (s *Server) MarkInvoicePaid(ctx context.Context, req *pb.MarkInvoicePaidRequest) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	err := db.WithTx(ctx, s.DB, func(tx pgx.Tx) error {
		inv, err := s.loadInvoice(ctx, tx, req.CompanyId, req.Id)
		if err != nil {
			return err
		}
		if inv.Status != invoices.StatusOpen {
			return status.Error(codes.FailedPrecondition, "only open invoices can be marked as paid")
		}
		if req.TransactionId != 0 {
			return linkPayment(ctx, tx, req.CompanyId, req.Id, req.TransactionId)
		}
		paidAt := time.Now()
		if req.PaidDate != "" {
			if paidAt, err = parseDate(req.PaidDate); err != nil {
				return invalid("paid_date must be YYYY-MM-DD")
			}
		}
		_, err = tx.Exec(ctx, "UPDATE invoices SET status='paid', paid_at=$3, paid_transaction_id=NULL WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId, paidAt)
		return err
	})
	if err != nil {
		if _, ok := status.FromError(err); ok {
			return nil, err
		}
		return nil, dbErr(err)
	}
	return s.getInvoice(ctx, req.CompanyId, req.Id)
}

// linkPayment marks an invoice paid by a specific incoming transaction, inside the caller's tx.
func linkPayment(ctx context.Context, tx pgx.Tx, companyID, invoiceID, txID uint64) error {
	var booked time.Time
	var amount int64
	var linked *int64
	err := tx.QueryRow(ctx, "SELECT booked_at, amount_cents, invoice_id FROM bank_transactions WHERE id=$1 AND company_id=$2 FOR UPDATE", txID, companyID).Scan(&booked, &amount, &linked)
	if errors.Is(err, pgx.ErrNoRows) {
		return status.Error(codes.NotFound, "transaction not found")
	}
	if err != nil {
		return err
	}
	if amount <= 0 {
		return status.Error(codes.FailedPrecondition, "only incoming transactions can pay an invoice")
	}
	if linked != nil && uint64(*linked) != invoiceID {
		return status.Error(codes.FailedPrecondition, "transaction is already linked to another invoice")
	}
	if _, err := tx.Exec(ctx, "UPDATE invoices SET status='paid', paid_at=$3, paid_transaction_id=$4 WHERE id=$1 AND company_id=$2", invoiceID, companyID, booked, txID); err != nil {
		return err
	}
	_, err = tx.Exec(ctx, `UPDATE bank_transactions SET invoice_id=$2,
		category_id = COALESCE(category_id, (SELECT id FROM categories WHERE company_id=$3 AND kind='income' ORDER BY sort_order LIMIT 1)),
		status = CASE WHEN status='unexplained' THEN 'explained' ELSE status END
		WHERE id=$1`, txID, invoiceID, companyID)
	return err
}

func (s *Server) UnlinkInvoicePayment(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	err := db.WithTx(ctx, s.DB, func(tx pgx.Tx) error {
		var st string
		if err := tx.QueryRow(ctx, "SELECT status FROM invoices WHERE id=$1 AND company_id=$2 FOR UPDATE", req.Id, req.CompanyId).Scan(&st); err != nil {
			return err
		}
		if st != string(invoices.StatusPaid) {
			return status.Error(codes.FailedPrecondition, "invoice is not paid")
		}
		if _, err := tx.Exec(ctx, "UPDATE bank_transactions SET invoice_id=NULL WHERE invoice_id=$1", req.Id); err != nil {
			return err
		}
		_, err := tx.Exec(ctx, "UPDATE invoices SET status='open', paid_at=NULL, paid_transaction_id=NULL WHERE id=$1", req.Id)
		return err
	})
	if err != nil {
		if _, ok := status.FromError(err); ok {
			return nil, err
		}
		return nil, dbErr(err)
	}
	return s.getInvoice(ctx, req.CompanyId, req.Id)
}

func (s *Server) CancelInvoice(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Invoice, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	tag, err := s.DB.Exec(ctx, "UPDATE invoices SET status='cancelled' WHERE id=$1 AND company_id=$2 AND status IN ('draft','open')", req.Id, req.CompanyId)
	if err != nil {
		return nil, dbErr(err)
	}
	if tag.RowsAffected() == 0 {
		return nil, status.Error(codes.FailedPrecondition, "only draft or open invoices can be cancelled")
	}
	return s.getInvoice(ctx, req.CompanyId, req.Id)
}

func (s *Server) DeleteInvoice(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Empty, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	tag, err := s.DB.Exec(ctx, "DELETE FROM invoices WHERE id=$1 AND company_id=$2 AND status='draft'", req.Id, req.CompanyId)
	if err != nil {
		return nil, dbErr(err)
	}
	if tag.RowsAffected() == 0 {
		return nil, status.Error(codes.FailedPrecondition, "only draft invoices can be deleted")
	}
	return &pb.Empty{}, nil
}
