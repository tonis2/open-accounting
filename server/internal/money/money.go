package money

import (
	"fmt"
	"math/big"
	"strconv"
	"strings"
)

// Quantities are stored as thousandths, VAT rates as basis points (2400 = 24.00%).

// RoundHalfUp divides num by den rounding half away from zero.
func RoundHalfUp(num, den int64) int64 {
	if den == 0 {
		return 0
	}
	n := big.NewInt(num)
	d := big.NewInt(den)
	// 2*num + den, floor divided by 2*den, handles negatives via symmetric rounding
	neg := (num < 0) != (den < 0)
	n.Abs(n)
	d.Abs(d)
	twice := new(big.Int).Mul(n, big.NewInt(2))
	twice.Add(twice, d)
	q := twice.Quo(twice, new(big.Int).Mul(d, big.NewInt(2)))
	if neg {
		q.Neg(q)
	}
	return q.Int64()
}

// Net returns the net line amount in cents for a quantity (thousandths) and unit price (cents).
func Net(qtyMilli, unitCents int64) int64 {
	return RoundHalfUp(qtyMilli*unitCents, 1000)
}

// Vat returns the VAT amount in cents for a net amount and rate in basis points.
func Vat(netCents int64, rateBp int64) int64 {
	return RoundHalfUp(netCents*rateBp, 10000)
}

// ParseDecimal parses "12.5" style strings into a fixed-point integer with the given scale (digits).
func ParseDecimal(s string, scale int) (int64, error) {
	s = strings.TrimSpace(strings.ReplaceAll(s, ",", "."))
	if s == "" {
		return 0, fmt.Errorf("empty number")
	}
	neg := strings.HasPrefix(s, "-")
	s = strings.TrimPrefix(s, "-")
	parts := strings.SplitN(s, ".", 2)
	whole, err := strconv.ParseInt(parts[0], 10, 64)
	if parts[0] == "" {
		whole, err = 0, nil
	}
	if err != nil {
		return 0, fmt.Errorf("invalid number %q", s)
	}
	frac := ""
	if len(parts) == 2 {
		frac = parts[1]
	}
	if len(frac) > scale {
		return 0, fmt.Errorf("too many decimals in %q", s)
	}
	frac += strings.Repeat("0", scale-len(frac))
	fracV := int64(0)
	if frac != "" {
		if fracV, err = strconv.ParseInt(frac, 10, 64); err != nil {
			return 0, fmt.Errorf("invalid number %q", s)
		}
	}
	mult := int64(1)
	for i := 0; i < scale; i++ {
		mult *= 10
	}
	v := whole*mult + fracV
	if neg {
		v = -v
	}
	return v, nil
}

// FormatDecimal renders a fixed-point integer with the given scale, e.g. (2400, 2) -> "24.00".
func FormatDecimal(v int64, scale int) string {
	neg := v < 0
	if neg {
		v = -v
	}
	mult := int64(1)
	for i := 0; i < scale; i++ {
		mult *= 10
	}
	s := fmt.Sprintf("%d", v/mult)
	if scale > 0 {
		s += "." + fmt.Sprintf("%0*d", scale, v%mult)
	}
	if neg {
		s = "-" + s
	}
	return s
}

// ParseCents parses a money string like "1234.56" to cents.
func ParseCents(s string) (int64, error) { return ParseDecimal(s, 2) }

// Format renders cents as "1,234.56 EUR".
func Format(cents int64, currency string) string {
	neg := cents < 0
	if neg {
		cents = -cents
	}
	whole := cents / 100
	frac := cents % 100
	ws := strconv.FormatInt(whole, 10)
	var b strings.Builder
	for i, r := range ws {
		if i > 0 && (len(ws)-i)%3 == 0 {
			b.WriteByte(',')
		}
		b.WriteRune(r)
	}
	out := fmt.Sprintf("%s.%02d", b.String(), frac)
	if neg {
		out = "-" + out
	}
	if currency != "" {
		out += " " + currency
	}
	return out
}
