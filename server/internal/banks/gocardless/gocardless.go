package gocardless

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/url"
	"strings"
	"time"

	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/money"
)

const baseURL = "https://bankaccountdata.gocardless.com/api/v2"

// Provider implements the GoCardless Bank Account Data (ex-Nordigen) open-banking flow:
// agreement → requisition → user authorises at the bank → accounts become readable for 90 days.
type Provider struct{ http *http.Client }

func New(client *http.Client) *Provider {
	if client == nil {
		client = &http.Client{Timeout: 30 * time.Second}
	}
	return &Provider{http: client}
}

func (p *Provider) ID() string   { return "gocardless" }
func (p *Provider) Name() string { return "GoCardless Bank Account Data" }
func (p *Provider) Description() string {
	return "Open banking access to 2,500+ European banks. You will be redirected to your bank to give consent (valid 90 days)."
}
func (p *Provider) NeedsRedirect() bool { return true }

// MinSyncInterval respects the API's per-account daily request budget.
func (p *Provider) MinSyncInterval() time.Duration { return 6 * time.Hour }

func (p *Provider) ConfigFields() []banks.ConfigField {
	return []banks.ConfigField{
		{Key: "secret_id", Label: "Secret ID", Hint: "From bankaccountdata.gocardless.com → User secrets", Kind: banks.FieldText, Required: true},
		{Key: "secret_key", Label: "Secret key", Kind: banks.FieldSecret, Required: true},
		{Key: "country", Label: "Country", Kind: banks.FieldSelect, Options: []string{"EE", "LV", "LT", "FI", "SE", "DE", "GB", "NL", "FR", "ES", "IT", "PL"}, Default: "EE", Required: true},
		{Key: "institution_id", Label: "Bank", Hint: "Pick your bank (use SANDBOXFINANCE_SFIN0000 to test)", Kind: banks.FieldText, Required: true},
	}
}

type state struct {
	Access        string    `json:"access"`
	AccessExpires time.Time `json:"access_expires"`
	AgreementID   string    `json:"agreement_id"`
	RequisitionID string    `json:"requisition_id"`
	Reference     string    `json:"reference"`
}

// ---- token handling ----

type tokenResp struct {
	Access        string `json:"access"`
	AccessExpires int    `json:"access_expires"`
}

func (p *Provider) token(ctx context.Context, cfg banks.Config, st *state) (string, error) {
	if st.Access != "" && time.Now().Before(st.AccessExpires.Add(-5*time.Minute)) {
		return st.Access, nil
	}
	var tr tokenResp
	err := p.call(ctx, "", http.MethodPost, "/token/new/", map[string]string{"secret_id": cfg["secret_id"], "secret_key": cfg["secret_key"]}, &tr)
	if err != nil {
		return "", err
	}
	st.Access = tr.Access
	st.AccessExpires = time.Now().Add(time.Duration(tr.AccessExpires) * time.Second)
	return tr.Access, nil
}

// ---- institutions ----

type institution struct {
	ID                   string `json:"id"`
	Name                 string `json:"name"`
	BIC                  string `json:"bic"`
	Logo                 string `json:"logo"`
	TransactionTotalDays string `json:"transaction_total_days"`
}

func (p *Provider) ListInstitutions(ctx context.Context, cfg banks.Config, country string) ([]banks.Institution, error) {
	st := &state{}
	tok, err := p.token(ctx, cfg, st)
	if err != nil {
		return nil, err
	}
	var list []institution
	if err := p.call(ctx, tok, http.MethodGet, "/institutions/?country="+url.QueryEscape(country), nil, &list); err != nil {
		return nil, err
	}
	out := make([]banks.Institution, 0, len(list)+1)
	out = append(out, banks.Institution{ID: "SANDBOXFINANCE_SFIN0000", Name: "Sandbox Finance (test bank)", TransactionTotalDays: 90})
	for _, i := range list {
		days := 0
		fmt.Sscanf(i.TransactionTotalDays, "%d", &days)
		out = append(out, banks.Institution{ID: i.ID, Name: i.Name, BIC: i.BIC, LogoURL: i.Logo, TransactionTotalDays: days})
	}
	return out, nil
}

// ---- connect ----

type agreementResp struct {
	ID                 string `json:"id"`
	AccessValidForDays int    `json:"access_valid_for_days"`
}

type requisitionResp struct {
	ID       string   `json:"id"`
	Status   string   `json:"status"`
	Link     string   `json:"link"`
	Accounts []string `json:"accounts"`
}

func (p *Provider) Connect(ctx context.Context, cfg banks.Config, callbackURL string) (banks.ConnectResult, error) {
	st := &state{}
	tok, err := p.token(ctx, cfg, st)
	if err != nil {
		return banks.ConnectResult{}, err
	}
	var agr agreementResp
	err = p.call(ctx, tok, http.MethodPost, "/agreements/enduser/", map[string]any{
		"institution_id":        cfg["institution_id"],
		"max_historical_days":   90,
		"access_valid_for_days": 90,
		"access_scope":          []string{"balances", "details", "transactions"},
	}, &agr)
	if err != nil {
		return banks.ConnectResult{}, err
	}
	// The callback URL already carries ?ref=<connection reference>; GoCardless appends its own ref too.
	ref := refFromCallback(callbackURL)
	var req requisitionResp
	err = p.call(ctx, tok, http.MethodPost, "/requisitions/", map[string]any{
		"redirect":       callbackURL,
		"institution_id": cfg["institution_id"],
		"reference":      ref,
		"agreement":      agr.ID,
		"user_language":  "EN",
	}, &req)
	if err != nil {
		return banks.ConnectResult{}, err
	}
	st.AgreementID = agr.ID
	st.RequisitionID = req.ID
	st.Reference = ref
	raw, _ := json.Marshal(st)
	return banks.ConnectResult{RedirectURL: req.Link, State: raw}, nil
}

func refFromCallback(cb string) string {
	u, err := url.Parse(cb)
	if err == nil {
		if r := u.Query().Get("ref"); r != "" {
			return r
		}
	}
	return fmt.Sprintf("oa-%d", time.Now().UnixNano())
}

func (p *Provider) CompleteConnect(ctx context.Context, cfg banks.Config, raw json.RawMessage, _ map[string]string) (banks.ConnectResult, error) {
	var st state
	if err := json.Unmarshal(raw, &st); err != nil {
		return banks.ConnectResult{}, err
	}
	tok, err := p.token(ctx, cfg, &st)
	if err != nil {
		return banks.ConnectResult{}, err
	}
	var req requisitionResp
	if err := p.call(ctx, tok, http.MethodGet, "/requisitions/"+st.RequisitionID+"/", nil, &req); err != nil {
		return banks.ConnectResult{}, err
	}
	switch req.Status {
	case "LN":
	case "EX":
		return banks.ConnectResult{}, banks.ErrConsentExpired
	case "RJ":
		return banks.ConnectResult{}, fmt.Errorf("the bank rejected the authorisation")
	default:
		return banks.ConnectResult{}, fmt.Errorf("bank authorisation not finished yet (status %s)", req.Status)
	}
	exp := time.Now().Add(90 * 24 * time.Hour)
	out, _ := json.Marshal(st)
	return banks.ConnectResult{State: out, ConsentExpiresAt: &exp}, nil
}

// ---- accounts ----

type accountDetails struct {
	Account struct {
		IBAN      string `json:"iban"`
		Currency  string `json:"currency"`
		OwnerName string `json:"ownerName"`
		Name      string `json:"name"`
		Product   string `json:"product"`
	} `json:"account"`
}

type balancesResp struct {
	Balances []struct {
		BalanceAmount struct {
			Amount   string `json:"amount"`
			Currency string `json:"currency"`
		} `json:"balanceAmount"`
		BalanceType   string `json:"balanceType"`
		ReferenceDate string `json:"referenceDate"`
	} `json:"balances"`
}

func (p *Provider) ListAccounts(ctx context.Context, cfg banks.Config, raw json.RawMessage) ([]banks.Account, error) {
	var st state
	if err := json.Unmarshal(raw, &st); err != nil {
		return nil, err
	}
	tok, err := p.token(ctx, cfg, &st)
	if err != nil {
		return nil, err
	}
	var req requisitionResp
	if err := p.call(ctx, tok, http.MethodGet, "/requisitions/"+st.RequisitionID+"/", nil, &req); err != nil {
		return nil, err
	}
	if req.Status == "EX" {
		return nil, banks.ErrConsentExpired
	}
	out := make([]banks.Account, 0, len(req.Accounts))
	for _, id := range req.Accounts {
		var det accountDetails
		if err := p.call(ctx, tok, http.MethodGet, "/accounts/"+id+"/details/", nil, &det); err != nil {
			return nil, err
		}
		acct := banks.Account{ExternalID: id, IBAN: det.Account.IBAN, Currency: det.Account.Currency}
		acct.Name = firstNonEmpty(det.Account.Name, det.Account.Product, det.Account.OwnerName, "Account "+det.Account.Currency)
		var bal balancesResp
		if err := p.call(ctx, tok, http.MethodGet, "/accounts/"+id+"/balances/", nil, &bal); err == nil {
			pick := -1
			for i, b := range bal.Balances {
				if b.BalanceType == "interimAvailable" || (pick < 0 && (b.BalanceType == "closingBooked" || b.BalanceType == "expected")) {
					pick = i
					if b.BalanceType == "interimAvailable" {
						break
					}
				}
			}
			if pick < 0 && len(bal.Balances) > 0 {
				pick = 0
			}
			if pick >= 0 {
				acct.BalanceCents, _ = money.ParseCents(bal.Balances[pick].BalanceAmount.Amount)
				if acct.Currency == "" {
					acct.Currency = bal.Balances[pick].BalanceAmount.Currency
				}
				acct.BalanceAt = time.Now()
			}
		}
		out = append(out, acct)
	}
	return out, nil
}

// ---- transactions ----

type txResp struct {
	Transactions struct {
		Booked []txRow `json:"booked"`
	} `json:"transactions"`
}

type txRow struct {
	TransactionID         string `json:"transactionId"`
	InternalTransactionID string `json:"internalTransactionId"`
	BookingDate           string `json:"bookingDate"`
	BookingDateTime       string `json:"bookingDateTime"`
	ValueDate             string `json:"valueDate"`
	TransactionAmount     struct {
		Amount   string `json:"amount"`
		Currency string `json:"currency"`
	} `json:"transactionAmount"`
	CreditorName    string `json:"creditorName"`
	DebtorName      string `json:"debtorName"`
	CreditorAccount struct {
		IBAN string `json:"iban"`
	} `json:"creditorAccount"`
	DebtorAccount struct {
		IBAN string `json:"iban"`
	} `json:"debtorAccount"`
	RemittanceInformationUnstructured      string   `json:"remittanceInformationUnstructured"`
	RemittanceInformationUnstructuredArray []string `json:"remittanceInformationUnstructuredArray"`
	AdditionalInformation                  string   `json:"additionalInformation"`
}

func (p *Provider) FetchTransactions(ctx context.Context, cfg banks.Config, raw json.RawMessage, acct banks.Account, from, to time.Time) ([]banks.Transaction, error) {
	var st state
	if err := json.Unmarshal(raw, &st); err != nil {
		return nil, err
	}
	tok, err := p.token(ctx, cfg, &st)
	if err != nil {
		return nil, err
	}
	path := fmt.Sprintf("/accounts/%s/transactions/?date_from=%s&date_to=%s", acct.ExternalID, from.Format("2006-01-02"), to.Format("2006-01-02"))
	var resp txResp
	if err := p.call(ctx, tok, http.MethodGet, path, nil, &resp); err != nil {
		return nil, err
	}
	out := make([]banks.Transaction, 0, len(resp.Transactions.Booked))
	for i, r := range resp.Transactions.Booked {
		cents, _ := money.ParseCents(r.TransactionAmount.Amount)
		booked := parseDate(r.BookingDateTime, r.BookingDate)
		ext := firstNonEmpty(r.InternalTransactionID, r.TransactionID, fmt.Sprintf("%s-%d-%d", r.BookingDate, cents, i))
		remit := r.RemittanceInformationUnstructured
		if remit == "" {
			remit = strings.Join(r.RemittanceInformationUnstructuredArray, " ")
		}
		counterparty, iban := r.DebtorName, r.DebtorAccount.IBAN
		if cents < 0 {
			counterparty, iban = r.CreditorName, r.CreditorAccount.IBAN
		}
		rawRow, _ := json.Marshal(r)
		out = append(out, banks.Transaction{
			ExternalID:       ext,
			BookedAt:         booked,
			ValueDate:        parseDate("", r.ValueDate),
			AmountCents:      cents,
			Currency:         r.TransactionAmount.Currency,
			Description:      firstNonEmpty(remit, r.AdditionalInformation, counterparty),
			CounterpartyName: counterparty,
			CounterpartyIBAN: iban,
			Reference:        remit,
			Raw:              rawRow,
		})
	}
	return out, nil
}

// ---- http ----

type apiError struct {
	Summary string `json:"summary"`
	Detail  string `json:"detail"`
	Status  int    `json:"status_code"`
}

func (p *Provider) call(ctx context.Context, token, method, path string, body any, out any) error {
	var rdr io.Reader
	if body != nil {
		b, _ := json.Marshal(body)
		rdr = bytes.NewReader(b)
	}
	req, err := http.NewRequestWithContext(ctx, method, baseURL+path, rdr)
	if err != nil {
		return err
	}
	req.Header.Set("Accept", "application/json")
	if body != nil {
		req.Header.Set("Content-Type", "application/json")
	}
	if token != "" {
		req.Header.Set("Authorization", "Bearer "+token)
	}
	resp, err := p.http.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	data, _ := io.ReadAll(io.LimitReader(resp.Body, 16<<20))
	if resp.StatusCode >= 300 {
		var ae apiError
		_ = json.Unmarshal(data, &ae)
		msg := strings.TrimSpace(ae.Summary + " " + ae.Detail)
		if strings.Contains(strings.ToLower(msg), "expired") || strings.Contains(strings.ToLower(msg), "eua") {
			return fmt.Errorf("%w: %s", banks.ErrConsentExpired, msg)
		}
		if msg == "" {
			msg = string(data)
		}
		return fmt.Errorf("gocardless %s: HTTP %d: %s", path, resp.StatusCode, truncate(msg, 300))
	}
	if out == nil {
		return nil
	}
	return json.Unmarshal(data, out)
}

func parseDate(dt, d string) time.Time {
	if dt != "" {
		if t, err := time.Parse(time.RFC3339, dt); err == nil {
			return t
		}
	}
	if t, err := time.Parse("2006-01-02", d); err == nil {
		return t
	}
	return time.Time{}
}

func firstNonEmpty(vals ...string) string {
	for _, v := range vals {
		if strings.TrimSpace(v) != "" {
			return v
		}
	}
	return ""
}

func truncate(s string, n int) string {
	if len(s) <= n {
		return s
	}
	return s[:n] + "…"
}
