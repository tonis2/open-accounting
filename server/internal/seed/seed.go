package seed

import (
	"context"
	"errors"
	"fmt"
	"time"

	"github.com/jackc/pgx/v5"
	"google.golang.org/protobuf/proto"

	"open-accounting/server/internal/auth"
	"open-accounting/server/internal/rpc"
	"open-accounting/server/pb"
)

// Options describe the demo account to create. Every step is idempotent, so re-running only
// adds what is missing.
type Options struct {
	Email    string
	Password string
	Name     string
	Company  string
}

func Defaults() Options {
	return Options{Email: "demo@example.com", Password: "demo1234", Name: "Demo User", Company: "Internus OÜ"}
}

type Summary struct {
	Created      bool
	CompanyID    uint64
	Projects     int
	Invoices     int
	Transactions int
}

// Run creates a user, company, projects, invoices in several states and a connected demo bank.
func Run(ctx context.Context, s *rpc.Server, opt Options) (Summary, error) {
	var sum Summary
	s.Cfg.AllowRegistration = true

	uid, created, err := ensureUser(ctx, s, opt)
	if err != nil {
		return sum, err
	}
	sum.Created = created
	ctx = auth.WithUserID(ctx, uid)

	company, err := ensureCompany(ctx, s, opt.Company)
	if err != nil {
		return sum, err
	}
	sum.CompanyID = company.Id

	projects, err := ensureProjects(ctx, s, company.Id)
	if err != nil {
		return sum, err
	}
	sum.Projects = len(projects)

	if sum.Invoices, err = ensureInvoices(ctx, s, company.Id, projects); err != nil {
		return sum, err
	}
	if err := ensureBank(ctx, s, company.Id); err != nil {
		return sum, err
	}
	// A sync now pays the recent open invoice through the demo bank and runs the matcher.
	if _, err := s.SyncNow(ctx, &pb.CompanyRequest{CompanyId: company.Id}); err != nil {
		return sum, fmt.Errorf("sync: %w", err)
	}
	if err := explainSome(ctx, s, company.Id); err != nil {
		return sum, err
	}
	all, err := s.ListTransactions(ctx, &pb.ListTransactionsRequest{CompanyId: company.Id, PageSize: 1})
	if err != nil {
		return sum, err
	}
	sum.Transactions = int(all.Total)
	return sum, nil
}

func ensureUser(ctx context.Context, s *rpc.Server, opt Options) (int64, bool, error) {
	var id int64
	err := s.DB.QueryRow(ctx, "SELECT id FROM users WHERE email=$1", opt.Email).Scan(&id)
	if err == nil {
		return id, false, nil
	}
	if !errors.Is(err, pgx.ErrNoRows) {
		return 0, false, err
	}
	res, err := s.Register(ctx, &pb.RegisterRequest{Email: opt.Email, Name: opt.Name, Password: opt.Password})
	if err != nil {
		return 0, false, fmt.Errorf("register: %w", err)
	}
	return int64(res.User.Id), true, nil
}

func ensureCompany(ctx context.Context, s *rpc.Server, name string) (*pb.Company, error) {
	list, err := s.ListCompanies(ctx, &pb.Empty{})
	if err != nil {
		return nil, err
	}
	for _, c := range list.Items {
		if c.Name == name {
			return c, nil
		}
	}
	return s.CreateCompany(ctx, &pb.Company{
		Name: name, RegNumber: "14567890", VatNumber: "EE101234567", Address: "Tartu mnt 1, 10145 Tallinn",
		Email: "billing@internus.example", Phone: "+372 5555 1234", Iban: "EE382200221020145685", BankName: "Wise",
		Currency: "EUR", InvoicePrefix: "INV-", DefaultVatRate: "24", DefaultDueDays: 14,
	})
}

var demoProjects = []*pb.Project{
	{Name: "Paysure Solutions Ltd", Email: "ap@paysure.example", ContactName: "Jane Doe", Address: "1 Finsbury Avenue, London EC2M 2PF", RegNumber: "09876543", Description: "Payment platform — monthly development retainer"},
	{Name: "Northwind Traders", Email: "finance@northwind.example", ContactName: "Karl Tamm", Address: "Pärnu mnt 15, Tallinn", RegNumber: "12345678", VatNumber: "EE100000001", Description: "Warehouse system integration"},
	{Name: "Contoso Ltd", Email: "accounts@contoso.example", ContactName: "Maria Mägi", Address: "Riia 2, Tartu", Description: "Consulting"},
}

func ensureProjects(ctx context.Context, s *rpc.Server, companyID uint64) ([]*pb.Project, error) {
	existing, err := s.ListProjects(ctx, &pb.ListProjectsRequest{CompanyId: companyID, IncludeInactive: true})
	if err != nil {
		return nil, err
	}
	byName := map[string]*pb.Project{}
	for _, p := range existing.Items {
		byName[p.Name] = p
	}
	out := make([]*pb.Project, 0, len(demoProjects))
	for _, tpl := range demoProjects {
		if p, ok := byName[tpl.Name]; ok {
			out = append(out, p)
			continue
		}
		p := proto.Clone(tpl).(*pb.Project)
		p.CompanyId = companyID
		created, err := s.CreateProject(ctx, p)
		if err != nil {
			return nil, fmt.Errorf("project %s: %w", tpl.Name, err)
		}
		out = append(out, created)
	}
	return out, nil
}

type demoInvoice struct {
	project   int
	reference string
	issueDays int // days ago
	dueDays   int // days after issue
	issue     bool
	items     []*pb.InvoiceItem
}

// The demo bank pays open invoices issued 1–30 days ago, so the 10-day-old one ends up paid,
// the 45-day-old one stays overdue and today's stays open.
var demoInvoices = []demoInvoice{
	{0, "PO-2026-11", 45, 14, true, []*pb.InvoiceItem{{Description: "Software development – July", Quantity: "80", UnitPriceCents: 9000, VatRate: "24"}}},
	{0, "PO-2026-14", 10, 14, true, []*pb.InvoiceItem{{Description: "Software development – August", Quantity: "64", UnitPriceCents: 9000, VatRate: "24"}, {Description: "Hosting", Quantity: "1", UnitPriceCents: 4900, VatRate: "24"}}},
	{1, "NW-441", 0, 14, true, []*pb.InvoiceItem{{Description: "Integration work", Quantity: "24.5", UnitPriceCents: 8500, VatRate: "24"}, {Description: "Travel (0% VAT)", Quantity: "1", UnitPriceCents: 12000, VatRate: "0"}}},
	{2, "", 0, 30, false, []*pb.InvoiceItem{{Description: "Consulting workshop", Quantity: "2", UnitPriceCents: 60000, VatRate: "24"}}},
}

func ensureInvoices(ctx context.Context, s *rpc.Server, companyID uint64, projects []*pb.Project) (int, error) {
	existing, err := s.ListInvoices(ctx, &pb.ListInvoicesRequest{CompanyId: companyID, PageSize: 500})
	if err != nil {
		return 0, err
	}
	if len(existing.Items) > 0 {
		return len(existing.Items), nil
	}
	today := time.Now()
	for _, d := range demoInvoices {
		issue := today.AddDate(0, 0, -d.issueDays)
		inv := &pb.Invoice{
			CompanyId: companyID, ProjectId: projects[d.project].Id, Reference: d.reference,
			IssueDate: issue.Format("2006-01-02"), DueDate: issue.AddDate(0, 0, d.dueDays).Format("2006-01-02"),
			Notes: "Thank you for your business.", Items: d.items,
		}
		created, err := s.CreateInvoice(ctx, inv)
		if err != nil {
			return 0, fmt.Errorf("invoice %s: %w", d.reference, err)
		}
		if d.issue {
			if _, err := s.IssueInvoice(ctx, &pb.CompanyIdRequest{CompanyId: companyID, Id: created.Id}); err != nil {
				return 0, fmt.Errorf("issue %s: %w", d.reference, err)
			}
		}
	}
	return len(demoInvoices), nil
}

func ensureBank(ctx context.Context, s *rpc.Server, companyID uint64) error {
	conns, err := s.ListBankConnections(ctx, &pb.CompanyRequest{CompanyId: companyID})
	if err != nil {
		return err
	}
	if len(conns.Items) > 0 {
		return nil
	}
	if _, ok := s.Banks.Get("mock"); !ok {
		return errors.New("the demo bank provider is not enabled (MOCK_BANK_ENABLED)")
	}
	_, err = s.CreateBankConnection(ctx, &pb.CreateBankConnectionRequest{CompanyId: companyID, Provider: "mock", Name: "Demo bank", Config: map[string]string{"seed": "demo"}})
	if err != nil {
		return fmt.Errorf("bank connection: %w", err)
	}
	return nil
}

// explainSome categorises a handful of expenses so the dashboard shows every transaction state.
func explainSome(ctx context.Context, s *rpc.Server, companyID uint64) error {
	cats, err := s.ListCategories(ctx, &pb.CompanyRequest{CompanyId: companyID})
	if err != nil {
		return err
	}
	byName := map[string]uint64{}
	for _, c := range cats.Items {
		byName[c.Name] = c.Id
	}
	pick := func(counterparty string) uint64 {
		switch counterparty {
		case "Anthropic PBC", "Google Ireland Ltd", "Hetzner Online GmbH":
			return byName["Computer software"]
		case "Bolt Operations OÜ":
			return byName["Travel"]
		case "Wise Europe SA", "Coop Pank":
			return byName["Bank/finance charges"]
		case "Rimi Eesti Food AS":
			return byName["Office costs"]
		}
		return byName["Other money out"]
	}
	txs, err := s.ListTransactions(ctx, &pb.ListTransactionsRequest{CompanyId: companyID, Status: pb.TransactionStatus_TRANSACTION_STATUS_UNEXPLAINED, PageSize: 40})
	if err != nil {
		return err
	}
	explained := 0
	for _, t := range txs.Items {
		if t.AmountCents >= 0 || explained >= 8 {
			continue
		}
		cat := pick(t.CounterpartyName)
		if cat == 0 {
			continue
		}
		_, err := s.ExplainTransaction(ctx, &pb.ExplainTransactionRequest{CompanyId: companyID, Id: t.Id, CategoryId: cat, Note: "Seeded example", Approve: explained%2 == 0})
		if err != nil {
			return err
		}
		explained++
	}
	return nil
}
