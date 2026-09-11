package rpc

import (
	"context"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	"open-accounting/server/internal/db"
	"open-accounting/server/internal/money"
	"open-accounting/server/pb"
)

const companyCols = `c.id, c.name, c.reg_number, c.vat_number, c.address, c.email, c.phone, c.iban, c.bank_name,
	c.currency, c.invoice_prefix, c.next_invoice_number, c.default_vat_rate::text, c.default_due_days, c.created_at`

func scanCompany(row pgx.Row, role string) (*pb.Company, error) {
	var c pb.Company
	var created time.Time
	var vat string
	err := row.Scan(&c.Id, &c.Name, &c.RegNumber, &c.VatNumber, &c.Address, &c.Email, &c.Phone, &c.Iban, &c.BankName,
		&c.Currency, &c.InvoicePrefix, &c.NextInvoiceNumber, &vat, &c.DefaultDueDays, &created)
	if err != nil {
		return nil, err
	}
	c.Currency = strings.TrimSpace(c.Currency)
	c.DefaultVatRate = vat
	c.CreatedAt = tsv(created)
	c.Role = role
	return &c, nil
}

var defaultCategories = []struct {
	name, kind string
}{
	{"Sales", "income"}, {"Interest received", "income"}, {"Other money in", "income"},
	{"Bank/finance charges", "expense"}, {"Computer software", "expense"}, {"Subcontractor costs", "expense"},
	{"Travel", "expense"}, {"Office costs", "expense"}, {"Salaries", "expense"}, {"Taxes", "expense"},
	{"Marketing", "expense"}, {"Other money out", "expense"},
}

func validateCompany(c *pb.Company) error {
	if strings.TrimSpace(c.Name) == "" {
		return invalid("company name is required")
	}
	c.Currency = strings.ToUpper(strings.TrimSpace(c.Currency))
	if c.Currency == "" {
		c.Currency = "EUR"
	}
	if len(c.Currency) != 3 {
		return invalid("currency must be a 3-letter code")
	}
	if c.InvoicePrefix == "" {
		c.InvoicePrefix = "INV-"
	}
	if c.DefaultVatRate == "" {
		c.DefaultVatRate = "24"
	}
	if _, err := money.ParseDecimal(c.DefaultVatRate, 2); err != nil {
		return invalid("default VAT rate must be a number")
	}
	if c.DefaultDueDays == 0 {
		c.DefaultDueDays = 14
	}
	return nil
}

func (s *Server) CreateCompany(ctx context.Context, req *pb.Company) (*pb.Company, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	if err := validateCompany(req); err != nil {
		return nil, err
	}
	var out *pb.Company
	err = db.WithTx(ctx, s.DB, func(tx pgx.Tx) error {
		row := tx.QueryRow(ctx, `INSERT INTO companies AS c (name, reg_number, vat_number, address, email, phone, iban, bank_name, currency, invoice_prefix, default_vat_rate, default_due_days)
			VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11::numeric,$12) RETURNING `+companyCols,
			req.Name, req.RegNumber, req.VatNumber, req.Address, req.Email, req.Phone, req.Iban, req.BankName, req.Currency, req.InvoicePrefix, req.DefaultVatRate, req.DefaultDueDays)
		c, err := scanCompany(row, "owner")
		if err != nil {
			return err
		}
		if _, err := tx.Exec(ctx, "INSERT INTO company_members (company_id, user_id, role) VALUES ($1,$2,'owner')", c.Id, uid); err != nil {
			return err
		}
		for i, cat := range defaultCategories {
			if _, err := tx.Exec(ctx, "INSERT INTO categories (company_id, name, kind, sort_order) VALUES ($1,$2,$3,$4)", c.Id, cat.name, cat.kind, i); err != nil {
				return err
			}
		}
		out = c
		return nil
	})
	if err != nil {
		return nil, dbErr(err)
	}
	return out, nil
}

func (s *Server) UpdateCompany(ctx context.Context, req *pb.Company) (*pb.Company, error) {
	_, role, err := s.requireMember(ctx, req.Id)
	if err != nil {
		return nil, err
	}
	if role != "owner" {
		return nil, status.Error(codes.PermissionDenied, "only owners can edit company settings")
	}
	if err := validateCompany(req); err != nil {
		return nil, err
	}
	row := s.DB.QueryRow(ctx, `UPDATE companies AS c SET name=$2, reg_number=$3, vat_number=$4, address=$5, email=$6, phone=$7, iban=$8, bank_name=$9,
		currency=$10, invoice_prefix=$11, default_vat_rate=$12::numeric, default_due_days=$13 WHERE c.id=$1 RETURNING `+companyCols,
		req.Id, req.Name, req.RegNumber, req.VatNumber, req.Address, req.Email, req.Phone, req.Iban, req.BankName, req.Currency, req.InvoicePrefix, req.DefaultVatRate, req.DefaultDueDays)
	c, err := scanCompany(row, role)
	if err != nil {
		return nil, dbErr(err)
	}
	return c, nil
}

func (s *Server) ListCompanies(ctx context.Context, _ *pb.Empty) (*pb.ListCompaniesResponse, error) {
	uid, err := userID(ctx)
	if err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, `SELECT `+companyCols+`, m.role FROM companies c JOIN company_members m ON m.company_id=c.id
		WHERE m.user_id=$1 ORDER BY c.name`, uid)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListCompaniesResponse{}
	for rows.Next() {
		var c pb.Company
		var created time.Time
		var vat string
		if err := rows.Scan(&c.Id, &c.Name, &c.RegNumber, &c.VatNumber, &c.Address, &c.Email, &c.Phone, &c.Iban, &c.BankName,
			&c.Currency, &c.InvoicePrefix, &c.NextInvoiceNumber, &vat, &c.DefaultDueDays, &created, &c.Role); err != nil {
			return nil, internalErr(err)
		}
		c.Currency = strings.TrimSpace(c.Currency)
		c.DefaultVatRate = vat
		c.CreatedAt = tsv(created)
		out.Items = append(out.Items, &c)
	}
	return out, nil
}

func (s *Server) GetCompany(ctx context.Context, req *pb.CompanyRequest) (*pb.Company, error) {
	_, role, err := s.requireMember(ctx, req.CompanyId)
	if err != nil {
		return nil, err
	}
	c, err := scanCompany(s.DB.QueryRow(ctx, `SELECT `+companyCols+` FROM companies c WHERE c.id=$1`, req.CompanyId), role)
	if err != nil {
		return nil, dbErr(err)
	}
	return c, nil
}

// companyCurrency is used by handlers that need the base currency.
func (s *Server) companyCurrency(ctx context.Context, companyID uint64) (string, error) {
	var cur string
	err := s.DB.QueryRow(ctx, "SELECT currency FROM companies WHERE id=$1", companyID).Scan(&cur)
	return strings.TrimSpace(cur), err
}
