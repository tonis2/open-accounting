package sync

import (
	"testing"
	"time"
)

func TestMatches(t *testing.T) {
	issued := time.Date(2026, 3, 1, 0, 0, 0, 0, time.UTC)
	inv := OpenInvoice{Number: "INV-0007", TotalCents: 59_5476, Currency: "EUR", IssueDate: issued, ProjectName: "Paysure Solutions Ltd"}
	base := Candidate{AmountCents: 59_5476, Currency: "EUR", BookedAt: issued.AddDate(0, 0, 10)}

	cases := []struct {
		name string
		mod  func(c *Candidate)
		want bool
	}{
		{"number in reference", func(c *Candidate) { c.Reference = "Payment inv 0007 thanks" }, true},
		{"number in description", func(c *Candidate) { c.Description = "INV-0007" }, true},
		{"payer matches project", func(c *Candidate) { c.CounterpartyName = "PAYSURE SOLUTIONS LTD" }, true},
		{"payer partial", func(c *Candidate) { c.CounterpartyName = "Paysure" }, true},
		{"no hint", func(c *Candidate) { c.CounterpartyName = "Someone"; c.Reference = "hello" }, false},
		{"wrong amount", func(c *Candidate) { c.Reference = "INV-0007"; c.AmountCents++ }, false},
		{"wrong currency", func(c *Candidate) { c.Reference = "INV-0007"; c.Currency = "USD" }, false},
		{"too early", func(c *Candidate) { c.Reference = "INV-0007"; c.BookedAt = issued.AddDate(0, 0, -10) }, false},
		{"slightly early ok", func(c *Candidate) { c.Reference = "INV-0007"; c.BookedAt = issued.AddDate(0, 0, -2) }, true},
	}
	for _, tc := range cases {
		c := base
		tc.mod(&c)
		if got := Matches(inv, c); got != tc.want {
			t.Errorf("%s: got %v want %v", tc.name, got, tc.want)
		}
	}
}
