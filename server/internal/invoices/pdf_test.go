package invoices

import (
	"bytes"
	"testing"
	"time"
)

func TestRenderPDF(t *testing.T) {
	items := []Item{
		{Position: 1, Description: "Tarkvaraarendus – õäöü €", QuantityMilli: 12_500, UnitCents: 9_000, VatRateBp: 2400},
		{Position: 2, Description: "Hosting", QuantityMilli: 1_000, UnitCents: 4_900, VatRateBp: 2400},
	}
	sub, vat, total := Totals(items)
	inv := Invoice{Number: "INV-0042", IssueDate: time.Now(), DueDate: time.Now().AddDate(0, 0, 14), Currency: "EUR",
		SubtotalCents: sub, VatCents: vat, TotalCents: total, Items: items, Notes: "Thank you!"}
	pdfBytes, err := RenderPDF(inv, Company{Name: "Internus OÜ", IBAN: "EE001234", BankName: "Wise"}, Project{Name: "Paysure Solutions Ltd", Email: "ap@paysure.example"})
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.HasPrefix(pdfBytes, []byte("%PDF")) || len(pdfBytes) < 10_000 {
		t.Fatalf("unexpected pdf output (%d bytes)", len(pdfBytes))
	}
}
