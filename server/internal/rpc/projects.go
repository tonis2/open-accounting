package rpc

import (
	"context"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"

	"open-accounting/server/pb"
)

const projectCols = `p.id, p.company_id, p.name, p.email, p.description, p.contact_name, p.address, p.reg_number, p.vat_number, p.is_active, p.created_at,
	COALESCE((SELECT SUM(total_cents) FROM invoices i WHERE i.project_id=p.id AND i.status IN ('open','paid')),0),
	COALESCE((SELECT SUM(total_cents) FROM invoices i WHERE i.project_id=p.id AND i.status='open'),0),
	(SELECT COUNT(*) FROM invoices i WHERE i.project_id=p.id AND i.status <> 'cancelled')`

func scanProject(row pgx.Row) (*pb.Project, error) {
	var p pb.Project
	var created time.Time
	err := row.Scan(&p.Id, &p.CompanyId, &p.Name, &p.Email, &p.Description, &p.ContactName, &p.Address, &p.RegNumber, &p.VatNumber, &p.IsActive, &created,
		&p.InvoicedCents, &p.OutstandingCents, &p.InvoiceCount)
	if err != nil {
		return nil, err
	}
	p.CreatedAt = tsv(created)
	return &p, nil
}

func (s *Server) CreateProject(ctx context.Context, req *pb.Project) (*pb.Project, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if strings.TrimSpace(req.Name) == "" {
		return nil, invalid("project name is required")
	}
	if req.Email != "" && !validEmail(req.Email) {
		return nil, invalid("invalid email")
	}
	var id int64
	err := s.DB.QueryRow(ctx, `INSERT INTO projects (company_id, name, email, description, contact_name, address, reg_number, vat_number, is_active)
		VALUES ($1,$2,$3,$4,$5,$6,$7,$8,true) RETURNING id`,
		req.CompanyId, strings.TrimSpace(req.Name), strings.TrimSpace(req.Email), req.Description, req.ContactName, req.Address, req.RegNumber, req.VatNumber).Scan(&id)
	if err != nil {
		return nil, dbErr(err)
	}
	return s.getProject(ctx, req.CompanyId, uint64(id))
}

func (s *Server) UpdateProject(ctx context.Context, req *pb.Project) (*pb.Project, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if strings.TrimSpace(req.Name) == "" {
		return nil, invalid("project name is required")
	}
	if req.Email != "" && !validEmail(req.Email) {
		return nil, invalid("invalid email")
	}
	tag, err := s.DB.Exec(ctx, `UPDATE projects SET name=$3, email=$4, description=$5, contact_name=$6, address=$7, reg_number=$8, vat_number=$9, is_active=$10
		WHERE id=$1 AND company_id=$2`,
		req.Id, req.CompanyId, strings.TrimSpace(req.Name), strings.TrimSpace(req.Email), req.Description, req.ContactName, req.Address, req.RegNumber, req.VatNumber, req.IsActive)
	if err != nil {
		return nil, dbErr(err)
	}
	if tag.RowsAffected() == 0 {
		return nil, dbErr(pgx.ErrNoRows)
	}
	return s.getProject(ctx, req.CompanyId, req.Id)
}

func (s *Server) DeleteProject(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Empty, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	var invoices int
	_ = s.DB.QueryRow(ctx, "SELECT COUNT(*) FROM invoices WHERE project_id=$1", req.Id).Scan(&invoices)
	if invoices > 0 {
		// Keep history intact; archive instead of deleting.
		_, err := s.DB.Exec(ctx, "UPDATE projects SET is_active=false WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId)
		if err != nil {
			return nil, dbErr(err)
		}
		return &pb.Empty{}, nil
	}
	if _, err := s.DB.Exec(ctx, "DELETE FROM projects WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId); err != nil {
		return nil, dbErr(err)
	}
	return &pb.Empty{}, nil
}

func (s *Server) ListProjects(ctx context.Context, req *pb.ListProjectsRequest) (*pb.ListProjectsResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, `SELECT `+projectCols+` FROM projects p WHERE p.company_id=$1 AND ($2 OR p.is_active) ORDER BY p.name`, req.CompanyId, req.IncludeInactive)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListProjectsResponse{}
	for rows.Next() {
		p, err := scanProject(rows)
		if err != nil {
			return nil, internalErr(err)
		}
		out.Items = append(out.Items, p)
	}
	return out, nil
}

func (s *Server) GetProject(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Project, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	return s.getProject(ctx, req.CompanyId, req.Id)
}

func (s *Server) getProject(ctx context.Context, companyID, id uint64) (*pb.Project, error) {
	p, err := scanProject(s.DB.QueryRow(ctx, `SELECT `+projectCols+` FROM projects p WHERE p.id=$1 AND p.company_id=$2`, id, companyID))
	if err != nil {
		return nil, dbErr(err)
	}
	return p, nil
}
