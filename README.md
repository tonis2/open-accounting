# Open Accounting

Self-hosted accounting for small companies: invoices for your projects, bank feeds from
Wise / open banking, transaction explanations with receipts, and automatic matching of
incoming payments to open invoices. Multi-company, passkey sign-in, English UI from a
translation file.

```
Browser (Flutter web, gRPC-Web) → Caddy → Envoy → Go gRPC server → PostgreSQL
```

| Part | Where | Notes |
|---|---|---|
| Go server | `server/` | gRPC, pgx, embedded SQL migrations, WebAuthn, bank plugins |
| Flutter dashboard | `dashboard/` | Web-first, `go_router`, gen-l10n (`lib/l10n/app_en.arb`) |
| API contract | `proto/routes.proto` | one `AccountingService`; `make build_proto` regenerates both sides |
| Self-hosting | `docker-compose.yml`, `DEPLOYMENT.md` | Postgres + server + Envoy + Caddy(web) |

## Run it with docker compose

```bash
cp .env.example .env            # set POSTGRES_PASSWORD, JWT_SECRET, SECRETS_KEY (openssl rand -hex 32)
make compose_up                 # docker compose, or podman compose when docker is not installed
open http://localhost           # register, create your first company
```

The first build compiles the Go server and the Flutter web app inside containers (no local
toolchain needed; the web image takes ~5 min). With **rootless podman** set
`WEB_HTTP_PORT=8080` and `WEB_HTTPS_PORT=8443` in `.env` (it cannot bind 80/443) and open
`http://localhost:8080`. Set `SITE_ADDRESS=https://your.domain`, `PUBLIC_URL`,
`WEBAUTHN_RP_ID` and `WEBAUTHN_ORIGINS` for a real domain — see `DEPLOYMENT.md`.

## Development

Requirements: Go 1.26+, Flutter 3.47+, `protoc` with `protoc-gen-go`, `protoc-gen-go-grpc`,
`protoc-gen-dart`, and `podman` (or docker) for Postgres and Envoy.

```bash
cp .env.example .env      # fill in secrets; POSTGRES_URL/DATA_DIR at the bottom are for local runs
make db_run               # Postgres 17 in a container (once)
make envoy_run            # gRPC-Web proxy on :8081 (once)
make server_run           # Go server on :8080, runs migrations
make run_dashboard        # Flutter web on http://localhost:8000 (flavor=dev → Envoy :8081)
```

Other targets: `make build_proto`, `make server_test` (spins the integration tests against an
`accounting_test` database), `make dashboard_test`, `make dashboard_analyze`, `make fmt`.

### Demo account

```bash
make seed_demo        # dev stack        → demo@example.com / demo1234
make compose_seed     # compose stack    → same account inside the containers
```

Creates a company (*Internus OÜ*), three projects, four invoices (overdue, paid, open, draft),
a connected **Demo bank** with ~170 transactions and a few categorised expenses. Re-running is a
no-op. Override the credentials with `SEED_ARGS="--email you@example.com --password secret123"`.

With `MOCK_BANK_ENABLED=true` the Demo bank provider is available in the connect wizard; with
`MOCK_BANK_PAY_INVOICES=true` it also emits a payment for every open invoice issued 1–30 days
ago, so the invoice ↔ payment matcher can be seen working (older invoices stay overdue).

## Bank providers

Providers live in `server/internal/banks/<name>` and implement `banks.Provider`. The dashboard
renders their `ConfigFields` generically, so adding a bank is one Go package plus one
`registry.Register(...)` line in `server/main.go`.

| Provider | What it does | Setup |
|---|---|---|
| `manual` — *Statement uploads* | Account without API access; transactions come from CSV statements you upload on the account page, balance = opening balance + rows. | Name, IBAN, currency, opening balance. |
| `wise` | Syncs balances over the Wise API. Transactions come from uploaded CSV statements (Wise → Balances → Statement → CSV): Wise serves API statements to personal tokens only for accounts based in the US, Canada, Australia, New Zealand, Singapore and Malaysia — those can register an RSA key and get them automatically. | API token from Wise → Settings → API tokens. |
| `gocardless` | Open-banking redirect flow, 90-day consent. **New GoCardless Bank Account Data signups are currently disabled**, so this only helps if you already have credentials. Sandbox bank: `SANDBOXFINANCE_SFIN0000`. | Secret ID/key. |
| `mock` | Demo data for development. | — |

Statement import understands Wise's CSV export and generic bank CSVs (`,`/`;`/tab separated;
date + amount or debit/credit columns; Estonian headers such as *Kuupäev/Selgitus/Saaja*).
Re-uploading an overlapping file only adds rows that are not there yet, and imported receipts are
matched against open invoices like API transactions.

## Layout

```
proto/routes.proto          server/internal/{config,db,auth,crypto,mail,storage,money,invoices,banks,sync,rpc}
server/main.go              dashboard/lib/{main,config,state,theme}.dart
server/pb/                  dashboard/lib/{components,pages,services,logging,l10n,generated}/
```
