package rpc

import (
	"context"
	"strings"

	"github.com/jackc/pgx/v5"

	"open-accounting/server/pb"
)

func kindToDB(k pb.CategoryKind) string {
	if k == pb.CategoryKind_CATEGORY_KIND_INCOME {
		return "income"
	}
	return "expense"
}

func kindFromDB(k string) pb.CategoryKind {
	if k == "income" {
		return pb.CategoryKind_CATEGORY_KIND_INCOME
	}
	return pb.CategoryKind_CATEGORY_KIND_EXPENSE
}

func (s *Server) ListCategories(ctx context.Context, req *pb.CompanyRequest) (*pb.ListCategoriesResponse, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, "SELECT id, company_id, name, kind, sort_order FROM categories WHERE company_id=$1 ORDER BY kind, sort_order, name", req.CompanyId)
	if err != nil {
		return nil, internalErr(err)
	}
	defer rows.Close()
	out := &pb.ListCategoriesResponse{}
	for rows.Next() {
		var c pb.Category
		var kind string
		if err := rows.Scan(&c.Id, &c.CompanyId, &c.Name, &kind, &c.SortOrder); err != nil {
			return nil, internalErr(err)
		}
		c.Kind = kindFromDB(kind)
		out.Items = append(out.Items, &c)
	}
	return out, nil
}

func (s *Server) CreateCategory(ctx context.Context, req *pb.Category) (*pb.Category, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if strings.TrimSpace(req.Name) == "" {
		return nil, invalid("category name is required")
	}
	if req.Kind == pb.CategoryKind_CATEGORY_KIND_UNSPECIFIED {
		return nil, invalid("category kind is required")
	}
	err := s.DB.QueryRow(ctx, `INSERT INTO categories (company_id, name, kind, sort_order)
		VALUES ($1,$2,$3, COALESCE((SELECT MAX(sort_order)+1 FROM categories WHERE company_id=$1),0)) RETURNING id, sort_order`,
		req.CompanyId, strings.TrimSpace(req.Name), kindToDB(req.Kind)).Scan(&req.Id, &req.SortOrder)
	if err != nil {
		return nil, dbErr(err)
	}
	return req, nil
}

func (s *Server) UpdateCategory(ctx context.Context, req *pb.Category) (*pb.Category, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if strings.TrimSpace(req.Name) == "" {
		return nil, invalid("category name is required")
	}
	tag, err := s.DB.Exec(ctx, "UPDATE categories SET name=$3, kind=$4, sort_order=$5 WHERE id=$1 AND company_id=$2",
		req.Id, req.CompanyId, strings.TrimSpace(req.Name), kindToDB(req.Kind), req.SortOrder)
	if err != nil {
		return nil, dbErr(err)
	}
	if tag.RowsAffected() == 0 {
		return nil, dbErr(pgx.ErrNoRows)
	}
	return req, nil
}

func (s *Server) DeleteCategory(ctx context.Context, req *pb.CompanyIdRequest) (*pb.Empty, error) {
	if _, _, err := s.requireMember(ctx, req.CompanyId); err != nil {
		return nil, err
	}
	if _, err := s.DB.Exec(ctx, "DELETE FROM categories WHERE id=$1 AND company_id=$2", req.Id, req.CompanyId); err != nil {
		return nil, dbErr(err)
	}
	return &pb.Empty{}, nil
}
