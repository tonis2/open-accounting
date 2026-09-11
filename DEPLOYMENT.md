# Deployment

Open Accounting ships as one `docker-compose.yml` that runs everything on a single host:

```
Browser ──gRPC-Web/HTTPS──▶ Caddy (web)  ──▶ Envoy ──gRPC/h2──▶ server ──▶ PostgreSQL
                              │ static Flutter build
                              └─ TLS via Let's Encrypt
```

| Service | Image | Purpose |
|---|---|---|
| `postgres` | `postgres:17` | database, volume `pgdata` |
| `server` | built from `server/Dockerfile` | Go gRPC API, runs SQL migrations on start, files in volume `appdata` |
| `envoy` | `envoyproxy/envoy:v1.31-latest` | translates browser gRPC-Web to gRPC |
| `web` | built from `dashboard/Dockerfile` | Flutter web build served by Caddy; same-origin proxy of gRPC-Web calls to Envoy |

The browser talks to the same origin it loaded the app from, so there is no CORS and no
separate API domain. Caddy routes requests with `Content-Type: application/grpc-web*` to Envoy
and everything else to the SPA.

## 1. Server prerequisites

- A Linux host with Docker Engine + Compose plugin (`docker compose version`), **or** podman with
  `podman-compose` (`podman compose version`). `make compose_*` picks whichever is installed.
- Ports 80 and 443 open. Rootless podman cannot bind them — either set
  `WEB_HTTP_PORT`/`WEB_HTTPS_PORT` in `.env` and put a reverse proxy in front, or allow it with
  `sudo sysctl -w net.ipv4.ip_unprivileged_port_start=80` (persist in `/etc/sysctl.d/`).
- A DNS `A` record for your domain pointing at the host (skip for a LAN-only install).

## 2. Configure

```bash
git clone <your fork> open-accounting && cd open-accounting
cp .env.example .env
```

Edit `.env`:

| Variable | Value |
|---|---|
| `POSTGRES_PASSWORD` | any strong password |
| `JWT_SECRET` | `openssl rand -hex 32` |
| `SECRETS_KEY` | `openssl rand -hex 32` — encrypts bank credentials at rest; losing it means reconnecting banks |
| `SITE_ADDRESS` | `https://accounting.example.com` (Caddy obtains TLS automatically). Use `http://localhost` or `http://192.168.1.10` for a LAN install without TLS. |
| `PUBLIC_URL` | same as `SITE_ADDRESS`; used in emails and bank redirect callbacks |
| `WEBAUTHN_RP_ID` | the bare domain, e.g. `accounting.example.com` (passkeys are bound to it) |
| `WEBAUTHN_ORIGINS` | `https://accounting.example.com` |
| `SMTP_*` | optional — needed for password recovery and emailing invoices |
| `MOCK_BANK_ENABLED` | `false` in production |
| `ALLOW_REGISTRATION` | set to `false` after your users have registered |

## 3. Start

```bash
make compose_up                    # = docker compose up --build -d  (or podman compose …)
make compose_logs                  # wait for "[SERVER] listening"
```

The first build compiles the Go server (~1 min) and the Flutter web app (~5 min: the image
installs Flutter `FLUTTER_VERSION` from the official repo, see `dashboard/Dockerfile`). Later
builds are incremental. To update the Flutter version, change the `ARG` and `dashboard/pubspec.yaml`
together.

Open `SITE_ADDRESS` in the browser, register, create your company. To try it with sample data
first, `make compose_seed` creates `demo@example.com` / `demo1234` with a company, invoices and a
demo bank (requires `MOCK_BANK_ENABLED`; delete the account's company before going live).

### Faster web builds

If you have Flutter locally you can skip the in-container build:

```bash
make dashboard_build          # → dashboard/build/web
```

and in `docker-compose.yml` replace `build: ./dashboard` on the `web` service with
`image: caddy:2-alpine` plus volumes `./dashboard/build/web:/srv:ro` and
`./dashboard/Caddyfile:/etc/caddy/Caddyfile:ro`.

## 4. Updating

```bash
git pull
make compose_up                   # migrations run automatically on server start
```

## 5. Backups

```bash
docker compose exec postgres pg_dump -U accounting accounting | gzip > backup-$(date +%F).sql.gz   # or: podman compose exec …
docker run --rm -v open-accounting_appdata:/data -v $PWD:/backup alpine tar czf /backup/appdata-$(date +%F).tgz /data
```

`appdata` holds uploaded receipts and rendered invoice PDFs. Keep `.env` with the backups —
`SECRETS_KEY` is needed to decrypt stored bank credentials.

## 6. Bank connections

Open-banking access for individuals has narrowed considerably (GoCardless Bank Account Data has
closed new signups; Enable Banking, Tink and similar only serve licensed providers; Wise's
partner OAuth is not available to self-hosters). The reliable options are:

- **Statement uploads** (any bank): add a *Statement uploads* account, then on the account page
  use *Upload statement* with the CSV your online bank exports. Rows are de-duplicated, the
  balance is derived from them, and incoming payments are matched to open invoices.
- **Wise**: create an API token (Settings → API tokens) and add a Wise connection — balances sync
  automatically. Wise only serves statements to personal API tokens for accounts based in the US,
  Canada, Australia, New Zealand, Singapore and Malaysia; everywhere else (UK/EU included, business
  or personal) upload the CSV from Wise → Balances → *Statement* → CSV. Eligible accounts register an
  RSA public key in Wise and choose the private key under *Edit connection* to get statements
  automatically. Keys and balances belong to one profile: if the login has several business profiles
  the connection asks for a *Profile ID* and lists the candidates.
  `scripts/wise-sca-check.sh <token> <private-key.pem> [profile-id]` runs the signing handshake
  with curl/openssl to verify a key pair outside the server (prints no secrets).
- **GoCardless Bank Account Data**: only if you already hold credentials. Consent lasts 90 days
  (*Update connection* renews it); the API allows ~4 requests per account per day, so the provider
  syncs at most every 6 hours.
- Sync runs every `BANK_SYNC_INTERVAL` (default 1h) and can be triggered from Banking → Sync now.

## 7. Troubleshooting

| Symptom | Check |
|---|---|
| `[CONFIG] ... is required` in server logs | `.env` is missing a required variable |
| podman: `mkdir /var/lib/containers/storage/libpod: permission denied` | a second podman binary (e.g. Homebrew's) shadows the system one — `which -a podman`, remove the extra one |
| podman: envoy exits with `unable to read file /etc/envoy/envoy.yaml` | SELinux — the compose file mounts it with `:z`; keep that flag |
| podman: `rootlessport cannot expose privileged port 80` | set `WEB_HTTP_PORT`/`WEB_HTTPS_PORT` or lower `ip_unprivileged_port_start` |
| Browser shows "Server unavailable" | `docker compose logs envoy`; the Envoy cluster must resolve `server:8080` |
| Passkey registration fails | `WEBAUTHN_RP_ID` must match the domain in the address bar and `WEBAUTHN_ORIGINS` must include the full origin |
| Bank connection "expired" | Banking → ⋮ → Update connection |
| Bank sync fails and the message is not enough | `LOG_LEVEL=debug` in `.env`, restart the server; `[WISE]`/`[SYNC]` lines show the API exchange. The dashboard also prints connection problems to the browser console |
| Invoice email fails | `SMTP_*` variables; the server returns the SMTP error in the toast |
| TLS not issued | ports 80/443 reachable from the internet, DNS points at this host |

## Local development without compose

See `README.md` — Postgres and Envoy run via `podman`/`docker`, Go and Flutter run natively with
`make server_run` and `make run_dashboard`.
