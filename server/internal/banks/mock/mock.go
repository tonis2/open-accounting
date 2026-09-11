package mock

import (
	"context"
	"encoding/json"
	"fmt"
	"hash/fnv"
	"math/rand/v2"
	"strconv"
	"time"

	"open-accounting/server/internal/banks"
)

// Provider generates deterministic fake accounts and transactions for development and tests.
type Provider struct {
	// InvoiceHints returns open invoice numbers+totals so the mock can emit matching incoming
	// payments. The sync runner passes the company id in cfg["_company_id"]. Optional.
	InvoiceHints func(ctx context.Context, cfg banks.Config) []InvoiceHint
}

type InvoiceHint struct {
	Number     string
	TotalCents int64
	Currency   string
	Payer      string
}

func New() *Provider { return &Provider{} }

func (p *Provider) ID() string   { return "mock" }
func (p *Provider) Name() string { return "Demo bank" }
func (p *Provider) Description() string {
	return "Generates sample accounts and transactions. For testing only."
}
func (p *Provider) NeedsRedirect() bool { return false }

func (p *Provider) ConfigFields() []banks.ConfigField {
	return []banks.ConfigField{
		{Key: "seed", Label: "Seed", Hint: "Any text; the same seed always produces the same data", Kind: banks.FieldText, Default: "demo"},
	}
}

type state struct {
	Seed uint64 `json:"seed"`
}

func seedOf(cfg banks.Config) uint64 {
	h := fnv.New64a()
	_, _ = h.Write([]byte(cfg["seed"]))
	return h.Sum64()
}

func (p *Provider) Connect(_ context.Context, cfg banks.Config, _ string) (banks.ConnectResult, error) {
	st, _ := json.Marshal(state{Seed: seedOf(cfg)})
	exp := time.Now().Add(365 * 24 * time.Hour)
	return banks.ConnectResult{State: st, ConsentExpiresAt: &exp}, nil
}

func (p *Provider) CompleteConnect(_ context.Context, _ banks.Config, st json.RawMessage, _ map[string]string) (banks.ConnectResult, error) {
	return banks.ConnectResult{State: st}, nil
}

func (p *Provider) ListAccounts(_ context.Context, cfg banks.Config, _ json.RawMessage) ([]banks.Account, error) {
	seed := seedOf(cfg)
	now := time.Now()
	return []banks.Account{
		{ExternalID: "eur-main", Name: "Demo business EUR", IBAN: fmt.Sprintf("EE38%016d", seed%1e16), Currency: "EUR", BalanceCents: balanceAt(seed, "eur-main", now), BalanceAt: now},
		{ExternalID: "usd-side", Name: "Demo USD", IBAN: fmt.Sprintf("EE71%016d", (seed/7)%1e16), Currency: "USD", BalanceCents: balanceAt(seed, "usd-side", now), BalanceAt: now},
	}, nil
}

// balanceAt sums all generated transactions up to `at` on top of an opening balance.
func balanceAt(seed uint64, acct string, at time.Time) int64 {
	total := int64(2_000_000) // 20,000.00 opening
	if acct != "eur-main" {
		total = 50_000
	}
	from := at.AddDate(-1, 0, 0)
	for _, t := range generate(seed, acct, currencyOf(acct), from, at) {
		total += t.AmountCents
	}
	return total
}

func currencyOf(acct string) string {
	if acct == "usd-side" {
		return "USD"
	}
	return "EUR"
}

func (p *Provider) FetchTransactions(ctx context.Context, cfg banks.Config, _ json.RawMessage, acct banks.Account, from, to time.Time) ([]banks.Transaction, error) {
	seed := seedOf(cfg)
	txs := generate(seed, acct.ExternalID, acct.Currency, from, to)
	if p.InvoiceHints != nil && acct.ExternalID == "eur-main" {
		for _, h := range p.InvoiceHints(ctx, cfg) {
			if h.Currency != acct.Currency {
				continue
			}
			day := to.Add(-36 * time.Hour)
			txs = append(txs, banks.Transaction{
				ExternalID:       "inv-pay-" + h.Number,
				BookedAt:         day,
				ValueDate:        day,
				AmountCents:      h.TotalCents,
				Currency:         acct.Currency,
				Description:      "Incoming payment",
				CounterpartyName: h.Payer,
				CounterpartyIBAN: "EE901234567890123456",
				Reference:        "Invoice " + h.Number,
			})
		}
	}
	return txs, nil
}

var expenses = []struct {
	name, desc string
	min, max   int64
}{
	{"Wise Europe SA", "Card fee", 31, 99},
	{"Anthropic PBC", "Claude subscription", 9_000, 12_000},
	{"Hetzner Online GmbH", "Server hosting", 2_400, 4_900},
	{"Google Ireland Ltd", "Workspace", 1_300, 2_600},
	{"Bolt Operations OÜ", "Taxi", 800, 2_400},
	{"Telia Eesti AS", "Mobile", 1_500, 2_500},
	{"Rimi Eesti Food AS", "Office snacks", 1_200, 4_500},
	{"Coop Pank", "Bank charges", 100, 700},
}

var incomes = []struct{ name, desc string }{
	{"Paysure Solutions Ltd", "Consulting services"},
	{"Northwind Traders", "Development work"},
	{"Contoso Ltd", "Monthly retainer"},
}

// generate yields the same rows for the same (seed, account, day).
func generate(seed uint64, acct, currency string, from, to time.Time) []banks.Transaction {
	var out []banks.Transaction
	h := fnv.New64a()
	_, _ = h.Write([]byte(acct))
	acctSeed := h.Sum64()
	day := time.Date(from.Year(), from.Month(), from.Day(), 0, 0, 0, 0, time.UTC)
	end := time.Date(to.Year(), to.Month(), to.Day(), 0, 0, 0, 0, time.UTC)
	for ; !day.After(end); day = day.AddDate(0, 0, 1) {
		r := rand.New(rand.NewPCG(seed^acctSeed, uint64(day.Unix())))
		n := r.IntN(3) // 0-2 expenses per day
		for i := 0; i < n; i++ {
			e := expenses[r.IntN(len(expenses))]
			amt := e.min + r.Int64N(e.max-e.min+1)
			at := day.Add(time.Duration(8+r.IntN(10)) * time.Hour)
			out = append(out, banks.Transaction{
				ExternalID:       fmt.Sprintf("%s-%s-%d", acct, day.Format("20060102"), i),
				BookedAt:         at,
				ValueDate:        day,
				AmountCents:      -amt,
				Currency:         currency,
				Description:      e.desc,
				CounterpartyName: e.name,
				Reference:        "CARD-" + strconv.FormatUint(r.Uint64()%1e10, 10),
			})
		}
		// one income around the 5th and 20th
		if day.Day() == 5 || day.Day() == 20 {
			inc := incomes[r.IntN(len(incomes))]
			amt := int64(150_000 + r.Int64N(450_000))
			out = append(out, banks.Transaction{
				ExternalID:       fmt.Sprintf("%s-%s-in", acct, day.Format("20060102")),
				BookedAt:         day.Add(11 * time.Hour),
				ValueDate:        day,
				AmountCents:      amt,
				Currency:         currency,
				Description:      inc.desc,
				CounterpartyName: inc.name,
				CounterpartyIBAN: "GB29NWBK60161331926819",
				Reference:        inc.desc,
			})
		}
	}
	return out
}
