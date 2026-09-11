package money

import "testing"

func TestRoundHalfUp(t *testing.T) {
	cases := []struct{ num, den, want int64 }{
		{5, 10, 1}, {4, 10, 0}, {15, 10, 2}, {-5, 10, -1}, {-4, 10, 0}, {2500, 1000, 3}, {2499, 1000, 2},
	}
	for _, c := range cases {
		if got := RoundHalfUp(c.num, c.den); got != c.want {
			t.Errorf("RoundHalfUp(%d,%d)=%d want %d", c.num, c.den, got, c.want)
		}
	}
}

func TestNetAndVat(t *testing.T) {
	// 2.5 h * 80.00 = 200.00, VAT 24% = 48.00
	if net := Net(2500, 8000); net != 20000 {
		t.Fatalf("net=%d", net)
	}
	if vat := Vat(20000, 2400); vat != 4800 {
		t.Fatalf("vat=%d", vat)
	}
	// 1 * 0.05 at 24% = 0.012 -> 0.01 ; 0.03 at 20% = 0.006 -> 0.01
	if vat := Vat(5, 2400); vat != 1 {
		t.Fatalf("vat=%d", vat)
	}
	if vat := Vat(3, 2000); vat != 1 {
		t.Fatalf("vat=%d", vat)
	}
	// 3 * 33.33 = 99.99
	if net := Net(3000, 3333); net != 9999 {
		t.Fatalf("net=%d", net)
	}
}

func TestParseFormatDecimal(t *testing.T) {
	cases := []struct {
		in    string
		scale int
		want  int64
	}{
		{"24", 2, 2400}, {"24.5", 2, 2450}, {"0.005", 3, 5}, {"-12.34", 2, -1234}, {"1,5", 3, 1500}, {".5", 2, 50},
	}
	for _, c := range cases {
		got, err := ParseDecimal(c.in, c.scale)
		if err != nil || got != c.want {
			t.Errorf("ParseDecimal(%q,%d)=%d,%v want %d", c.in, c.scale, got, err, c.want)
		}
	}
	if _, err := ParseDecimal("1.234", 2); err == nil {
		t.Error("expected error for too many decimals")
	}
	if s := FormatDecimal(2400, 2); s != "24.00" {
		t.Errorf("got %s", s)
	}
	if s := FormatDecimal(-1500, 3); s != "-1.500" {
		t.Errorf("got %s", s)
	}
	if s := Format(123456789, "EUR"); s != "1,234,567.89 EUR" {
		t.Errorf("got %s", s)
	}
	if s := Format(-5, ""); s != "-0.05" {
		t.Errorf("got %s", s)
	}
}
