package wise

import (
	"context"
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/json"
	"encoding/pem"
	"errors"
	"fmt"
	"io"
	"log/slog"
	"net/http"
	"net/url"
	"strconv"
	"strings"
	"time"

	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/money"
)

const (
	prodHost    = "https://api.wise.com"
	sandboxHost = "https://api.sandbox.transferwise.tech"
)

// Provider talks to the Wise (TransferWise) API with a personal/business API token.
// Balance statements require Strong Customer Authentication: Wise answers 403 with a one-time
// token that must be signed with the RSA private key whose public half is registered in Wise.
type Provider struct{ http *http.Client }

func New(client *http.Client) *Provider {
	if client == nil {
		client = &http.Client{Timeout: 30 * time.Second}
	}
	return &Provider{http: client}
}

func (p *Provider) ID() string   { return "wise" }
func (p *Provider) Name() string { return "Wise" }
func (p *Provider) Description() string {
	return "Connects a Wise account with an API token. Balances sync automatically; transactions come from uploaded CSV statements unless a business account with an RSA key is used."
}
func (p *Provider) NeedsRedirect() bool { return false }

func (p *Provider) ConfigFields() []banks.ConfigField {
	return []banks.ConfigField{
		{Key: "api_token", Label: "API token", Hint: "Wise → Settings → API tokens (full access)", Kind: banks.FieldSecret, Required: true},
		{Key: "private_key_pem", Label: "RSA private key (PEM)", Hint: "Only useful for business accounts based in the US, Canada, Australia, New Zealand, Singapore or Malaysia — Wise does not serve API statements elsewhere. Register the public half in Wise → Settings → API tokens → Manage public keys.", Kind: banks.FieldMultiline},
		{Key: "profile_type", Label: "Profile", Kind: banks.FieldSelect, Options: []string{"business", "personal"}, Default: "business", Required: true},
		{Key: "profile_id", Label: "Profile ID", Hint: "Only needed when the Wise account has several profiles of that type — the connection error lists them.", Kind: banks.FieldText},
		{Key: "sandbox", Label: "Use sandbox", Kind: banks.FieldBool, Default: "false"},
	}
}

type state struct {
	ProfileID int64 `json:"profile_id"`
}

func (p *Provider) host(cfg banks.Config) string {
	if cfg["sandbox"] == "true" {
		return sandboxHost
	}
	return prodHost
}

type profile struct {
	ID           int64  `json:"id"`
	Type         string `json:"type"`
	FullName     string `json:"fullName"`
	BusinessName string `json:"businessName"`
}

func (pr profile) name() string {
	if pr.BusinessName != "" {
		return pr.BusinessName
	}
	return pr.FullName
}

func (p *Provider) Connect(ctx context.Context, cfg banks.Config, _ string) (banks.ConnectResult, error) {
	var profiles []profile
	if err := p.get(ctx, cfg, "/v2/profiles", nil, &profiles); err != nil {
		return banks.ConnectResult{}, err
	}
	pr, err := pickProfile(profiles, cfg["profile_type"], cfg["profile_id"])
	if err != nil {
		return banks.ConnectResult{}, err
	}
	st, _ := json.Marshal(state{ProfileID: pr.ID})
	return banks.ConnectResult{State: st}, nil
}

// pickProfile selects the profile of the wanted type; with several of them the user must
// name one explicitly, since public keys and balances belong to a single profile.
func pickProfile(profiles []profile, wantType, wantID string) (profile, error) {
	var matches []profile
	for _, pr := range profiles {
		if strings.EqualFold(pr.Type, wantType) {
			matches = append(matches, pr)
		}
	}
	for _, pr := range matches {
		if strconv.FormatInt(pr.ID, 10) == strings.TrimSpace(wantID) {
			return pr, nil
		}
	}
	// An unknown or empty id falls through: a single candidate is used, several are offered.
	switch len(matches) {
	case 0:
		return profile{}, fmt.Errorf("no %s profile found on this Wise account", wantType)
	case 1:
		return matches[0], nil
	}
	choice := &banks.ChoiceRequired{Field: "profile_id", Label: "Wise profile"}
	for _, pr := range matches {
		choice.Options = append(choice.Options, banks.Option{Value: strconv.FormatInt(pr.ID, 10), Label: pr.name()})
	}
	return profile{}, choice
}

func (p *Provider) CompleteConnect(_ context.Context, _ banks.Config, st json.RawMessage, _ map[string]string) (banks.ConnectResult, error) {
	return banks.ConnectResult{State: st}, nil
}

type balance struct {
	ID       int64  `json:"id"`
	Currency string `json:"currency"`
	Name     string `json:"name"`
	Amount   struct {
		Value    json.Number `json:"value"`
		Currency string      `json:"currency"`
	} `json:"amount"`
	ModificationTime time.Time `json:"modificationTime"`
}

func (p *Provider) ListAccounts(ctx context.Context, cfg banks.Config, raw json.RawMessage) ([]banks.Account, error) {
	var st state
	if err := json.Unmarshal(raw, &st); err != nil {
		return nil, err
	}
	var balances []balance
	path := fmt.Sprintf("/v4/profiles/%d/balances", st.ProfileID)
	if err := p.get(ctx, cfg, path, url.Values{"types": {"STANDARD"}}, &balances); err != nil {
		return nil, err
	}
	out := make([]banks.Account, 0, len(balances))
	for _, b := range balances {
		cents, _ := numberToCents(b.Amount.Value)
		name := b.Name
		if name == "" {
			name = "Wise " + b.Currency
		}
		at := b.ModificationTime
		if at.IsZero() {
			at = time.Now()
		}
		out = append(out, banks.Account{ExternalID: strconv.FormatInt(b.ID, 10), Name: name, Currency: b.Currency, BalanceCents: cents, BalanceAt: at})
	}
	return out, nil
}

type statement struct {
	Transactions []struct {
		Type   string    `json:"type"`
		Date   time.Time `json:"date"`
		Amount struct {
			Value    json.Number `json:"value"`
			Currency string      `json:"currency"`
		} `json:"amount"`
		Details struct {
			Type             string `json:"type"`
			Description      string `json:"description"`
			PaymentReference string `json:"paymentReference"`
			SenderName       string `json:"senderName"`
			SenderAccount    string `json:"senderAccount"`
			Merchant         *struct {
				Name string `json:"name"`
			} `json:"merchant"`
			Recipient *struct {
				Name        string `json:"name"`
				BankAccount string `json:"bankAccount"`
			} `json:"recipient"`
		} `json:"details"`
		ReferenceNumber string `json:"referenceNumber"`
	} `json:"transactions"`
}

func (p *Provider) FetchTransactions(ctx context.Context, cfg banks.Config, raw json.RawMessage, acct banks.Account, from, to time.Time) ([]banks.Transaction, error) {
	// Without a signing key statements cannot be requested (Wise withdrew SCA signing for
	// personal accounts), so the connection stays balance-only and rows come from uploads.
	if strings.TrimSpace(cfg["private_key_pem"]) == "" {
		return nil, nil
	}
	var st state
	if err := json.Unmarshal(raw, &st); err != nil {
		return nil, err
	}
	q := url.Values{
		"currency":      {acct.Currency},
		"intervalStart": {from.UTC().Format("2006-01-02T15:04:05.000Z")},
		"intervalEnd":   {to.UTC().Format("2006-01-02T15:04:05.000Z")},
		"type":          {"COMPACT"},
	}
	path := fmt.Sprintf("/v1/profiles/%d/balance-statements/%s/statement.json", st.ProfileID, acct.ExternalID)
	var stmt statement
	if err := p.get(ctx, cfg, path, q, &stmt); err != nil {
		return nil, err
	}
	out := make([]banks.Transaction, 0, len(stmt.Transactions))
	for i, t := range stmt.Transactions {
		cents, _ := numberToCents(t.Amount.Value)
		if t.Type == "DEBIT" && cents > 0 {
			cents = -cents
		}
		counterparty := t.Details.SenderName
		iban := t.Details.SenderAccount
		if t.Details.Merchant != nil && t.Details.Merchant.Name != "" {
			counterparty = t.Details.Merchant.Name
		}
		if t.Details.Recipient != nil && t.Details.Recipient.Name != "" {
			counterparty = t.Details.Recipient.Name
			iban = t.Details.Recipient.BankAccount
		}
		ext := t.ReferenceNumber
		if ext == "" {
			ext = fmt.Sprintf("%s-%d", t.Date.Format("20060102"), i)
		}
		rawRow, _ := json.Marshal(t)
		out = append(out, banks.Transaction{
			ExternalID:       ext,
			BookedAt:         t.Date,
			ValueDate:        t.Date,
			AmountCents:      cents,
			Currency:         t.Amount.Currency,
			Description:      t.Details.Description,
			CounterpartyName: counterparty,
			CounterpartyIBAN: iban,
			Reference:        t.Details.PaymentReference,
			Raw:              rawRow,
		})
	}
	return out, nil
}

// get performs an authenticated GET, transparently completing the SCA challenge once.
func (p *Provider) get(ctx context.Context, cfg banks.Config, path string, q url.Values, out any) error {
	u := p.host(cfg) + path
	if len(q) > 0 {
		u += "?" + q.Encode()
	}
	do := func(ott, sig string) (*http.Response, error) {
		req, err := http.NewRequestWithContext(ctx, http.MethodGet, u, nil)
		if err != nil {
			return nil, err
		}
		req.Header.Set("Authorization", "Bearer "+cfg["api_token"])
		req.Header.Set("Accept", "application/json")
		if ott != "" {
			// Raw keys: sent verbatim over HTTP/1.1 instead of Go's canonical X-2fa-Approval.
			req.Header["x-2fa-approval"] = []string{ott}
			req.Header["X-Signature"] = []string{sig}
		}
		return p.http.Do(req)
	}
	resp, err := do("", "")
	if err != nil {
		return err
	}
	signed := false
	if resp.StatusCode == http.StatusForbidden && resp.Header.Get("x-2fa-approval") != "" {
		ott := resp.Header.Get("x-2fa-approval")
		_ = resp.Body.Close()
		sig, err := signOTT(cfg["private_key_pem"], ott)
		if err != nil {
			return err
		}
		if resp, err = do(ott, sig); err != nil {
			return err
		}
		signed = true
		slog.Debug("[WISE] SCA exchange", "path", path, "ott_len", len(ott), "sig_len", len(sig),
			"status", resp.StatusCode, "result", resp.Header.Get("x-2fa-approval-result"), "new_ott", resp.Header.Get("x-2fa-approval") != "")
	}
	defer resp.Body.Close()
	body, _ := io.ReadAll(io.LimitReader(resp.Body, 8<<20))
	switch {
	case resp.StatusCode == http.StatusUnauthorized:
		return fmt.Errorf("%w: Wise rejected the API token", banks.ErrConsentExpired)
	case resp.StatusCode == http.StatusForbidden && signed:
		slog.Warn("[WISE] SCA signature rejected", "path", path, "result", resp.Header.Get("x-2fa-approval-result"))
		return fmt.Errorf("%w: Wise rejected the signed statement request. Personal API tokens only get statements for accounts based in the US, Canada, Australia, New Zealand, Singapore or Malaysia; elsewhere upload CSV statements. Balances keep syncing.", banks.ErrStatementsUnavailable)
	case resp.StatusCode == http.StatusForbidden:
		slog.Warn("[WISE] forbidden without SCA challenge", "path", path, "body", truncate(string(body), 300))
		return errors.New("Wise refused access without asking for a signature: check that the API token was created under this business profile")
	case resp.StatusCode >= 300:
		return fmt.Errorf("wise %s: HTTP %d: %s", path, resp.StatusCode, truncate(string(body), 300))
	}
	return json.Unmarshal(body, out)
}

// signOTT signs the one-time token with RSA-SHA256 as required by Wise SCA.
func signOTT(pemKey, ott string) (string, error) {
	if strings.TrimSpace(pemKey) == "" {
		return "", errors.New("Wise needs an RSA private key to download statements — open Edit connection, paste the key whose public half is registered in Wise (Settings → API tokens → Manage public keys)")
	}
	block, _ := pem.Decode([]byte(pemKey))
	if block == nil {
		return "", errors.New("invalid PEM private key")
	}
	var key *rsa.PrivateKey
	if k, err := x509.ParsePKCS1PrivateKey(block.Bytes); err == nil {
		key = k
	} else if k8, err := x509.ParsePKCS8PrivateKey(block.Bytes); err == nil {
		rk, ok := k8.(*rsa.PrivateKey)
		if !ok {
			return "", errors.New("private key is not RSA")
		}
		key = rk
	} else {
		return "", errors.New("could not parse RSA private key")
	}
	sum := sha256.Sum256([]byte(ott))
	sig, err := rsa.SignPKCS1v15(rand.Reader, key, crypto.SHA256, sum[:])
	if err != nil {
		return "", err
	}
	return base64.StdEncoding.EncodeToString(sig), nil
}

func numberToCents(n json.Number) (int64, error) {
	return money.ParseCents(string(n))
}

func truncate(s string, n int) string {
	if len(s) <= n {
		return s
	}
	return s[:n] + "…"
}
