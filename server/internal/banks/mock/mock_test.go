package mock

import (
	"context"
	"testing"
	"time"

	"open-accounting/server/internal/banks"
)

func TestDeterministic(t *testing.T) {
	p := New()
	cfg := banks.Config{"seed": "demo"}
	accts, _ := p.ListAccounts(context.Background(), cfg, nil)
	if len(accts) != 2 {
		t.Fatalf("accounts=%d", len(accts))
	}
	to := time.Date(2026, 3, 31, 0, 0, 0, 0, time.UTC)
	from := to.AddDate(0, -1, 0)
	a, _ := p.FetchTransactions(context.Background(), cfg, nil, accts[0], from, to)
	b, _ := p.FetchTransactions(context.Background(), cfg, nil, accts[0], from, to)
	if len(a) == 0 || len(a) != len(b) {
		t.Fatalf("len a=%d b=%d", len(a), len(b))
	}
	for i := range a {
		if a[i].ExternalID != b[i].ExternalID || a[i].AmountCents != b[i].AmountCents {
			t.Fatalf("row %d differs", i)
		}
	}
	seen := map[string]bool{}
	for _, tx := range a {
		if seen[tx.ExternalID] {
			t.Fatalf("duplicate external id %s", tx.ExternalID)
		}
		seen[tx.ExternalID] = true
	}
}

func TestInvoiceHints(t *testing.T) {
	p := New()
	p.InvoiceHints = func(context.Context, banks.Config) []InvoiceHint {
		return []InvoiceHint{{Number: "INV-0007", TotalCents: 12345, Currency: "EUR", Payer: "Acme"}}
	}
	accts, _ := p.ListAccounts(context.Background(), banks.Config{"seed": "x"}, nil)
	to := time.Now()
	txs, _ := p.FetchTransactions(context.Background(), banks.Config{"seed": "x"}, nil, accts[0], to.AddDate(0, 0, -7), to)
	found := false
	for _, tx := range txs {
		if tx.Reference == "Invoice INV-0007" && tx.AmountCents == 12345 {
			found = true
		}
	}
	if !found {
		t.Fatal("expected invoice payment transaction")
	}
}
