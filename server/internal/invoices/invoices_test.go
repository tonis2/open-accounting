package invoices

import "testing"

func TestTotals(t *testing.T) {
	items := []Item{
		{QuantityMilli: 10_000, UnitCents: 8_000, VatRateBp: 2400}, // 10 x 80.00 = 800.00 + 192.00
		{QuantityMilli: 1_500, UnitCents: 3_333, VatRateBp: 2400},  // 1.5 x 33.33 = 50.00 (49.995) + 12.00
		{QuantityMilli: 1_000, UnitCents: 10_000, VatRateBp: 0},    // 100.00, no VAT
	}
	sub, vat, total := Totals(items)
	if items[1].NetCents != 5000 {
		t.Fatalf("line net=%d", items[1].NetCents)
	}
	if sub != 95_000 || vat != 20_400 || total != 115_400 {
		t.Fatalf("sub=%d vat=%d total=%d", sub, vat, total)
	}
}
