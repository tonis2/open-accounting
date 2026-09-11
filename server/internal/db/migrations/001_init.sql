CREATE EXTENSION IF NOT EXISTS citext;

CREATE TABLE users (
    id            BIGSERIAL PRIMARY KEY,
    email         CITEXT NOT NULL UNIQUE,
    name          TEXT NOT NULL,
    password_hash TEXT,
    enabled       BOOLEAN NOT NULL DEFAULT true,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE passkeys (
    id            BIGSERIAL PRIMARY KEY,
    user_id       BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    credential_id BYTEA NOT NULL UNIQUE,
    credential    JSONB NOT NULL,
    name          TEXT NOT NULL DEFAULT '',
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    last_used_at  TIMESTAMPTZ
);
CREATE INDEX idx_passkeys_user ON passkeys(user_id);

CREATE TABLE recovery_tokens (
    id         BIGSERIAL PRIMARY KEY,
    user_id    BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    token      TEXT NOT NULL UNIQUE,
    expires_at TIMESTAMPTZ NOT NULL,
    used       BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE companies (
    id                  BIGSERIAL PRIMARY KEY,
    name                TEXT NOT NULL,
    reg_number          TEXT NOT NULL DEFAULT '',
    vat_number          TEXT NOT NULL DEFAULT '',
    address             TEXT NOT NULL DEFAULT '',
    email               TEXT NOT NULL DEFAULT '',
    phone               TEXT NOT NULL DEFAULT '',
    iban                TEXT NOT NULL DEFAULT '',
    bank_name           TEXT NOT NULL DEFAULT '',
    currency            CHAR(3) NOT NULL DEFAULT 'EUR',
    invoice_prefix      TEXT NOT NULL DEFAULT 'INV-',
    next_invoice_number INT NOT NULL DEFAULT 1,
    default_vat_rate    NUMERIC(5,2) NOT NULL DEFAULT 24,
    default_due_days    INT NOT NULL DEFAULT 14,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE company_members (
    company_id BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    user_id    BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role       TEXT NOT NULL CHECK (role IN ('owner', 'member')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (company_id, user_id)
);
CREATE INDEX idx_company_members_user ON company_members(user_id);

CREATE TABLE projects (
    id           BIGSERIAL PRIMARY KEY,
    company_id   BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    name         TEXT NOT NULL,
    email        TEXT NOT NULL DEFAULT '',
    description  TEXT NOT NULL DEFAULT '',
    contact_name TEXT NOT NULL DEFAULT '',
    address      TEXT NOT NULL DEFAULT '',
    reg_number   TEXT NOT NULL DEFAULT '',
    vat_number   TEXT NOT NULL DEFAULT '',
    is_active    BOOLEAN NOT NULL DEFAULT true,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_projects_company ON projects(company_id);

CREATE TABLE categories (
    id         BIGSERIAL PRIMARY KEY,
    company_id BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    name       TEXT NOT NULL,
    kind       TEXT NOT NULL CHECK (kind IN ('income', 'expense')),
    sort_order INT NOT NULL DEFAULT 0,
    UNIQUE (company_id, name)
);

CREATE TABLE bank_connections (
    id                 BIGSERIAL PRIMARY KEY,
    company_id         BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    provider           TEXT NOT NULL,
    name               TEXT NOT NULL,
    config_enc         BYTEA NOT NULL,
    state              JSONB NOT NULL DEFAULT '{}',
    reference          TEXT UNIQUE,
    status             TEXT NOT NULL CHECK (status IN ('pending', 'active', 'expired', 'error')),
    status_message     TEXT NOT NULL DEFAULT '',
    consent_expires_at TIMESTAMPTZ,
    last_sync_at       TIMESTAMPTZ,
    created_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_bank_connections_company ON bank_connections(company_id);

CREATE TABLE bank_accounts (
    id            BIGSERIAL PRIMARY KEY,
    connection_id BIGINT NOT NULL REFERENCES bank_connections(id) ON DELETE CASCADE,
    company_id    BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    external_id   TEXT NOT NULL,
    name          TEXT NOT NULL,
    iban          TEXT NOT NULL DEFAULT '',
    currency      CHAR(3) NOT NULL,
    balance_cents BIGINT NOT NULL DEFAULT 0,
    balance_at    TIMESTAMPTZ,
    is_primary    BOOLEAN NOT NULL DEFAULT false,
    last_sync_at  TIMESTAMPTZ,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (connection_id, external_id)
);
CREATE INDEX idx_bank_accounts_company ON bank_accounts(company_id);

CREATE TABLE invoices (
    id                  BIGSERIAL PRIMARY KEY,
    company_id          BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    project_id          BIGINT NOT NULL REFERENCES projects(id),
    number              TEXT,
    status              TEXT NOT NULL CHECK (status IN ('draft', 'open', 'paid', 'cancelled')),
    issue_date          DATE NOT NULL,
    due_date            DATE NOT NULL,
    currency            CHAR(3) NOT NULL,
    subtotal_cents      BIGINT NOT NULL DEFAULT 0,
    vat_cents           BIGINT NOT NULL DEFAULT 0,
    total_cents         BIGINT NOT NULL DEFAULT 0,
    notes               TEXT NOT NULL DEFAULT '',
    reference           TEXT NOT NULL DEFAULT '',
    paid_at             TIMESTAMPTZ,
    paid_transaction_id BIGINT,
    sent_at             TIMESTAMPTZ,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (company_id, number)
);
CREATE INDEX idx_invoices_company_status ON invoices(company_id, status, due_date);
CREATE INDEX idx_invoices_project ON invoices(project_id);

CREATE TABLE invoice_items (
    id               BIGSERIAL PRIMARY KEY,
    invoice_id       BIGINT NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
    position         INT NOT NULL,
    description      TEXT NOT NULL,
    quantity_milli   BIGINT NOT NULL,
    unit_price_cents BIGINT NOT NULL,
    vat_rate_bp      INT NOT NULL,
    net_cents        BIGINT NOT NULL,
    vat_cents        BIGINT NOT NULL
);
CREATE INDEX idx_invoice_items_invoice ON invoice_items(invoice_id);

CREATE TABLE bank_transactions (
    id                BIGSERIAL PRIMARY KEY,
    account_id        BIGINT NOT NULL REFERENCES bank_accounts(id) ON DELETE CASCADE,
    company_id        BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    external_id       TEXT NOT NULL,
    booked_at         TIMESTAMPTZ NOT NULL,
    value_date        DATE,
    amount_cents      BIGINT NOT NULL,
    currency          CHAR(3) NOT NULL,
    description       TEXT NOT NULL DEFAULT '',
    counterparty_name TEXT NOT NULL DEFAULT '',
    counterparty_iban TEXT NOT NULL DEFAULT '',
    reference         TEXT NOT NULL DEFAULT '',
    raw               JSONB,
    category_id       BIGINT REFERENCES categories(id) ON DELETE SET NULL,
    note              TEXT NOT NULL DEFAULT '',
    status            TEXT NOT NULL DEFAULT 'unexplained' CHECK (status IN ('unexplained', 'explained', 'approved')),
    invoice_id        BIGINT REFERENCES invoices(id) ON DELETE SET NULL,
    created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (account_id, external_id)
);
CREATE INDEX idx_bank_transactions_company_booked ON bank_transactions(company_id, booked_at DESC);
CREATE INDEX idx_bank_transactions_account_booked ON bank_transactions(account_id, booked_at DESC);
CREATE INDEX idx_bank_transactions_invoice ON bank_transactions(invoice_id);

ALTER TABLE invoices
    ADD CONSTRAINT invoices_paid_transaction_fk
    FOREIGN KEY (paid_transaction_id) REFERENCES bank_transactions(id) ON DELETE SET NULL;

CREATE TABLE attachments (
    id             BIGSERIAL PRIMARY KEY,
    company_id     BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    transaction_id BIGINT REFERENCES bank_transactions(id) ON DELETE CASCADE,
    invoice_id     BIGINT REFERENCES invoices(id) ON DELETE CASCADE,
    filename       TEXT NOT NULL,
    path           TEXT NOT NULL,
    mime           TEXT NOT NULL,
    size_bytes     BIGINT NOT NULL,
    uploaded_by    BIGINT REFERENCES users(id) ON DELETE SET NULL,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_attachments_transaction ON attachments(transaction_id);
CREATE INDEX idx_attachments_invoice ON attachments(invoice_id);
