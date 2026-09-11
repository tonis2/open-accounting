import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../services/format.dart';
import '../../state.dart';

/// "Paid on – 28 Aug 26" / "Open – due in 19 days" / "Overdue – 3 days overdue" style status.
Widget invoiceStatusText(BuildContext context, Invoice inv) {
  final l = AppLocalizations.of(context)!;
  switch (inv.status) {
    case InvoiceStatus.INVOICE_STATUS_PAID:
      return StatusText(primary: l.invoiceStatusPaid, secondary: inv.hasPaidAt() ? formatTimestamp(inv.paidAt) : null, tone: BadgeTone.success);
    case InvoiceStatus.INVOICE_STATUS_OPEN:
      final days = daysUntil(inv.dueDate);
      if (days < 0) return StatusText(primary: l.invoiceStatusOverdue, secondary: l.invoiceOverdueByDays(-days), tone: BadgeTone.danger);
      return StatusText(primary: l.invoiceStatusOpen, secondary: days == 0 ? l.invoiceDueToday : l.invoiceDueInDays(days), tone: BadgeTone.warning);
    case InvoiceStatus.INVOICE_STATUS_CANCELLED:
      return StatusText(primary: l.invoiceStatusCancelled, tone: BadgeTone.neutral);
    default:
      return StatusText(primary: l.invoiceStatusDraft, tone: BadgeTone.info);
  }
}

StatusBadge invoiceStatusBadge(BuildContext context, Invoice inv) {
  final l = AppLocalizations.of(context)!;
  return switch (inv.status) {
    InvoiceStatus.INVOICE_STATUS_PAID => StatusBadge(label: l.invoiceStatusPaid, tone: BadgeTone.success),
    InvoiceStatus.INVOICE_STATUS_OPEN =>
      inv.isOverdue ? StatusBadge(label: l.invoiceStatusOverdue, tone: BadgeTone.danger) : StatusBadge(label: l.invoiceStatusOpen, tone: BadgeTone.warning),
    InvoiceStatus.INVOICE_STATUS_CANCELLED => StatusBadge(label: l.invoiceStatusCancelled),
    _ => StatusBadge(label: l.invoiceStatusDraft, tone: BadgeTone.info),
  };
}
