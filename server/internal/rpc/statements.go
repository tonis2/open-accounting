package rpc

import (
	"context"
	"errors"
	"strings"

	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/statements"
	"open-accounting/server/internal/sync"
	"open-accounting/server/pb"
)

const maxStatementBytes = 20 * 1024 * 1024

// UploadStatement imports a CSV bank statement into an account. Rows are keyed by the bank's
// transaction id (or a content hash), so re-uploading an overlapping file only adds new rows.
func (s *Server) UploadStatement(ctx context.Context, req *pb.UploadStatementRequest) (*pb.UploadStatementResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if len(req.Data) == 0 {
		return nil, invalid("empty file")
	}
	if len(req.Data) > maxStatementBytes {
		return nil, invalid("statement exceeds 20 MB")
	}
	var currency, provider string
	var connID int64
	var enc []byte
	err := s.DB.QueryRow(ctx, `SELECT a.currency, a.connection_id, c.provider, c.config_enc FROM bank_accounts a JOIN bank_connections c ON c.id=a.connection_id
		WHERE a.id=$1 AND a.company_id=$2`, req.AccountId, req.CompanyId).Scan(&currency, &connID, &provider, &enc)
	if err != nil {
		return nil, dbErr(err)
	}
	currency = strings.TrimSpace(currency)

	res, err := statements.Parse(req.Data, currency)
	if errors.Is(err, statements.ErrNoHeader) {
		return nil, status.Error(codes.InvalidArgument, "could not recognise the file: it needs a header row with at least a date and an amount column")
	}
	if err != nil {
		return nil, status.Error(codes.InvalidArgument, "could not read the CSV: "+err.Error())
	}
	if len(res.Transactions) == 0 {
		return nil, status.Error(codes.InvalidArgument, "no transactions found in the file")
	}

	out := &pb.UploadStatementResponse{Skipped: uint32(res.Skipped), Warnings: res.Warnings}
	for _, t := range res.Transactions {
		var inserted bool
		err := s.DB.QueryRow(ctx, `INSERT INTO bank_transactions (account_id, company_id, external_id, booked_at, value_date, amount_cents, currency, description, counterparty_name, counterparty_iban, reference, raw)
			VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
			ON CONFLICT (account_id, external_id) DO UPDATE SET external_id = EXCLUDED.external_id
			RETURNING (xmax = 0)`,
			req.AccountId, req.CompanyId, t.ExternalID, t.BookedAt, t.ValueDate, t.AmountCents, currency, t.Description, t.CounterpartyName, t.CounterpartyIBAN, t.Reference, t.Raw).Scan(&inserted)
		if err != nil {
			return nil, internalErr(err)
		}
		if inserted {
			out.Imported++
		} else {
			out.Duplicates++
		}
	}

	// Upload-only accounts derive their balance from the rows; API accounts keep the API balance.
	if p, ok := s.Banks.Get(provider); ok {
		if bp, ok := p.(banks.BalanceFromTransactions); ok && bp.BalanceFromTransactions() {
			cfg, _ := s.openConfig(enc)
			sync.RecomputeBalance(ctx, s.DB, int64(req.AccountId), cfg["opening_balance"])
		} else if res.LastBalanceCents != nil {
			_, _ = s.DB.Exec(ctx, `UPDATE bank_accounts SET balance_cents=$2, balance_at=now() WHERE id=$1 AND (balance_at IS NULL OR balance_at < now() - interval '1 day')`, req.AccountId, *res.LastBalanceCents)
		}
	}
	_, _ = s.DB.Exec(ctx, "UPDATE bank_accounts SET last_sync_at=now() WHERE id=$1", req.AccountId)
	_, _ = s.DB.Exec(ctx, "UPDATE bank_connections SET last_sync_at=now(), status = CASE WHEN status='error' THEN 'active' ELSE status END, status_message='' WHERE id=$1", connID)

	matched, err := sync.MatchInvoices(ctx, s.DB, int64(req.CompanyId))
	if err != nil {
		return nil, internalErr(err)
	}
	out.InvoicesMatched = uint32(matched)
	return out, nil
}
