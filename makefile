export PATH := $(HOME)/.pub-cache/bin:$(HOME)/go/bin:$(PATH)

-include .env
export

# ==================== PROTOBUF ====================

build_proto:
	@echo "Building protobuf files..."
	mkdir -p server/pb dashboard/lib/generated
	protoc -I proto/ proto/routes.proto --go_out=server/pb --go_opt=paths=source_relative --go-grpc_out=server/pb --go-grpc_opt=paths=source_relative
	protoc -I proto/ proto/routes.proto --dart_out=grpc:dashboard/lib/generated

# ==================== SERVER ====================

server_run:
	cd server && go run .

server_build:
	cd server && CGO_ENABLED=0 go build -o build/server .

# Integration tests run against a throwaway database (schema is dropped on each run)
server_test:
	-podman exec oa-postgres psql -U accounting -d accounting -c "CREATE DATABASE accounting_test" >/dev/null 2>&1
	cd server && TEST_POSTGRES_URL=postgres://accounting:$(POSTGRES_PASSWORD)@localhost:5432/accounting_test go test ./...

server_vet:
	cd server && go vet ./...

# Creates demo@example.com / demo1234 with a company, projects, invoices and the demo bank.
# Override with: make seed_demo SEED_ARGS="--email me@example.com --password secret123"
seed_demo:
	cd server && go run . seed $(SEED_ARGS)

# ==================== DASHBOARD ====================

run_dashboard:
	cd dashboard && flutter run -d web-server --web-port 8000 --dart-define=flavor=dev

dashboard_build:
	cd dashboard && flutter build web --dart-define=flavor=prod --release

dashboard_test:
	cd dashboard && flutter test

dashboard_analyze:
	cd dashboard && flutter analyze

gen_l10n:
	cd dashboard && flutter gen-l10n

# ==================== LOCAL DEV CONTAINERS (podman) ====================

db_run:
	podman run -d --name oa-postgres --restart unless-stopped -p 5432:5432 \
		-e POSTGRES_DB=accounting -e POSTGRES_USER=accounting -e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
		-v oa_pgdata:/var/lib/postgresql/data docker.io/library/postgres:17

db_stop:
	podman rm -f oa-postgres

db_psql:
	podman exec -it oa-postgres psql -U accounting -d accounting

envoy_run:
	podman run -d --name oa-envoy --restart unless-stopped --network=host -e ENVOY_UID=0 \
		-v $(CURDIR)/server/envoy/envoy.dev.yaml:/etc/envoy/envoy.yaml:ro,Z \
		docker.io/envoyproxy/envoy:v1.31-latest envoy -c /etc/envoy/envoy.yaml --disable-hot-restart

envoy_stop:
	podman rm -f oa-envoy

dev:
	@echo "1. make db_run      (once)"
	@echo "2. make envoy_run   (once)"
	@echo "3. make server_run"
	@echo "4. make run_dashboard   -> http://localhost:8000"

# ==================== DEPLOYMENT ====================

# Uses docker compose when docker is installed, otherwise podman compose (needs podman-compose).
COMPOSE ?= $(shell command -v docker >/dev/null 2>&1 && echo "docker compose" || echo "podman compose")

compose_up:
	$(COMPOSE) up --build -d --force-recreate

compose_down:
	$(COMPOSE) down

compose_logs:
	$(COMPOSE) logs -f server

compose_ps:
	$(COMPOSE) ps

compose_seed:
	$(COMPOSE) exec server /server seed $(SEED_ARGS)

# ==================== UTILITIES ====================

clean:
	cd server && rm -rf build
	cd dashboard && flutter clean 2>/dev/null || rm -rf .dart_tool build

fmt:
	cd server && gofmt -w .
	cd dashboard && dart format .

.PHONY: build_proto server_run server_build server_test server_vet run_dashboard dashboard_build dashboard_test dashboard_analyze gen_l10n db_run db_stop db_psql envoy_run envoy_stop dev seed_demo compose_up compose_down compose_logs compose_ps compose_seed clean fmt
