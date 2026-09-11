package main

import (
	"context"
	"flag"
	"fmt"
	"log/slog"
	"net"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"strings"
	"syscall"
	"time"

	"github.com/go-webauthn/webauthn/webauthn"
	"github.com/jackc/pgx/v5/pgxpool"
	"google.golang.org/grpc"
	"google.golang.org/grpc/health"
	healthpb "google.golang.org/grpc/health/grpc_health_v1"

	"open-accounting/server/internal/auth"
	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/banks/gocardless"
	"open-accounting/server/internal/banks/manual"
	"open-accounting/server/internal/banks/mock"
	"open-accounting/server/internal/banks/wise"
	"open-accounting/server/internal/config"
	"open-accounting/server/internal/crypto"
	"open-accounting/server/internal/db"
	"open-accounting/server/internal/mail"
	"open-accounting/server/internal/rpc"
	"open-accounting/server/internal/seed"
	"open-accounting/server/internal/storage"
	"open-accounting/server/internal/sync"
	"open-accounting/server/pb"
)

// Usage: `server` runs the gRPC API; `server seed [--email --password --name --company]`
// creates a demo account with sample data and exits.
func main() {
	level := slog.LevelInfo
	if v := os.Getenv("LOG_LEVEL"); v != "" {
		_ = level.UnmarshalText([]byte(v)) // debug|info|warn|error; invalid keeps info
	}
	slog.SetDefault(slog.New(slog.NewTextHandler(os.Stdout, &slog.HandlerOptions{Level: level})))

	if len(os.Args) > 1 && os.Args[1] == "seed" {
		os.Exit(runSeed(os.Args[2:]))
	}
	serve()
}

func fatal(tag string, err error) {
	slog.Error(tag, "err", err)
	os.Exit(1)
}

// deps wires everything the handlers need; shared by serve and seed.
type deps struct {
	cfg    config.Config
	pool   *pgxpool.Pool
	srv    *rpc.Server
	runner *sync.Runner
}

func build(ctx context.Context, cfg config.Config) (*deps, error) {
	pool, err := db.Connect(ctx, cfg.PostgresURL)
	if err != nil {
		return nil, fmt.Errorf("[DB] connect: %w", err)
	}
	if err := db.Migrate(ctx, pool); err != nil {
		pool.Close()
		return nil, fmt.Errorf("[DB] migrate: %w", err)
	}
	box, err := crypto.NewBox(cfg.SecretsKey)
	if err != nil {
		return nil, fmt.Errorf("[CONFIG] SECRETS_KEY: %w", err)
	}
	store, err := storage.New(cfg.DataDir)
	if err != nil {
		return nil, fmt.Errorf("[STORAGE] %w", err)
	}
	wa, err := webauthn.New(&webauthn.Config{RPID: cfg.WebAuthnRPID, RPDisplayName: "Open Accounting", RPOrigins: cfg.WebAuthnOrigins})
	if err != nil {
		return nil, fmt.Errorf("[WEBAUTHN] %w", err)
	}

	registry := banks.NewRegistry()
	httpClient := &http.Client{Timeout: 45 * time.Second}
	if cfg.MockBankEnabled {
		m := mock.New()
		if cfg.MockBankPayInvoices {
			m.InvoiceHints = openInvoiceHints(pool)
		}
		registry.Register(m)
	}
	registry.Register(wise.New(httpClient))
	registry.Register(gocardless.New(httpClient))
	registry.Register(manual.New())

	runner := &sync.Runner{DB: pool, Banks: registry, Box: box, Interval: cfg.BankSyncInterval}
	tokens := auth.NewTokens(cfg.JWTSecret)
	srv := &rpc.Server{
		DB: pool, Cfg: cfg, Tokens: tokens,
		Limiter:  auth.NewLimiter(10, 15*time.Minute),
		WebAuthn: wa, Sessions: auth.NewSessions(),
		Box: box, Mail: mail.New(cfg.SMTPHost, cfg.SMTPPort, cfg.SMTPUser, cfg.SMTPPass, cfg.SMTPFrom),
		Store: store, Banks: registry, Sync: runner,
	}
	return &deps{cfg: cfg, pool: pool, srv: srv, runner: runner}, nil
}

func serve() {
	cfg, err := config.Load()
	if err != nil {
		fatal("[CONFIG]", err)
	}
	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	d, err := build(ctx, cfg)
	if err != nil {
		fatal("[STARTUP]", err)
	}
	defer d.pool.Close()
	d.runner.Start(ctx)

	grpcServer := grpc.NewServer(
		grpc.ChainUnaryInterceptor(auth.Recovery, auth.Logging, auth.Interceptor(d.srv.Tokens)),
		grpc.MaxRecvMsgSize(16<<20),
	)
	pb.RegisterAccountingServiceServer(grpcServer, d.srv)
	healthpb.RegisterHealthServer(grpcServer, health.NewServer())

	lis, err := net.Listen("tcp", ":"+cfg.Port)
	if err != nil {
		fatal("[SERVER] listen failed", err)
	}
	go func() {
		<-ctx.Done()
		slog.Info("[SERVER] shutting down")
		grpcServer.GracefulStop()
	}()
	slog.Info("[SERVER] listening", "port", cfg.Port, "mail", cfg.MailEnabled(), "mock_bank", cfg.MockBankEnabled, "rp_id", cfg.WebAuthnRPID)
	if err := grpcServer.Serve(lis); err != nil {
		fatal("[SERVER] serve failed", err)
	}
}

func runSeed(args []string) int {
	opt := seed.Defaults()
	fs := flag.NewFlagSet("seed", flag.ContinueOnError)
	fs.StringVar(&opt.Email, "email", opt.Email, "demo account email")
	fs.StringVar(&opt.Password, "password", opt.Password, "demo account password (min 8 chars)")
	fs.StringVar(&opt.Name, "name", opt.Name, "demo user name")
	fs.StringVar(&opt.Company, "company", opt.Company, "company name")
	if err := fs.Parse(args); err != nil {
		return 2
	}
	cfg, err := config.Load()
	if err != nil {
		fatal("[CONFIG]", err)
	}
	// The demo data needs the mock bank regardless of the server's own setting.
	cfg.MockBankEnabled, cfg.MockBankPayInvoices = true, true

	ctx := context.Background()
	d, err := build(ctx, cfg)
	if err != nil {
		fatal("[SEED]", err)
	}
	defer d.pool.Close()

	sum, err := seed.Run(ctx, d.srv, opt)
	if err != nil {
		fatal("[SEED]", err)
	}
	fmt.Printf("\nDemo data ready (company #%d, %d projects, %d invoices, %d bank transactions)\n", sum.CompanyID, sum.Projects, sum.Invoices, sum.Transactions)
	fmt.Printf("  email:    %s\n  password: %s\n", opt.Email, opt.Password)
	if !sum.Created {
		fmt.Println("  (account already existed — password unchanged)")
	}
	fmt.Println()
	return 0
}

// openInvoiceHints lets the demo bank emit payments for open invoices issued 1–30 days ago,
// so recent invoices get matched while an old overdue one stays unpaid.
func openInvoiceHints(pool *pgxpool.Pool) func(context.Context, banks.Config) []mock.InvoiceHint {
	return func(ctx context.Context, cfg banks.Config) []mock.InvoiceHint {
		companyID, err := strconv.ParseInt(cfg["_company_id"], 10, 64)
		if err != nil {
			return nil
		}
		rows, err := pool.Query(ctx, `SELECT i.number, i.total_cents, i.currency, p.name FROM invoices i JOIN projects p ON p.id=i.project_id
			WHERE i.company_id=$1 AND i.status='open' AND i.number IS NOT NULL
			AND i.issue_date BETWEEN CURRENT_DATE - 30 AND CURRENT_DATE - 1`, companyID)
		if err != nil {
			return nil
		}
		defer rows.Close()
		var hints []mock.InvoiceHint
		for rows.Next() {
			var h mock.InvoiceHint
			if err := rows.Scan(&h.Number, &h.TotalCents, &h.Currency, &h.Payer); err == nil {
				h.Currency = strings.TrimSpace(h.Currency)
				hints = append(hints, h)
			}
		}
		return hints
	}
}
