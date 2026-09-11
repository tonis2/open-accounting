package rpc

import (
	"context"
	"errors"
	"log/slog"
	"time"

	"github.com/go-webauthn/webauthn/webauthn"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgconn"
	"github.com/jackc/pgx/v5/pgxpool"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
	"google.golang.org/protobuf/types/known/timestamppb"

	"open-accounting/server/internal/auth"
	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/config"
	"open-accounting/server/internal/crypto"
	"open-accounting/server/internal/mail"
	"open-accounting/server/internal/storage"
	"open-accounting/server/internal/sync"
	"open-accounting/server/pb"
)

// Server implements pb.AccountingServiceServer. Handlers are split by domain across files.
type Server struct {
	pb.UnimplementedAccountingServiceServer

	DB       *pgxpool.Pool
	Cfg      config.Config
	Tokens   *auth.Tokens
	Limiter  *auth.Limiter
	WebAuthn *webauthn.WebAuthn
	Sessions *auth.Sessions
	Box      *crypto.Box
	Mail     *mail.Sender
	Store    *storage.Store
	Banks    *banks.Registry
	Sync     *sync.Runner
}

// ---- error helpers ----

func internalErr(err error) error {
	slog.Error("[RPC] internal error", "err", err)
	return status.Error(codes.Internal, "internal error")
}

func dbErr(err error) error {
	if errors.Is(err, pgx.ErrNoRows) {
		return status.Error(codes.NotFound, "not found")
	}
	var pgErr *pgconn.PgError
	if errors.As(err, &pgErr) {
		switch pgErr.Code {
		case "23505":
			return status.Error(codes.AlreadyExists, "already exists")
		case "23503":
			return status.Error(codes.FailedPrecondition, "referenced by other records")
		}
	}
	return internalErr(err)
}

func invalid(msg string) error { return status.Error(codes.InvalidArgument, msg) }

// ---- auth helpers ----

func userID(ctx context.Context) (int64, error) {
	id, ok := auth.UserID(ctx)
	if !ok {
		return 0, status.Error(codes.Unauthenticated, "not signed in")
	}
	return id, nil
}

// requireMember checks the caller belongs to the company and returns (userID, role).
func (s *Server) requireMember(ctx context.Context, companyID uint64) (int64, string, error) {
	uid, err := userID(ctx)
	if err != nil {
		return 0, "", err
	}
	if companyID == 0 {
		return 0, "", invalid("company_id is required")
	}
	var role string
	err = s.DB.QueryRow(ctx, "SELECT role FROM company_members WHERE company_id=$1 AND user_id=$2", companyID, uid).Scan(&role)
	if errors.Is(err, pgx.ErrNoRows) {
		return 0, "", status.Error(codes.PermissionDenied, "not a member of this company")
	}
	if err != nil {
		return 0, "", internalErr(err)
	}
	return uid, role, nil
}

// ---- conversions ----

func ts(t *time.Time) *timestamppb.Timestamp {
	if t == nil || t.IsZero() {
		return nil
	}
	return timestamppb.New(*t)
}

func tsv(t time.Time) *timestamppb.Timestamp {
	if t.IsZero() {
		return nil
	}
	return timestamppb.New(t)
}

func dateStr(t time.Time) string {
	if t.IsZero() {
		return ""
	}
	return t.Format("2006-01-02")
}

func parseDate(s string) (time.Time, error) {
	return time.Parse("2006-01-02", s)
}

func ptrInt64(v *int64) uint64 {
	if v == nil {
		return 0
	}
	return uint64(*v)
}

func pageArgs(page, size uint32) (limit, offset int) {
	if size == 0 || size > 500 {
		size = 50
	}
	if page == 0 {
		page = 1
	}
	return int(size), int(size) * int(page-1)
}
