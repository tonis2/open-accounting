package rpc

import (
	"context"
	"time"

	"open-accounting/server/pb"
)

// GetOverview aggregates everything the home page shows in one call.
func (s *Server) GetOverview(ctx context.Context, req *pb.OverviewRequest) (*pb.OverviewResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	months := int(req.Months)
	if months <= 0 || months > 60 {
		months = 12
	}
	cur, err := s.companyCurrency(ctx, req.CompanyId)
	if err != nil {
		return nil, internalErr(err)
	}
	out := &pb.OverviewResponse{Currency: cur}

	// Cashflow per month over accounts in the company currency.
	rows, err := s.DB.Query(ctx, `
		WITH months AS (
			SELECT generate_series(date_trunc('month', now()) - make_interval(months => $3::int), date_trunc('month', now()), '1 month') AS m
		)
		SELECT to_char(m, 'YYYY-MM'),
			COALESCE((SELECT SUM(t.amount_cents) FROM bank_transactions t JOIN bank_accounts a ON a.id=t.account_id
				WHERE a.company_id=$1 AND a.currency=$2 AND t.amount_cents > 0 AND t.booked_at >= m AND t.booked_at < m + interval '1 month'), 0),
			COALESCE((SELECT -SUM(t.amount_cents) FROM bank_transactions t JOIN bank_accounts a ON a.id=t.account_id
				WHERE a.company_id=$1 AND a.currency=$2 AND t.amount_cents < 0 AND t.booked_at >= m AND t.booked_at < m + interval '1 month'), 0)
		FROM months ORDER BY m`, req.CompanyId, cur, months-1)
	if err != nil {
		return nil, internalErr(err)
	}
	for rows.Next() {
		var p pb.CashflowPoint
		if err := rows.Scan(&p.Month, &p.InCents, &p.OutCents); err != nil {
			rows.Close()
			return nil, internalErr(err)
		}
		out.IncomingCents += p.InCents
		out.OutgoingCents += p.OutCents
		out.Cashflow = append(out.Cashflow, &p)
	}
	rows.Close()
	out.IncomeCents = out.IncomingCents
	out.ExpensesCents = out.OutgoingCents

	out.BalanceHistory, err = s.balanceHistory(ctx, req.CompanyId, 0, cur, months)
	if err != nil {
		return nil, internalErr(err)
	}
	if n := len(out.BalanceHistory); n > 0 {
		out.TotalBalanceCents = out.BalanceHistory[n-1].BalanceCents
	}

	// Invoice timeline by due month: three months back, two ahead.
	rows, err = s.DB.Query(ctx, `
		WITH months AS (
			SELECT generate_series(date_trunc('month', now()) - interval '3 months', date_trunc('month', now()) + interval '2 months', '1 month') AS m
		)
		SELECT to_char(m, 'YYYY-MM'),
			COALESCE((SELECT SUM(total_cents) FROM invoices WHERE company_id=$1 AND status='paid' AND due_date >= m AND due_date < m + interval '1 month'), 0),
			COALESCE((SELECT SUM(total_cents) FROM invoices WHERE company_id=$1 AND status='open' AND due_date >= CURRENT_DATE AND due_date >= m AND due_date < m + interval '1 month'), 0),
			COALESCE((SELECT SUM(total_cents) FROM invoices WHERE company_id=$1 AND status='open' AND due_date < CURRENT_DATE AND due_date >= m AND due_date < m + interval '1 month'), 0)
		FROM months ORDER BY m`, req.CompanyId)
	if err != nil {
		return nil, internalErr(err)
	}
	for rows.Next() {
		var p pb.InvoiceTimelinePoint
		if err := rows.Scan(&p.Month, &p.PaidCents, &p.DueCents, &p.OverdueCents); err != nil {
			rows.Close()
			return nil, internalErr(err)
		}
		out.InvoiceTimeline = append(out.InvoiceTimeline, &p)
	}
	rows.Close()

	err = s.DB.QueryRow(ctx, `SELECT
		COALESCE((SELECT SUM(total_cents) FROM invoices WHERE company_id=$1 AND status='open'),0),
		(SELECT COUNT(*) FROM bank_transactions WHERE company_id=$1 AND status='explained'),
		(SELECT COUNT(*) FROM bank_transactions WHERE company_id=$1 AND status='unexplained'),
		EXISTS(SELECT 1 FROM bank_accounts WHERE company_id=$1),
		EXISTS(SELECT 1 FROM bank_connections WHERE company_id=$1 AND (status='expired' OR (consent_expires_at IS NOT NULL AND consent_expires_at < $2)))`,
		req.CompanyId, time.Now().Add(72*time.Hour)).
		Scan(&out.OutstandingCents, &out.ForApprovalCount, &out.UnexplainedCount, &out.HasBankAccounts, &out.HasExpiredConnections)
	if err != nil {
		return nil, internalErr(err)
	}
	return out, nil
}
