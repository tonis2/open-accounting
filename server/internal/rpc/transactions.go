package rpc

import (
	"context"
	"errors"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"open-accounting/server/internal/db"
	"open-accounting/server/internal/storage"
	"open-accounting/server/pb"
)

func txStatusToPB(s string) pb.TransactionStatus {
	switch s {
	case "unexplained":
		return pb.TransactionStatus_TRANSACTION_STATUS_UNEXPLAINED
	case "explained":
		return pb.TransactionStatus_TRANSACTION_STATUS_EXPLAINED
	case "approved":
		return pb.TransactionStatus_TRANSACTION_STATUS_APPROVED
	}
	return pb.TransactionStatus_TRANSACTION_STATUS_UNSPECIFIED
}

func txStatusFromPB(s pb.TransactionStatus) string {
	switch s {
	case pb.TransactionStatus_TRANSACTION_STATUS_UNEXPLAINED:
		return "unexplained"
	case pb.TransactionStatus_TRANSACTION_STATUS_EXPLAINED:
		return "explained"
	case pb.TransactionStatus_TRANSACTION_STATUS_APPROVED:
		return "approved"
	}
	return ""
}

const txCols = `t.id, t.account_id, t.company_id, t.booked_at, t.value_date, t.amount_cents, t.currency, t.description, t.counterparty_name, t.counterparty_iban,
	t.reference, COALESCE(t.category_id,0), COALESCE(c.name,''), t.note, t.status, COALESCE(t.invoice_id,0), COALESCE(i.number,''),
	(SELECT COUNT(*) FROM attachments at WHERE at.transaction_id=t.id), a.name`

const txJoins = ` FROM bank_transactions t JOIN bank_accounts a ON a.id=t.account_id
	LEFT JOIN categories c ON c.id=t.category_id LEFT JOIN invoices i ON i.id=t.invoice_id `

func scanTx(row pgx.Row, extra ...any) (*pb.Transaction, error) {
	var t pb.Transaction
	var booked time.Time
	var valueDate *time.Time
	var st string
	dest := []any{&t.Id, &t.AccountId, &t.CompanyId, &booked, &valueDate, &t.AmountCents, &t.Currency, &t.Description, &t.CounterpartyName, &t.CounterpartyIban,
		&t.Reference, &t.CategoryId, &t.CategoryName, &t.Note, &st, &t.InvoiceId, &t.InvoiceNumber, &t.AttachmentCount, &t.AccountName}
	dest = append(dest, extra...)
	if err := row.Scan(dest...); err != nil {
		return nil, err
	}
	t.BookedAt = tsv(booked)
	if valueDate != nil {
		t.ValueDate = dateStr(*valueDate)
	}
	t.Currency = strings.TrimSpace(t.Currency)
	t.Status = txStatusToPB(st)
	return &t, nil
}

func (s *Server) ListTransactions(ctx context.Context, req *pb.ListTransactionsRequest) (*pb.ListTransactionsResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	limit, offset := pageArgs(req.Page, req.PageSize)
	var monthStart, monthEnd *time.Time
	if req.Month != "" {
		t, err := time.Parse("2006-01", req.Month)
		if err != nil {
			return nil, invalid("month must be YYYY-MM")
		}
		end := t.AddDate(0, 1, 0)
		monthStart, monthEnd = &t, &end
	}
	search := "%" + strings.ToLower(strings.TrimSpace(req.Search)) + "%"
	where := ` WHERE t.company_id=$1 AND ($2 = 0 OR t.account_id=$2) AND ($3 = '' OR t.status=$3)
		AND ($4::timestamptz IS NULL OR t.booked_at >= $4) AND ($5::timestamptz IS NULL OR t.booked_at < $5)
		AND ($6 = '%%' OR lower(t.description) LIKE $6 OR lower(t.counterparty_name) LIKE $6 OR lower(t.reference) LIKE $6 OR lower(t.note) LIKE $6)`
	args := []any{req.CompanyId, req.AccountId, txStatusFromPB(req.Status), monthStart, monthEnd, search}

	out := &pb.ListTransactionsResponse{}
	if err := s.DB.QueryRow(ctx, "SELECT COUNT(*)"+txJoins+where, args...).Scan(&out.Total); err != nil {
		return nil, internalErr(err)
	}
	// Running balance only makes sense for one account: balance now minus everything booked later.
	running := "0"
	if req.AccountId != 0 {
		running = `a.balance_cents - COALESCE(SUM(t.amount_cents) OVER (ORDER BY t.booked_at DESC, t.id DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING), 0)`
		if monthStart != nil {
			// The month view starts from a brought-forward balance.
			_ = s.DB.QueryRow(ctx, `SELECT a.balance_cents - COALESCE((SELECT SUM(amount_cents) FROM bank_transactions WHERE account_id=a.id AND booked_at >= $2),0)
				FROM bank_accounts a WHERE a.id=$1`, req.AccountId, monthStart).Scan(&out.BalanceBroughtForwardCents)
		}
	}
	rows, err := s.DB.Query(ctx, "SELECT "+txCols+", "+running+txJoins+where+" ORDER BY t.booked_at DESC, t.id DESC LIMIT $7 OFFSET $8", append(args, limit, offset)...)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	for rows.Next() {
		var run int64
		t, err := scanTx(rows, &run)
		if err != nil {
			return nil, internalErr(err)
		}
		t.RunningBalanceCents = run
		out.Items = append(out.Items, t)
	}
	return out, nil
}

func (s *Server) getTransaction(ctx context.Context, companyID, id uint64) (*pb.Transaction, error) {
	t, err := scanTx(s.DB.QueryRow(ctx, "SELECT "+txCols+", 0::bigint"+txJoins+" WHERE t.id=$1 AND t.company_id=$2", id, companyID), new(int64))
	if err != nil {
		return nil, dbErr(err)
	}
	return t, nil
}

func (s *Server) ExplainTransaction(ctx context.Context, req *pb.ExplainTransactionRequest) (*pb.Transaction, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if req.CategoryId != 0 {
		var ok bool
		if err := s.DB.QueryRow(ctx, "SELECT EXISTS(SELECT 1 FROM categories WHERE id=$1 AND company_id=$2)", req.CategoryId, req.CompanyId).Scan(&ok); err != nil {
			return nil, internalErr(err)
		}
		if !ok {
			return nil, invalid("category not found")
		}
	}
	st := "explained"
	if req.Approve {
		st = "approved"
	}
	if req.CategoryId == 0 && !req.Approve {
		st = "unexplained"
	}
	tag, err := s.DB.Exec(ctx, `UPDATE bank_transactions SET category_id=NULLIF($3,0), note=$4, description=COALESCE(NULLIF($5,''), description), status=$6
		WHERE id=$1 AND company_id=$2`, req.Id, req.CompanyId, req.CategoryId, req.Note, strings.TrimSpace(req.Description), st)
	if err != nil {
		return nil, dbErr(err)
	}
	if tag.RowsAffected() == 0 {
		return nil, dbErr(pgx.ErrNoRows)
	}
	return s.getTransaction(ctx, req.CompanyId, req.Id)
}

func (s *Server) ApproveTransactions(ctx context.Context, req *pb.ApproveTransactionsRequest) (*pb.Empty, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if len(req.Ids) == 0 {
		return &pb.Empty{}, nil
	}
	ids := make([]int64, 0, len(req.Ids))
	for _, id := range req.Ids {
		ids = append(ids, int64(id))
	}
	_, err := s.DB.Exec(ctx, "UPDATE bank_transactions SET status='approved' WHERE company_id=$1 AND id = ANY($2) AND category_id IS NOT NULL", req.CompanyId, ids)
	if err != nil {
		return nil, dbErr(err)
	}
	return &pb.Empty{}, nil
}

func (s *Server) LinkTransactionToInvoice(ctx context.Context, req *pb.LinkTransactionRequest) (*pb.Transaction, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	err := db.WithTx(ctx, s.DB, func(tx pgx.Tx) error {
		if req.InvoiceId == 0 {
			var current *int64
			if err := tx.QueryRow(ctx, "SELECT invoice_id FROM bank_transactions WHERE id=$1 AND company_id=$2 FOR UPDATE", req.TransactionId, req.CompanyId).Scan(&current); err != nil {
				return err
			}
			if current == nil {
				return nil
			}
			if _, err := tx.Exec(ctx, "UPDATE invoices SET status='open', paid_at=NULL, paid_transaction_id=NULL WHERE id=$1 AND paid_transaction_id=$2", *current, req.TransactionId); err != nil {
				return err
			}
			_, err := tx.Exec(ctx, "UPDATE bank_transactions SET invoice_id=NULL WHERE id=$1", req.TransactionId)
			return err
		}
		var st string
		err := tx.QueryRow(ctx, "SELECT status FROM invoices WHERE id=$1 AND company_id=$2 FOR UPDATE", req.InvoiceId, req.CompanyId).Scan(&st)
		if errors.Is(err, pgx.ErrNoRows) {
			return status.Error(codes.NotFound, "invoice not found")
		}
		if err != nil {
			return err
		}
		if st != "open" {
			return status.Error(codes.FailedPrecondition, "only open invoices can be linked to a payment")
		}
		return linkPayment(ctx, tx, req.CompanyId, req.InvoiceId, req.TransactionId)
	})
	if err != nil {
		if _, ok := status.FromError(err); ok {
			return nil, err
		}
		return nil, dbErr(err)
	}
	return s.getTransaction(ctx, req.CompanyId, req.TransactionId)
}

// ---- attachments ----

func attachmentToPB(row pgx.Row) (*pb.Attachment, error) {
	var a pb.Attachment
	var txID, invID *int64
	var created time.Time
	if err := row.Scan(&a.Id, &a.CompanyId, &txID, &invID, &a.Filename, &a.Mime, &a.SizeBytes, &created); err != nil {
		return nil, err
	}
	a.TransactionId = ptrInt64(txID)
	a.InvoiceId = ptrInt64(invID)
	a.CreatedAt = tsv(created)
	return &a, nil
}

const attachmentCols = "id, company_id, transaction_id, invoice_id, filename, mime, size_bytes, created_at"

func (s *Server) UploadAttachment(ctx context.Context, req *pb.UploadAttachmentRequest) (*pb.Attachment, error) {
	uid, _, err := s.requireMember(ctx, req.CompanyId)
	if err != nil {
		return nil, err
	}
	if (req.TransactionId == 0) == (req.InvoiceId == 0) {
		return nil, invalid("attach to exactly one transaction or invoice")
	}
	if len(req.Data) == 0 {
		return nil, invalid("empty file")
	}
	if len(req.Data) > storage.MaxAttachmentBytes {
		return nil, invalid("file exceeds 10 MB")
	}
	mime, ext, err := storage.DetectMime(req.Data)
	if err != nil {
		return nil, invalid("only PDF, JPEG, PNG and WebP files are supported")
	}
	var ok bool
	if req.TransactionId != 0 {
		err = s.DB.QueryRow(ctx, "SELECT EXISTS(SELECT 1 FROM bank_transactions WHERE id=$1 AND company_id=$2)", req.TransactionId, req.CompanyId).Scan(&ok)
	} else {
		err = s.DB.QueryRow(ctx, "SELECT EXISTS(SELECT 1 FROM invoices WHERE id=$1 AND company_id=$2)", req.InvoiceId, req.CompanyId).Scan(&ok)
	}
	if err != nil {
		return nil, internalErr(err)
	}
	if !ok {
		return nil, status.Error(codes.NotFound, "target not found")
	}
	rel, err := s.Store.SaveAttachment(int64(req.CompanyId), ext, req.Data)
	if err != nil {
		return nil, internalErr(err)
	}
	name := strings.TrimSpace(req.Filename)
	if name == "" {
		name = "attachment" + ext
	}
	row := s.DB.QueryRow(ctx, `INSERT INTO attachments (company_id, transaction_id, invoice_id, filename, path, mime, size_bytes, uploaded_by)
		VALUES ($1, NULLIF($2,0), NULLIF($3,0), $4, $5, $6, $7, $8) RETURNING `+attachmentCols,
		req.CompanyId, req.TransactionId, req.InvoiceId, name, rel, mime, len(req.Data), uid)
	a, err := attachmentToPB(row)
	if err != nil {
		_ = s.Store.Delete(rel)
		return nil, dbErr(err)
	}
	return a, nil
}

func (s *Server) ListAttachments(ctx context.Context, req *pb.ListAttachmentsRequest) (*pb.ListAttachmentsResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, `SELECT `+attachmentCols+` FROM attachments WHERE company_id=$1
		AND ($2 = 0 OR transaction_id=$2) AND ($3 = 0 OR invoice_id=$3) ORDER BY created_at`, req.CompanyId, req.TransactionId, req.InvoiceId)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListAttachmentsResponse{}
	for rows.Next() {
		a, err := attachmentToPB(rows)
		if err != nil {
			return nil, internalErr(err)
		}
		out.Items = append(out.Items, a)
	}
	return out, nil
}

func (s *Server) GetAttachment(ctx context.Context, req *pb.CompanyIdRequest) (*pb.FileResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	var path, name, mime string
	err := s.DB.QueryRow(ctx, "SELECT path, filename, mime FROM attachments WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId).Scan(&path, &name, &mime)
	if err != nil {
		return nil, dbErr(err)
	}
	data, err := s.Store.Read(path)
	if err != nil {
		return nil, internalErr(err)
	}
	return &pb.FileResponse{Data: data, Filename: name, Mime: mime}, nil
}

func (s *Server) DeleteAttachment(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Empty, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	var path string
	err := s.DB.QueryRow(ctx, "DELETE FROM attachments WHERE id=$1 AND company_id=$2 RETURNING path", req.Id, req.CompanyId).Scan(&path)
	if err != nil {
		return nil, dbErr(err)
	}
	_ = s.Store.Delete(path)
	return &pb.Empty{}, nil
}
