import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../responsive.dart';
import '../../services/errors.dart';
import '../../services/format.dart';
import '../../state.dart';
import 'invoice_actions.dart';
import 'invoice_status.dart';

class InvoiceDetailPage extends StatefulWidget {
  final String invoiceId;
  const InvoiceDetailPage({super.key, required this.invoiceId});

  @override
  State<InvoiceDetailPage> createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  Invoice? _invoice;
  Project? _project;
  bool _loading = true;
  Int64 _companyId = Int64.ZERO;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = Inherited.of(context).companyId;
    if (id != _companyId) {
      _companyId = id;
      _load();
    }
  }

  Future<void> _load() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      final inv = await state.server.getInvoice(CompanyIdRequest(companyId: _companyId, id: Int64.parseInt(widget.invoiceId)));
      final project = await state.server.getProject(CompanyIdRequest(companyId: _companyId, id: inv.projectId));
      if (!mounted) return;
      setState(() {
        _invoice = inv;
        _project = project;
        _loading = false;
      });
    } catch (e) {
      if (mounted) setState(() => _loading = false);
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = Inherited.of(context);
    final inv = _invoice;
    final wide = isDesktop(context);
    if (_loading || inv == null) return const SkeletonLines(lines: 8);
    final company = state.activeCompany;
    final cur = inv.currency;
    final actions = InvoiceActions(context, inv, _load);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: inv.number.isEmpty ? l.draftInvoice : l.invoiceTitle(inv.number),
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go(AppRoutes.invoices)),
          actions: [
            if (inv.status == InvoiceStatus.INVOICE_STATUS_DRAFT) ...[
              OutlinedButton(onPressed: () => context.go('${AppRoutes.invoice}/${inv.id}/edit'), child: Text(l.edit)),
              ElevatedButton(onPressed: actions.issue, child: Text(l.invoiceIssue)),
            ] else ...[
              OutlinedButton.icon(onPressed: actions.downloadPdf, icon: const Icon(Icons.download, size: 18), label: Text(l.invoiceDownloadPdf)),
              if (inv.status == InvoiceStatus.INVOICE_STATUS_OPEN) OutlinedButton(onPressed: actions.send, child: Text(l.invoiceSend)),
              if (inv.status == InvoiceStatus.INVOICE_STATUS_OPEN) ElevatedButton(onPressed: actions.markPaid, child: Text(l.invoiceMarkPaid)),
            ],
            InvoiceActionsButton(invoice: inv, onChanged: _load),
          ],
        ),
        if (inv.isOverdue) AlertBanner(title: l.invoiceStatusOverdue, message: l.invoiceOverdueBanner, kind: BadgeKind.danger),
        PanelCard(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 28,
            children: [
              // Header: from / meta
              Flex(
                direction: wide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  Expanded(
                    flex: wide ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text(l.invoiceFrom, style: theme.textTheme.labelSmall),
                        Text(company?.name ?? '', style: theme.textTheme.titleLarge),
                        if ((company?.address ?? '').isNotEmpty) Text(company!.address, style: theme.textTheme.bodySmall),
                        if ((company?.regNumber ?? '').isNotEmpty) Text('${l.companyRegNumber}: ${company!.regNumber}', style: theme.textTheme.bodySmall),
                        if ((company?.vatNumber ?? '').isNotEmpty) Text('${l.companyVatNumber}: ${company!.vatNumber}', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: wide ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Text(inv.number.isEmpty ? l.draftInvoice : inv.number, style: theme.textTheme.headlineSmall),
                          invoiceStatusBadge(context, inv),
                        ],
                      ),
                      _meta(theme, l.invoiceDate, formatIsoDate(inv.issueDate)),
                      _meta(theme, l.invoiceDueDate, formatIsoDate(inv.dueDate)),
                      if (inv.reference.isNotEmpty) _meta(theme, l.invoiceCustomerReference, inv.reference),
                      if (inv.hasSentAt()) _meta(theme, l.invoiceSend, l.invoiceSentOn(formatTimestamp(inv.sentAt))),
                    ],
                  ),
                ],
              ),
              // Bill to
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(l.invoiceBillTo, style: theme.textTheme.labelSmall),
                  LinkText(_project?.name ?? inv.projectName, onTap: () => context.go('${AppRoutes.project}/${inv.projectId}')),
                  if ((_project?.contactName ?? '').isNotEmpty) Text(_project!.contactName, style: theme.textTheme.bodySmall),
                  if ((_project?.address ?? '').isNotEmpty) Text(_project!.address, style: theme.textTheme.bodySmall),
                  if ((_project?.email ?? '').isNotEmpty) Text(_project!.email, style: theme.textTheme.bodySmall),
                ],
              ),
              // Lines
              CustomTable(
                columns: [
                  TableColumn(header: l.invoiceLineDescription, size: const FlexColumn(5)),
                  TableColumn(header: l.invoiceLineQuantity, size: const FlexColumn(1), align: TextAlign.right),
                  if (wide) TableColumn(header: l.invoiceLineUnitPrice, size: const FlexColumn(2), align: TextAlign.right),
                  if (wide) TableColumn(header: l.invoiceLineVat, size: const FlexColumn(1), align: TextAlign.right),
                  TableColumn(header: l.invoiceLineTotal, size: const FlexColumn(2), align: TextAlign.right),
                ],
                itemCount: inv.items.length,
                rowBuilder: (i) {
                  final it = inv.items[i];
                  return [
                    Text(it.description),
                    Text(trimDecimal(it.quantity)),
                    if (wide) MoneyText(it.unitPriceCents, currency: cur),
                    if (wide) Text('${trimDecimal(it.vatRate)}%'),
                    MoneyText(it.netCents, currency: cur),
                  ];
                },
              ),
              Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 320,
                    child: Column(
                      spacing: 8,
                      children: [
                        _total(theme, l.invoiceSubtotal, formatMoney(inv.subtotalCents, currency: cur)),
                        _total(theme, l.invoiceVat, formatMoney(inv.vatCents, currency: cur)),
                        const Divider(),
                        _total(theme, l.invoiceTotal, formatMoney(inv.totalCents, currency: cur), bold: true),
                      ],
                    ),
                  ),
                ],
              ),
              if (inv.status == InvoiceStatus.INVOICE_STATUS_PAID)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: const Color(0xFFE6F4E6), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    spacing: 10,
                    children: [
                      const Icon(Icons.check_circle, color: Color(0xFF3A8F3A), size: 20),
                      Expanded(
                        child: Text(
                          inv.paidTransactionId != Int64.ZERO
                              ? '${l.invoicePaidOn(formatTimestamp(inv.paidAt))} · ${l.invoicePaidBy}'
                              : l.invoicePaidOn(formatTimestamp(inv.paidAt)),
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              if (inv.notes.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(l.invoiceNotes, style: theme.textTheme.labelSmall),
                    Text(inv.notes, style: theme.textTheme.bodyMedium),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _meta(ThemeData theme, String label, String value) => Row(
    mainAxisSize: MainAxisSize.min,
    spacing: 8,
    children: [
      Text(label, style: theme.textTheme.bodySmall),
      Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
    ],
  );

  Widget _total(ThemeData theme, String label, String value, {bool bold = false}) {
    final style = bold ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}
