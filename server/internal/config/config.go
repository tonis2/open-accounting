package config

import (
	"encoding/hex"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

// Config holds every runtime setting, read once from the environment.
type Config struct {
	Port        string
	PostgresURL string
	JWTSecret   string
	SecretsKey  []byte
	DataDir     string
	PublicURL   string

	WebAuthnRPID    string
	WebAuthnOrigins []string

	SMTPHost string
	SMTPPort int
	SMTPUser string
	SMTPPass string
	SMTPFrom string

	BankSyncInterval    time.Duration
	MockBankEnabled     bool
	MockBankPayInvoices bool
	AllowRegistration   bool
}

func (c Config) MailEnabled() bool { return c.SMTPHost != "" }

// Load reads the environment and fails fast on missing or malformed required values.
func Load() (Config, error) {
	c := Config{
		Port:                get("PORT", "8080"),
		PostgresURL:         get("POSTGRES_URL", ""),
		JWTSecret:           get("JWT_SECRET", ""),
		DataDir:             get("DATA_DIR", "/data"),
		PublicURL:           strings.TrimRight(get("PUBLIC_URL", "http://localhost"), "/"),
		WebAuthnRPID:        get("WEBAUTHN_RP_ID", "localhost"),
		WebAuthnOrigins:     splitCSV(get("WEBAUTHN_ORIGINS", "http://localhost,http://localhost:8000")),
		SMTPHost:            get("SMTP_HOST", ""),
		SMTPUser:            get("SMTP_USER", ""),
		SMTPPass:            get("SMTP_PASS", ""),
		SMTPFrom:            get("SMTP_FROM", "Open Accounting <noreply@localhost>"),
		MockBankEnabled:     getBool("MOCK_BANK_ENABLED", false),
		MockBankPayInvoices: getBool("MOCK_BANK_PAY_INVOICES", false),
		AllowRegistration:   getBool("ALLOW_REGISTRATION", true),
	}

	if c.PostgresURL == "" {
		return c, fmt.Errorf("POSTGRES_URL is required")
	}
	if len(c.JWTSecret) < 16 {
		return c, fmt.Errorf("JWT_SECRET is required (at least 16 characters)")
	}

	key, err := hex.DecodeString(get("SECRETS_KEY", ""))
	if err != nil || len(key) != 32 {
		return c, fmt.Errorf("SECRETS_KEY must be 32 bytes hex encoded (openssl rand -hex 32)")
	}
	c.SecretsKey = key

	c.SMTPPort, _ = strconv.Atoi(get("SMTP_PORT", "587"))

	c.BankSyncInterval, err = time.ParseDuration(get("BANK_SYNC_INTERVAL", "1h"))
	if err != nil {
		return c, fmt.Errorf("BANK_SYNC_INTERVAL: %w", err)
	}
	return c, nil
}

func get(key, def string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return def
}

func getBool(key string, def bool) bool {
	v := strings.ToLower(get(key, ""))
	if v == "" {
		return def
	}
	return v == "1" || v == "true" || v == "yes"
}

func splitCSV(s string) []string {
	var out []string
	for _, p := range strings.Split(s, ",") {
		if p = strings.TrimSpace(p); p != "" {
			out = append(out, p)
		}
	}
	return out
}
