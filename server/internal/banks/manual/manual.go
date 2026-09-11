package manual

import (
	"context"
	"encoding/json"
	"strings"
	"time"

	"open-accounting/server/internal/banks"
)

// Provider represents an account with no API access: transactions arrive through uploaded
// statements and the balance is derived from them.
type Provider struct{}

func New() *Provider { return &Provider{} }

func (p *Provider) ID() string   { return "manual" }
func (p *Provider) Name() string { return "Statement uploads" }
func (p *Provider) Description() string {
	return "For banks without API access. Add the account, then upload CSV statements downloaded from your online bank."
}
func (p *Provider) NeedsRedirect() bool { return false }

// BalanceFromTransactions tells the sync runner to compute the balance from imported rows.
func (p *Provider) BalanceFromTransactions() bool { return true }

func (p *Provider) ConfigFields() []banks.ConfigField {
	return []banks.ConfigField{
		{Key: "account_name", Label: "Account name", Hint: "e.g. LHV business account", Kind: banks.FieldText, Required: true},
		{Key: "iban", Label: "IBAN", Kind: banks.FieldText},
		{Key: "currency", Label: "Currency", Kind: banks.FieldSelect, Options: []string{"EUR", "USD", "GBP", "SEK", "NOK", "DKK", "PLN", "CHF"}, Default: "EUR", Required: true},
		{Key: "opening_balance", Label: "Opening balance", Hint: "Balance before the first statement you will upload, e.g. 1250.00", Kind: banks.FieldText, Default: "0"},
	}
}

func (p *Provider) Connect(_ context.Context, _ banks.Config, _ string) (banks.ConnectResult, error) {
	return banks.ConnectResult{State: json.RawMessage(`{}`)}, nil
}

func (p *Provider) CompleteConnect(_ context.Context, _ banks.Config, st json.RawMessage, _ map[string]string) (banks.ConnectResult, error) {
	return banks.ConnectResult{State: st}, nil
}

func (p *Provider) ListAccounts(_ context.Context, cfg banks.Config, _ json.RawMessage) ([]banks.Account, error) {
	name := strings.TrimSpace(cfg["account_name"])
	if name == "" {
		name = "Bank account"
	}
	return []banks.Account{{ExternalID: "manual", Name: name, IBAN: strings.TrimSpace(cfg["iban"]), Currency: strings.ToUpper(cfg["currency"]), BalanceAt: time.Now()}}, nil
}

func (p *Provider) FetchTransactions(context.Context, banks.Config, json.RawMessage, banks.Account, time.Time, time.Time) ([]banks.Transaction, error) {
	return nil, nil
}
