package statements

import (
	"bytes"
	"crypto/sha1"
	"encoding/csv"
	"encoding/hex"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"strings"
	"time"
	"unicode/utf8"

	"open-accounting/server/internal/banks"
	"open-accounting/server/internal/money"
)

// Result of parsing one statement file.
type Result struct {
	Transactions []banks.Transaction
	Skipped      int      // rows without a date/amount, or in another currency
	Warnings     []string // human-readable notes about skipped rows
	// LastBalanceCents is the running balance of the newest row when the file has one.
	LastBalanceCents *int64
}

var ErrNoHeader = errors.New("could not find a header row with date and amount columns")

// column aliases, lower-cased and stripped of spaces/punctuation
var (
	dateCols     = []string{"date", "bookingdate", "transactiondate", "valuedate", "kuupaev", "createdon", "finishedon", "postingdate", "completeddate"}
	amountCols   = []string{"amount", "summa", "value", "transactionamount", "sourceamountafterfees", "amountincl"}
	debitCols    = []string{"debit", "moneyout", "paidout", "withdrawal", "debet"}
	creditCols   = []string{"credit", "moneyin", "paidin", "deposit", "kreedit"}
	currencyCols = []string{"currency", "valuuta", "sourcecurrency"}
	descCols     = []string{"description", "details", "selgitus", "memo", "narrative", "transactiondescription", "text"}
	refCols      = []string{"paymentreference", "reference", "viitenumber", "referencenumber"}
	payerCols    = []string{"payername", "payer", "sender", "sendername", "maksja", "counterparty", "name", "beneficiary", "targetname"}
	payeeCols    = []string{"payeename", "payee", "recipient", "recipientname", "saaja", "merchant"}
	ibanCols     = []string{"payeeaccountnumber", "iban", "account", "counterpartyaccount", "saajakonto", "accountnumber"}
	idCols       = []string{"transferwiseid", "id", "transactionid", "reference number", "arhiveerimistunnus", "archiveid", "documentnumber"}
	balanceCols  = []string{"runningbalance", "balance", "saldo", "closingbalance"}
	dateLayouts  = []string{"2006-01-02", "02-01-2006", "02.01.2006", "02/01/2006", "2006-01-02 15:04:05", "02-01-2006 15:04:05", "2006/01/02", "01/02/2006", "2 Jan 2006", "02 Jan 2006", "Jan 2, 2006", time.RFC3339}
)

var fold = map[rune]rune{'ä': 'a', 'ö': 'o', 'õ': 'o', 'ü': 'u', 'š': 's', 'ž': 'z', 'å': 'a', 'é': 'e', 'ß': 's'}

// norm lower-cases, folds common diacritics and drops everything but letters and digits.
func norm(s string) string {
	var b strings.Builder
	for _, r := range strings.ToLower(strings.TrimSpace(s)) {
		if f, ok := fold[r]; ok {
			r = f
		}
		if r >= 'a' && r <= 'z' || r >= '0' && r <= '9' {
			b.WriteRune(r)
		}
	}
	return b.String()
}

type columns struct {
	date, amount, debit, credit, currency, desc, ref, payer, payee, iban, id, balance int
}

func find(header []string, aliases []string) int {
	normed := make([]string, len(header))
	for i, h := range header {
		normed[i] = norm(h)
	}
	for _, a := range aliases {
		key := norm(a)
		for i, h := range normed {
			if h == key {
				return i
			}
		}
	}
	return -1
}

// Parse reads a CSV (comma or semicolon separated, optional BOM) exported from a bank and
// returns normalised transactions. accountCurrency filters rows in other currencies.
func Parse(data []byte, accountCurrency string) (Result, error) {
	var res Result
	data = bytes.TrimPrefix(data, []byte{0xEF, 0xBB, 0xBF})
	if !utf8.Valid(data) {
		data = bytes.ToValidUTF8(data, []byte("?"))
	}
	sep := detectSeparator(data)

	r := csv.NewReader(bytes.NewReader(data))
	r.Comma = sep
	r.FieldsPerRecord = -1
	r.LazyQuotes = true
	r.TrimLeadingSpace = true

	var cols columns
	headerFound := false
	rowNo := 0
	dayCounter := map[string]int{}
	for {
		rec, err := r.Read()
		if errors.Is(err, io.EOF) {
			break
		}
		if err != nil {
			return res, fmt.Errorf("line %d: %w", rowNo+1, err)
		}
		rowNo++
		if !headerFound {
			c := columns{
				date: find(rec, dateCols), amount: find(rec, amountCols), debit: find(rec, debitCols), credit: find(rec, creditCols),
				currency: find(rec, currencyCols), desc: find(rec, descCols), ref: find(rec, refCols), payer: find(rec, payerCols),
				payee: find(rec, payeeCols), iban: find(rec, ibanCols), id: find(rec, idCols), balance: find(rec, balanceCols),
			}
			if c.date >= 0 && (c.amount >= 0 || c.debit >= 0 || c.credit >= 0) {
				cols = c
				headerFound = true
			}
			continue
		}
		tx, skipReason := parseRow(rec, cols, accountCurrency, dayCounter)
		if skipReason != "" {
			res.Skipped++
			if len(res.Warnings) < 5 {
				res.Warnings = append(res.Warnings, fmt.Sprintf("line %d: %s", rowNo, skipReason))
			}
			continue
		}
		if cols.balance >= 0 && cols.balance < len(rec) {
			if bal, err := money.ParseCents(cleanNumber(rec[cols.balance])); err == nil && (res.LastBalanceCents == nil || !tx.BookedAt.Before(res.Transactions[len(res.Transactions)-1].BookedAt)) {
				b := bal
				res.LastBalanceCents = &b
			}
		}
		res.Transactions = append(res.Transactions, tx)
	}
	if !headerFound {
		return res, ErrNoHeader
	}
	return res, nil
}

func get(rec []string, i int) string {
	if i < 0 || i >= len(rec) {
		return ""
	}
	return strings.TrimSpace(rec[i])
}

func parseRow(rec []string, c columns, accountCurrency string, dayCounter map[string]int) (banks.Transaction, string) {
	var tx banks.Transaction
	dateStr := get(rec, c.date)
	if dateStr == "" {
		return tx, "empty date"
	}
	booked, ok := parseDate(dateStr)
	if !ok {
		return tx, "unrecognised date " + dateStr
	}

	var cents int64
	var err error
	switch {
	case c.amount >= 0 && get(rec, c.amount) != "":
		cents, err = money.ParseCents(cleanNumber(get(rec, c.amount)))
	case c.debit >= 0 && get(rec, c.debit) != "":
		cents, err = money.ParseCents(cleanNumber(get(rec, c.debit)))
		if cents > 0 {
			cents = -cents
		}
	case c.credit >= 0 && get(rec, c.credit) != "":
		cents, err = money.ParseCents(cleanNumber(get(rec, c.credit)))
	default:
		return tx, "no amount"
	}
	if err != nil {
		return tx, "unrecognised amount"
	}
	if cur := strings.ToUpper(get(rec, c.currency)); cur != "" && accountCurrency != "" && cur != strings.ToUpper(accountCurrency) {
		return tx, fmt.Sprintf("currency %s does not match the account (%s)", cur, accountCurrency)
	}

	tx.BookedAt = booked
	tx.ValueDate = booked
	tx.AmountCents = cents
	tx.Currency = strings.ToUpper(firstNonEmpty(get(rec, c.currency), accountCurrency))
	tx.Description = get(rec, c.desc)
	tx.Reference = get(rec, c.ref)
	tx.CounterpartyIBAN = get(rec, c.iban)
	if cents >= 0 {
		tx.CounterpartyName = firstNonEmpty(get(rec, c.payer), get(rec, c.payee))
	} else {
		tx.CounterpartyName = firstNonEmpty(get(rec, c.payee), get(rec, c.payer))
	}
	if tx.Description == "" {
		tx.Description = firstNonEmpty(tx.Reference, tx.CounterpartyName)
	}

	// Stable id: the bank's own id when present, otherwise a hash of the row content plus a
	// per-day counter so identical rows on the same day stay distinct.
	if id := get(rec, c.id); id != "" {
		tx.ExternalID = "csv-" + id
	} else {
		key := fmt.Sprintf("%s|%d|%s|%s", booked.Format("2006-01-02"), cents, tx.Description, tx.Reference)
		dayCounter[key]++
		sum := sha1.Sum([]byte(fmt.Sprintf("%s|%d", key, dayCounter[key])))
		tx.ExternalID = "csv-" + hex.EncodeToString(sum[:10])
	}
	raw := map[string]string{}
	for i, v := range rec {
		raw[fmt.Sprint(i)] = v
	}
	tx.Raw, _ = json.Marshal(raw)
	return tx, ""
}

func parseDate(s string) (time.Time, bool) {
	s = strings.TrimSpace(s)
	for _, layout := range dateLayouts {
		if t, err := time.Parse(layout, s); err == nil {
			return t, true
		}
	}
	return time.Time{}, false
}

// cleanNumber turns "1 234,56", "1,234.56", "€12.30" or "-12,30" into something ParseCents accepts.
func cleanNumber(s string) string {
	s = strings.TrimSpace(s)
	s = strings.Map(func(r rune) rune {
		if r >= '0' && r <= '9' || r == '-' || r == ',' || r == '.' {
			return r
		}
		return -1
	}, s)
	lastComma, lastDot := strings.LastIndex(s, ","), strings.LastIndex(s, ".")
	switch {
	case lastComma > lastDot:
		// comma is the decimal separator
		s = strings.ReplaceAll(s, ".", "")
		s = strings.Replace(s, ",", ".", 1)
		s = strings.ReplaceAll(s[:strings.LastIndex(s, ".")], ",", "") + s[strings.LastIndex(s, "."):]
	default:
		s = strings.ReplaceAll(s, ",", "")
	}
	return s
}

func detectSeparator(data []byte) rune {
	line := data
	if i := bytes.IndexByte(data, '\n'); i > 0 {
		line = data[:i]
	}
	if bytes.Count(line, []byte(";")) > bytes.Count(line, []byte(",")) {
		return ';'
	}
	if bytes.Count(line, []byte("\t")) > bytes.Count(line, []byte(",")) {
		return '\t'
	}
	return ','
}

func firstNonEmpty(vals ...string) string {
	for _, v := range vals {
		if strings.TrimSpace(v) != "" {
			return v
		}
	}
	return ""
}
