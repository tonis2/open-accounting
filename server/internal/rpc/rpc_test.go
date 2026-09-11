package rpc

import (
	"context"
	"net/http"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/go-webauthn/webauthn/webauthn"
	"github.com/jackc/pgx/v5/pgxpool"

	"open-accounting/server/internal/auth"
	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/banks/manual"
	"open-accounting/server/internal/banks/mock"
	"open-accounting/server/internal/config"
	"open-accounting/server/internal/crypto"
	"open-accounting/server/internal/db"
	"open-accounting/server/internal/storage"
	"open-accounting/server/internal/sync"
	"open-accounting/server/pb"
)

// newTestServer wires a Server against TEST_POSTGRES_URL (skipped when unset) with a clean schema.
func newTestServer(t *testing.T) (*Server, context.Context) {
	t.Helper()
	url := os.Getenv("TEST_POSTGRES_URL")
	if url == "" {
		t.Skip("TEST_POSTGRES_URL not set")
	}
	ctx := context.Background()
	pool, err := pgxpool.New(ctx, url)
	if err != nil {
		t.Fatal(err)
	}
	t.Cleanup(pool.Close)
	if _, err := pool.Exec(ctx, "DROP SCHEMA public CASCADE; CREATE SCHEMA public"); err != nil {
		t.Fatal(err)
	}
	if err := db.Migrate(ctx, pool); err != nil {
		t.Fatal(err)
	}
	box, _ := crypto.NewBox(make([]byte, 32))
	store, err := storage.New(t.TempDir())
	if err != nil {
		t.Fatal(err)
	}
	wa, _ := webauthn.New(&webauthn.Config{RPID: "localhost", RPDisplayName: "test", RPOrigins: []string{"http://localhost"}})
	reg := banks.NewRegistry()
	m := mock.New()
	m.InvoiceHints = func(ctx context.Context, cfg banks.Config) []mock.InvoiceHint {
		rows, err := pool.Query(ctx, `SELECT i.number, i.total_cents, i.currency, p.name FROM invoices i JOIN projects p ON p.id=i.project_id WHERE i.status='open' AND i.number IS NOT NULL`)
		if err != nil {
			return nil
		}
		defer rows.Close()
		var out []mock.InvoiceHint
		for rows.Next() {
			var h mock.InvoiceHint
			_ = rows.Scan(&h.Number, &h.TotalCents, &h.Currency, &h.Payer)
			h.Currency = strings.TrimSpace(h.Currency)
			out = append(out, h)
		}
		return out
	}
	reg.Register(m)
	reg.Register(manual.New())
	runner := &sync.Runner{DB: pool, Banks: reg, Box: box}
	s := &Server{
		DB: pool, Cfg: config.Config{AllowRegistration: true, PublicURL: "http://localhost"}, Tokens: auth.NewTokens("test-secret-test-secret"),
		Limiter: auth.NewLimiter(100, time.Minute), WebAuthn: wa, Sessions: auth.NewSessions(), Box: box, Store: store, Banks: reg, Sync: runner,
	}
	_ = http.DefaultClient
	return s, ctx
}

func TestEndToEndFlow(t *testing.T) {
	s, ctx := newTestServer(t)

	// Register + login
	authResp, err := s.Register(ctx, &pb.RegisterRequest{Email: "Owner@Example.com", Name: "Owner", Password: "supersecret"})
	if err != nil {
		t.Fatal(err)
	}
	if authResp.Token == "" || authResp.User.Email != "owner@example.com" {
		t.Fatalf("unexpected auth response %+v", authResp)
	}
	if _, err := s.Login(ctx, &pb.LoginRequest{Email: "owner@example.com", Password: "wrong"}); err == nil {
		t.Fatal("wrong password must fail")
	}
	uid, err := s.Tokens.Parse(authResp.Token)
	if err != nil {
		t.Fatal(err)
	}
	ctx = auth.WithUserID(ctx, uid)

	// Company with seeded categories
	co, err := s.CreateCompany(ctx, &pb.Company{Name: "Internus OÜ", Iban: "EE001234567890", DefaultVatRate: "24"})
	if err != nil {
		t.Fatal(err)
	}
	cats, err := s.ListCategories(ctx, &pb.CompanyRequest{CompanyId: co.Id})
	if err != nil || len(cats.Items) == 0 {
		t.Fatalf("categories: %v", err)
	}
	companies, _ := s.ListCompanies(ctx, &pb.Empty{})
	if len(companies.Items) != 1 || companies.Items[0].Role != "owner" {
		t.Fatalf("companies %+v", companies.Items)
	}

	// A second user must not see the company
	other, _ := s.Register(ctx, &pb.RegisterRequest{Email: "other@example.com", Name: "Other", Password: "supersecret"})
	otherID, _ := s.Tokens.Parse(other.Token)
	if _, err := s.GetCompany(auth.WithUserID(context.Background(), otherID), &pb.CompanyRequest{CompanyId: co.Id}); err == nil {
		t.Fatal("other user must be denied")
	}

	// Project + invoice
	pr, err := s.CreateProject(ctx, &pb.Project{CompanyId: co.Id, Name: "Paysure Solutions Ltd", Email: "ap@paysure.example"})
	if err != nil {
		t.Fatal(err)
	}
	inv, err := s.CreateInvoice(ctx, &pb.Invoice{CompanyId: co.Id, ProjectId: pr.Id, IssueDate: time.Now().AddDate(0, 0, -5).Format("2006-01-02"),
		Items: []*pb.InvoiceItem{
			{Description: "Consulting", Quantity: "10", UnitPriceCents: 8000, VatRate: "24"},
			{Description: "Hosting", Quantity: "1", UnitPriceCents: 4900, VatRate: "24"},
		}})
	if err != nil {
		t.Fatal(err)
	}
	if inv.Status != pb.InvoiceStatus_INVOICE_STATUS_DRAFT || inv.TotalCents != 105_276 || inv.Number != "" {
		t.Fatalf("draft %+v", inv)
	}
	inv, err = s.IssueInvoice(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: inv.Id})
	if err != nil {
		t.Fatal(err)
	}
	if inv.Number != "INV-0001" || inv.Status != pb.InvoiceStatus_INVOICE_STATUS_OPEN {
		t.Fatalf("issued %+v", inv)
	}
	if _, err := s.UpdateInvoice(ctx, inv); err == nil {
		t.Fatal("issued invoice must not be editable")
	}
	pdf, err := s.GetInvoicePdf(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: inv.Id})
	if err != nil || !strings.HasPrefix(string(pdf.Data), "%PDF") {
		t.Fatalf("pdf: %v", err)
	}
	if _, err := s.SendInvoice(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: inv.Id}); err == nil {
		t.Fatal("send without SMTP must fail with a clear error")
	}

	// Mock bank connection → sync → invoice matched
	providers, _ := s.ListBankProviders(ctx, &pb.Empty{})
	if len(providers.Items) != 2 || providers.Items[0].Id != "mock" {
		t.Fatalf("providers %+v", providers.Items)
	}
	connResp, err := s.CreateBankConnection(ctx, &pb.CreateBankConnectionRequest{CompanyId: co.Id, Provider: "mock", Name: "Demo", Config: map[string]string{"seed": "test"}})
	if err != nil {
		t.Fatal(err)
	}
	if connResp.RedirectUrl != "" || connResp.Connection.Status != pb.ConnectionStatus_CONNECTION_STATUS_ACTIVE || connResp.Connection.AccountCount != 2 {
		t.Fatalf("connection %+v", connResp.Connection)
	}
	accounts, _ := s.ListBankAccounts(ctx, &pb.CompanyRequest{CompanyId: co.Id})
	if len(accounts.Items) != 2 || !accounts.Items[0].IsPrimary {
		t.Fatalf("accounts %+v", accounts.Items)
	}
	txs, err := s.ListTransactions(ctx, &pb.ListTransactionsRequest{CompanyId: co.Id, AccountId: accounts.Items[0].Id, PageSize: 20})
	if err != nil || len(txs.Items) == 0 || txs.Total == 0 {
		t.Fatalf("transactions: %v total=%d", err, txs.GetTotal())
	}
	if txs.Items[0].RunningBalanceCents != accounts.Items[0].BalanceCents {
		t.Fatalf("running balance of latest row %d != account balance %d", txs.Items[0].RunningBalanceCents, accounts.Items[0].BalanceCents)
	}
	inv, _ = s.GetInvoice(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: inv.Id})
	if inv.Status != pb.InvoiceStatus_INVOICE_STATUS_PAID || inv.PaidTransactionId == 0 {
		t.Fatalf("invoice should be auto-matched: %+v", inv)
	}
	linked, _ := s.getTransaction(ctx, co.Id, inv.PaidTransactionId)
	if linked.InvoiceId != inv.Id || linked.Status != pb.TransactionStatus_TRANSACTION_STATUS_EXPLAINED || linked.CategoryId == 0 {
		t.Fatalf("linked tx %+v", linked)
	}

	// Unlink → open again; manual mark paid
	inv, err = s.UnlinkInvoicePayment(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: inv.Id})
	if err != nil || inv.Status != pb.InvoiceStatus_INVOICE_STATUS_OPEN {
		t.Fatalf("unlink: %v %+v", err, inv)
	}
	inv, err = s.MarkInvoicePaid(ctx, &pb.MarkInvoicePaidRequest{CompanyId: co.Id, Id: inv.Id, TransactionId: linked.Id})
	if err != nil || inv.Status != pb.InvoiceStatus_INVOICE_STATUS_PAID {
		t.Fatalf("mark paid: %v", err)
	}

	// Explain + approve + attachment
	var expense *pb.Transaction
	for _, tx := range txs.Items {
		if tx.AmountCents < 0 {
			expense = tx
			break
		}
	}
	var expenseCat uint64
	for _, c := range cats.Items {
		if c.Kind == pb.CategoryKind_CATEGORY_KIND_EXPENSE {
			expenseCat = c.Id
			break
		}
	}
	explained, err := s.ExplainTransaction(ctx, &pb.ExplainTransactionRequest{CompanyId: co.Id, Id: expense.Id, CategoryId: expenseCat, Note: "receipt attached"})
	if err != nil || explained.Status != pb.TransactionStatus_TRANSACTION_STATUS_EXPLAINED {
		t.Fatalf("explain: %v", err)
	}
	att, err := s.UploadAttachment(ctx, &pb.UploadAttachmentRequest{CompanyId: co.Id, TransactionId: expense.Id, Filename: "receipt.pdf", Data: pdf.Data})
	if err != nil || att.Mime != "application/pdf" {
		t.Fatalf("attachment: %v", err)
	}
	got, err := s.GetAttachment(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: att.Id})
	if err != nil || len(got.Data) != len(pdf.Data) {
		t.Fatalf("get attachment: %v", err)
	}
	if _, err := s.ApproveTransactions(ctx, &pb.ApproveTransactionsRequest{CompanyId: co.Id, Ids: []uint64{expense.Id}}); err != nil {
		t.Fatal(err)
	}
	after, _ := s.getTransaction(ctx, co.Id, expense.Id)
	if after.Status != pb.TransactionStatus_TRANSACTION_STATUS_APPROVED || after.AttachmentCount != 1 {
		t.Fatalf("approved tx %+v", after)
	}

	// Overview + balance history
	ov, err := s.GetOverview(ctx, &pb.OverviewRequest{CompanyId: co.Id, Months: 6})
	if err != nil {
		t.Fatal(err)
	}
	if len(ov.Cashflow) != 6 || len(ov.BalanceHistory) != 6 || !ov.HasBankAccounts || ov.IncomingCents == 0 {
		t.Fatalf("overview %+v", ov)
	}
	if ov.BalanceHistory[5].BalanceCents != accounts.Items[0].BalanceCents {
		t.Fatalf("current month balance %d != EUR account %d", ov.BalanceHistory[5].BalanceCents, accounts.Items[0].BalanceCents)
	}

	// Second sync is idempotent
	syncResp, err := s.SyncNow(ctx, &pb.CompanyRequest{CompanyId: co.Id})
	if err != nil || syncResp.TransactionsAdded != 0 || len(syncResp.Errors) != 0 {
		t.Fatalf("resync %+v err=%v", syncResp, err)
	}

	// Upload-only account: CSV statement import, de-duplication, derived balance, matching
	manualConn, err := s.CreateBankConnection(ctx, &pb.CreateBankConnectionRequest{CompanyId: co.Id, Provider: "manual", Name: "LHV", Config: map[string]string{"account_name": "LHV business", "currency": "EUR", "opening_balance": "100.00"}})
	if err != nil {
		t.Fatal(err)
	}
	if !manualConn.Connection.StatementsOnly {
		t.Fatal("manual connection should be statements-only")
	}
	accounts, _ = s.ListBankAccounts(ctx, &pb.CompanyRequest{CompanyId: co.Id})
	var manualAcct *pb.BankAccount
	for _, a := range accounts.Items {
		if a.ConnectionId == manualConn.Connection.Id {
			manualAcct = a
		}
	}
	if manualAcct == nil || manualAcct.BalanceCents != 10000 {
		t.Fatalf("manual account %+v", manualAcct)
	}
	inv2, err := s.CreateInvoice(ctx, &pb.Invoice{CompanyId: co.Id, ProjectId: pr.Id, IssueDate: time.Now().AddDate(0, 0, -3).Format("2006-01-02"),
		Items: []*pb.InvoiceItem{{Description: "Consulting", Quantity: "1", UnitPriceCents: 100000, VatRate: "24"}}})
	if err != nil {
		t.Fatal(err)
	}
	inv2, _ = s.IssueInvoice(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: inv2.Id})
	csvData := "Date,Amount,Currency,Description,Payment Reference,Payer Name\n" +
		time.Now().Format("2006-01-02") + ",-12.50,EUR,Card fee,,\n" +
		time.Now().Format("2006-01-02") + ",1240.00,EUR,Incoming payment," + inv2.Number + ",Paysure Solutions Ltd\n"
	up, err := s.UploadStatement(ctx, &pb.UploadStatementRequest{CompanyId: co.Id, AccountId: manualAcct.Id, Filename: "statement.csv", Data: []byte(csvData)})
	if err != nil {
		t.Fatal(err)
	}
	if up.Imported != 2 || up.Duplicates != 0 || up.InvoicesMatched != 1 {
		t.Fatalf("upload %+v", up)
	}
	again, _ := s.UploadStatement(ctx, &pb.UploadStatementRequest{CompanyId: co.Id, AccountId: manualAcct.Id, Filename: "statement.csv", Data: []byte(csvData)})
	if again.Imported != 0 || again.Duplicates != 2 {
		t.Fatalf("re-upload %+v", again)
	}
	accounts, _ = s.ListBankAccounts(ctx, &pb.CompanyRequest{CompanyId: co.Id})
	for _, a := range accounts.Items {
		if a.Id == manualAcct.Id && a.BalanceCents != 10000-1250+124000 {
			t.Fatalf("derived balance %d", a.BalanceCents)
		}
	}
	inv2, _ = s.GetInvoice(ctx, &pb.CompanyIdRequest{CompanyId: co.Id, Id: inv2.Id})
	if inv2.Status != pb.InvoiceStatus_INVOICE_STATUS_PAID {
		t.Fatalf("uploaded payment should match invoice: %v", inv2.Status)
	}

	// Passkey ceremony can start (full verification needs a browser authenticator)
	opts, err := s.BeginPasskeyRegistration(ctx, &pb.Empty{})
	if err != nil || !strings.Contains(opts.OptionsJson, `"publicKey"`) || !strings.Contains(opts.OptionsJson, `"rp"`) {
		t.Fatalf("passkey options: %v %s", err, opts.GetOptionsJson())
	}
	login, err := s.BeginPasskeyLogin(context.Background(), &pb.BeginPasskeyLoginRequest{Email: "nobody@example.com"})
	if err != nil || !strings.Contains(login.OptionsJson, `"challenge"`) {
		t.Fatalf("discoverable login options: %v", err)
	}
}

// choosyProvider behaves like the manual provider but needs a profile picked first.
type choosyProvider struct{ banks.Provider }

func (choosyProvider) ID() string { return "choosy" }

func (c choosyProvider) ConfigFields() []banks.ConfigField {
	return append(c.Provider.ConfigFields(), banks.ConfigField{Key: "profile_id", Label: "Profile ID", Kind: banks.FieldText})
}

func (c choosyProvider) Connect(ctx context.Context, cfg banks.Config, cb string) (banks.ConnectResult, error) {
	if cfg["profile_id"] != "1" && cfg["profile_id"] != "2" {
		return banks.ConnectResult{}, &banks.ChoiceRequired{Field: "profile_id", Label: "Profile", Options: []banks.Option{{Value: "1", Label: "One"}, {Value: "2", Label: "Two"}}}
	}
	return c.Provider.Connect(ctx, cfg, cb)
}

func TestCreateConnectionChoice(t *testing.T) {
	s, ctx := newTestServer(t)
	s.Banks.Register(choosyProvider{manual.New()})
	authResp, err := s.Register(ctx, &pb.RegisterRequest{Email: "choice@example.com", Name: "C", Password: "supersecret"})
	if err != nil {
		t.Fatal(err)
	}
	uid, _ := s.Tokens.Parse(authResp.Token)
	ctx = auth.WithUserID(ctx, uid)
	co, err := s.CreateCompany(ctx, &pb.Company{Name: "Choice OÜ"})
	if err != nil {
		t.Fatal(err)
	}
	req := &pb.CreateBankConnectionRequest{CompanyId: co.Id, Provider: "choosy", Config: map[string]string{"account_name": "Main"}}
	res, err := s.CreateBankConnection(ctx, req)
	if err != nil {
		t.Fatal(err)
	}
	if res.Connection != nil || res.Choice == nil || res.Choice.Key != "profile_id" || len(res.Choice.Options) != 2 || res.Choice.Options[1].Label != "Two" {
		t.Fatalf("expected a choice, got %+v", res)
	}
	conns, _ := s.ListBankConnections(ctx, &pb.CompanyRequest{CompanyId: co.Id})
	if len(conns.Items) != 0 {
		t.Fatalf("no connection should exist yet, got %d", len(conns.Items))
	}
	req.Config["profile_id"] = "2"
	res, err = s.CreateBankConnection(ctx, req)
	if err != nil || res.Connection == nil || res.Choice != nil {
		t.Fatalf("connect with choice: %+v %v", res, err)
	}
	if res.Connection.Config["profile_id"] != "2" {
		t.Fatalf("chosen value must be stored, got %q", res.Connection.Config["profile_id"])
	}

	// Editing with a stale profile asks again; nothing is saved until it is answered.
	upd := &pb.UpdateBankConnectionRequest{CompanyId: co.Id, Id: res.Connection.Id, Config: map[string]string{"profile_id": "stale"}}
	ures, err := s.UpdateBankConnection(ctx, upd)
	if err != nil || ures.Connection != nil || ures.Choice == nil || ures.Choice.Key != "profile_id" {
		t.Fatalf("update should return a choice, got %+v %v", ures, err)
	}
	upd.Config["profile_id"] = "1"
	ures, err = s.UpdateBankConnection(ctx, upd)
	if err != nil || ures.Connection == nil || ures.Connection.Config["profile_id"] != "1" {
		t.Fatalf("update with choice: %+v %v", ures, err)
	}
}
