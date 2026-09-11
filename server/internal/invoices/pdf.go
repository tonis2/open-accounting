package invoices

import (
	"bytes"
	_ "embed"
	"fmt"
	"strings"

	"github.com/go-pdf/fpdf"

	"open-accounting/server/internal/money"
)

//go:embed assets/DejaVuSans.ttf
var fontRegular []byte

//go:embed assets/DejaVuSans-Bold.ttf
var fontBold []byte

const font = "DejaVu"

// RenderPDF produces an A4 invoice. All amounts are formatted in the invoice currency.
func RenderPDF(inv Invoice, co Company, pr Project) ([]byte, error) {
	pdf := fpdf.New("P", "mm", "A4", "")
	pdf.SetMargins(18, 18, 18)
	pdf.SetAutoPageBreak(true, 22)
	pdf.AddUTF8FontFromBytes(font, "", fontRegular)
	pdf.AddUTF8FontFromBytes(font, "B", fontBold)
	pdf.AddPage()

	pageW, _ := pdf.GetPageSize()
	left, _, right, _ := pdf.GetMargins()
	contentW := pageW - left - right
	cur := inv.Currency
	fmtMoney := func(c int64) string { return money.Format(c, "") + " " + cur }

	// Header: company left, invoice meta right
	pdf.SetFont(font, "B", 16)
	pdf.CellFormat(contentW/2, 8, co.Name, "", 0, "L", false, 0, "")
	pdf.SetFont(font, "B", 20)
	pdf.CellFormat(contentW/2, 8, "INVOICE", "", 1, "R", false, 0, "")

	pdf.SetFont(font, "", 9)
	pdf.SetTextColor(90, 90, 90)
	companyLines := nonEmpty(co.Address, kv("Reg. no", co.RegNumber), kv("VAT no", co.VatNumber), co.Email, co.Phone)
	meta := [][2]string{
		{"Invoice number", inv.Number},
		{"Issue date", inv.IssueDate.Format("02 Jan 2006")},
		{"Due date", inv.DueDate.Format("02 Jan 2006")},
	}
	if inv.Reference != "" {
		meta = append(meta, [2]string{"Reference", inv.Reference})
	}
	rows := max(len(companyLines), len(meta))
	for i := 0; i < rows; i++ {
		l := ""
		if i < len(companyLines) {
			l = companyLines[i]
		}
		pdf.CellFormat(contentW/2, 5, l, "", 0, "L", false, 0, "")
		if i < len(meta) {
			pdf.SetFont(font, "", 9)
			pdf.CellFormat(contentW/4, 5, meta[i][0], "", 0, "R", false, 0, "")
			pdf.SetFont(font, "B", 9)
			pdf.SetTextColor(30, 30, 30)
			pdf.CellFormat(contentW/4, 5, meta[i][1], "", 1, "R", false, 0, "")
			pdf.SetTextColor(90, 90, 90)
		} else {
			pdf.Ln(5)
		}
	}
	pdf.Ln(8)

	// Bill to
	pdf.SetFont(font, "B", 9)
	pdf.SetTextColor(120, 120, 120)
	pdf.CellFormat(contentW, 5, "BILL TO", "", 1, "L", false, 0, "")
	pdf.SetTextColor(30, 30, 30)
	pdf.SetFont(font, "B", 11)
	pdf.CellFormat(contentW, 6, pr.Name, "", 1, "L", false, 0, "")
	pdf.SetFont(font, "", 9)
	for _, l := range nonEmpty(pr.ContactName, pr.Address, kv("Reg. no", pr.RegNumber), kv("VAT no", pr.VatNumber), pr.Email) {
		pdf.CellFormat(contentW, 5, l, "", 1, "L", false, 0, "")
	}
	pdf.Ln(8)

	// Items table
	colW := []float64{contentW * 0.46, contentW * 0.10, contentW * 0.16, contentW * 0.10, contentW * 0.18}
	headers := []string{"Description", "Qty", "Unit price", "VAT", "Total"}
	aligns := []string{"L", "R", "R", "R", "R"}
	drawHeader := func() {
		pdf.SetFillColor(242, 246, 250)
		pdf.SetFont(font, "B", 9)
		for i, h := range headers {
			pdf.CellFormat(colW[i], 8, h, "B", 0, aligns[i], true, 0, "")
		}
		pdf.Ln(-1)
	}
	drawHeader()
	pdf.SetFont(font, "", 9)
	for _, it := range inv.Items {
		lines := pdf.SplitText(it.Description, colW[0]-2)
		h := float64(len(lines)) * 5
		if h < 8 {
			h = 8
		}
		if pdf.GetY()+h > 297-22 {
			pdf.AddPage()
			drawHeader()
			pdf.SetFont(font, "", 9)
		}
		x, y := pdf.GetX(), pdf.GetY()
		pdf.MultiCell(colW[0], 5, it.Description, "", "L", false)
		pdf.SetXY(x+colW[0], y)
		pdf.CellFormat(colW[1], h, trimZeros(money.FormatDecimal(it.QuantityMilli, 3)), "", 0, "R", false, 0, "")
		pdf.CellFormat(colW[2], h, money.Format(it.UnitCents, ""), "", 0, "R", false, 0, "")
		pdf.CellFormat(colW[3], h, trimZeros(money.FormatDecimal(it.VatRateBp, 2))+"%", "", 0, "R", false, 0, "")
		pdf.CellFormat(colW[4], h, money.Format(it.NetCents, ""), "", 1, "R", false, 0, "")
		pdf.SetDrawColor(230, 230, 230)
		pdf.Line(left, pdf.GetY(), left+contentW, pdf.GetY())
	}
	pdf.Ln(4)

	// Totals
	totalRow := func(label, value string, bold bool) {
		if bold {
			pdf.SetFont(font, "B", 11)
		} else {
			pdf.SetFont(font, "", 9)
		}
		pdf.CellFormat(contentW*0.64, 7, "", "", 0, "L", false, 0, "")
		pdf.CellFormat(contentW*0.18, 7, label, "", 0, "R", false, 0, "")
		pdf.CellFormat(contentW*0.18, 7, value, "", 1, "R", false, 0, "")
	}
	totalRow("Subtotal", fmtMoney(inv.SubtotalCents), false)
	totalRow("VAT", fmtMoney(inv.VatCents), false)
	pdf.SetDrawColor(30, 30, 30)
	pdf.Line(left+contentW*0.64, pdf.GetY(), left+contentW, pdf.GetY())
	totalRow("Total due", fmtMoney(inv.TotalCents), true)
	pdf.Ln(10)

	// Payment details + notes
	pdf.SetFont(font, "B", 9)
	pdf.SetTextColor(120, 120, 120)
	pdf.CellFormat(contentW, 5, "PAYMENT DETAILS", "", 1, "L", false, 0, "")
	pdf.SetTextColor(30, 30, 30)
	pdf.SetFont(font, "", 9)
	for _, l := range nonEmpty(kv("Beneficiary", co.Name), kv("Bank", co.BankName), kv("IBAN", co.IBAN), kv("Payment reference", inv.Number)) {
		pdf.CellFormat(contentW, 5, l, "", 1, "L", false, 0, "")
	}
	if strings.TrimSpace(inv.Notes) != "" {
		pdf.Ln(4)
		pdf.SetFont(font, "B", 9)
		pdf.SetTextColor(120, 120, 120)
		pdf.CellFormat(contentW, 5, "NOTES", "", 1, "L", false, 0, "")
		pdf.SetTextColor(30, 30, 30)
		pdf.SetFont(font, "", 9)
		pdf.MultiCell(contentW, 5, inv.Notes, "", "L", false)
	}

	var buf bytes.Buffer
	if err := pdf.Output(&buf); err != nil {
		return nil, fmt.Errorf("pdf: %w", err)
	}
	return buf.Bytes(), nil
}

func kv(label, v string) string {
	if strings.TrimSpace(v) == "" {
		return ""
	}
	return label + ": " + v
}

func nonEmpty(vals ...string) []string {
	out := make([]string, 0, len(vals))
	for _, v := range vals {
		if strings.TrimSpace(v) != "" {
			out = append(out, v)
		}
	}
	return out
}

// trimZeros turns "2.500" into "2.5" and "24.00" into "24".
func trimZeros(s string) string {
	if !strings.Contains(s, ".") {
		return s
	}
	s = strings.TrimRight(s, "0")
	return strings.TrimSuffix(s, ".")
}
