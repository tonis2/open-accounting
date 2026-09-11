package statements

import (
	"strings"
	"testing"
)

const wiseCSV = `"TransferWise ID","Date","Amount","Currency","Description","Payment Reference","Running Balance","Exchange From","Exchange To","Exchange Rate","Payer Name","Payee Name","Payee Account Number","Merchant","Card Last Four Digits","Card Holder Full Name","Attachment","Note","Total fees","Exchange To Amount"
"CARD-4279179476","03-09-2026","-0.31","EUR","Wise Charges for: CARD-4279179476","","23339.05","","","","","","","","","","","","0.31",""
"TRANSFER-2359487981","08-09-2026","-1495.06","EUR","Sent money to Tonis Anton","Invoice 12","21675.17","","","","","Tonis Anton","EE382200221020145685","","","","","","4.94",""
"TRANSFER-99","10-09-2026","1455.76","EUR","Received money from PAYSURE SOLUTIONS LTD","INV-0001","23130.93","","","","PAYSURE SOLUTIONS LTD","","","","","","","","0.00",""
`

func TestParseWise(t *testing.T) {
	res, err := Parse([]byte(wiseCSV), "EUR")
	if err != nil {
		t.Fatal(err)
	}
	if len(res.Transactions) != 3 || res.Skipped != 0 {
		t.Fatalf("got %d tx, %d skipped: %v", len(res.Transactions), res.Skipped, res.Warnings)
	}
	tx := res.Transactions[1]
	if tx.ExternalID != "csv-TRANSFER-2359487981" || tx.AmountCents != -149506 || tx.CounterpartyName != "Tonis Anton" || tx.CounterpartyIBAN != "EE382200221020145685" || tx.Reference != "Invoice 12" {
		t.Fatalf("unexpected row %+v", tx)
	}
	if tx.BookedAt.Format("2006-01-02") != "2026-09-08" {
		t.Fatalf("date %v", tx.BookedAt)
	}
	in := res.Transactions[2]
	if in.AmountCents != 145576 || in.CounterpartyName != "PAYSURE SOLUTIONS LTD" || in.Reference != "INV-0001" {
		t.Fatalf("incoming row %+v", in)
	}
	if res.LastBalanceCents == nil || *res.LastBalanceCents != 2313093 {
		t.Fatalf("balance %v", res.LastBalanceCents)
	}
}

func TestParseGenericSemicolonDebitCredit(t *testing.T) {
	csv := "Kuupäev;Selgitus;Saaja;Debet;Kreedit;Valuuta\n" +
		"11.09.2026;Telia arve;Telia Eesti AS;\"20,29\";;EUR\n" +
		"11.09.2026;Laekumine;Northwind;;\"2 702,30\";EUR\n" +
		"11.09.2026;USD row;X;5,00;;USD\n" +
		"not a date;;;;;\n"
	res, err := Parse([]byte(csv), "EUR")
	if err != nil {
		t.Fatal(err)
	}
	if len(res.Transactions) != 2 || res.Skipped != 2 {
		t.Fatalf("got %d tx, %d skipped: %v", len(res.Transactions), res.Skipped, res.Warnings)
	}
	if res.Transactions[0].AmountCents != -2029 || res.Transactions[1].AmountCents != 270230 {
		t.Fatalf("amounts %d %d", res.Transactions[0].AmountCents, res.Transactions[1].AmountCents)
	}
	if !strings.HasPrefix(res.Transactions[0].ExternalID, "csv-") || res.Transactions[0].ExternalID == res.Transactions[1].ExternalID {
		t.Fatalf("ids %s %s", res.Transactions[0].ExternalID, res.Transactions[1].ExternalID)
	}
}

func TestSameRowsGetDistinctIDs(t *testing.T) {
	csv := "Date,Amount,Description\n2026-09-01,-5.00,Coffee\n2026-09-01,-5.00,Coffee\n"
	res, err := Parse([]byte(csv), "EUR")
	if err != nil || len(res.Transactions) != 2 {
		t.Fatalf("%v %d", err, len(res.Transactions))
	}
	if res.Transactions[0].ExternalID == res.Transactions[1].ExternalID {
		t.Fatal("duplicate rows must get distinct ids")
	}
	// Parsing the same file again must produce the same ids (idempotent re-upload).
	again, _ := Parse([]byte(csv), "EUR")
	if again.Transactions[1].ExternalID != res.Transactions[1].ExternalID {
		t.Fatal("ids must be stable across uploads")
	}
}

func TestNoHeader(t *testing.T) {
	if _, err := Parse([]byte("foo,bar\n1,2\n"), "EUR"); err != ErrNoHeader {
		t.Fatalf("expected ErrNoHeader, got %v", err)
	}
}

func TestCleanNumber(t *testing.T) {
	cases := map[string]string{"1 234,56": "1234.56", "1,234.56": "1234.56", "€12.30": "12.30", "-12,30": "-12.30", "20,29": "20.29", "1.234,56": "1234.56"}
	for in, want := range cases {
		if got := cleanNumber(in); got != want {
			t.Errorf("cleanNumber(%q)=%q want %q", in, got, want)
		}
	}
}
