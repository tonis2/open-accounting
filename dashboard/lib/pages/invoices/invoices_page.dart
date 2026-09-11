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

enum _Filter { all, open, overdue, paid, draft, cancelled }

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  List<Invoice> _invoices = [];
  int _total = 0;
  int _page = 1;
  static const _pageSize = 25;
  _Filter _filter = _Filter.all;
  SortState _sort = const SortState('date', ascending: false);
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
    setState(() => _loading = true);
    final req = ListInvoicesRequest(companyId: _companyId, page: _page, pageSize: _pageSize);
    switch (_filter) {
      case _Filter.open:
        req.status = InvoiceStatus.INVOICE_STATUS_OPEN;
      case _Filter.overdue:
        req.onlyOverdue = true;
      case _Filter.paid:
        req.status = InvoiceStatus.INVOICE_STATUS_PAID;
      case _Filter.draft:
        req.status = InvoiceStatus.INVOICE_STATUS_DRAFT;
      case _Filter.cancelled:
        req.status = InvoiceStatus.INVOICE_STATUS_CANCELLED;
      case _Filter.all:
        break;
    }
    try {
      final res = await state.server.listInvoices(req);
      if (mounted) {
        setState(() {
          _invoices = res.items;
          _total = res.total;
        });
      }
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<Invoice> get _sorted {
    final list = [..._invoices];
    int cmp(Invoice a, Invoice b) => switch (_sort.key) {
      'due' => a.dueDate.compareTo(b.dueDate),
      'number' => a.number.compareTo(b.number),
      'project' => a.projectName.toLowerCase().compareTo(b.projectName.toLowerCase()),
      'total' => a.totalCents.compareTo(b.totalCents),
      'status' => a.status.value.compareTo(b.status.value),
      _ => a.issueDate.compareTo(b.issueDate),
    };
    list.sort((a, b) => _sort.ascending ? cmp(a, b) : cmp(b, a));
    return list;
  }

  String _filterLabel(AppLocalizations l, _Filter f) => switch (f) {
    _Filter.all => l.invoiceFilterAll,
    _Filter.open => l.invoiceFilterOpen,
    _Filter.overdue => l.invoiceFilterOverdue,
    _Filter.paid => l.invoiceFilterPaid,
    _Filter.draft => l.invoiceFilterDraft,
    _Filter.cancelled => l.invoiceFilterCancelled,
  };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final wide = isDesktop(context);
    final rows = _sorted;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: l.invoicesTitle,
          actions: [ElevatedButton(onPressed: () => context.go(AppRoutes.invoiceNew), child: Text(l.newInvoice))],
        ),
        PanelCard(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: HeaderDropdown<_Filter>(
                    value: _filter,
                    items: [for (final f in _Filter.values) DropdownMenuItem(value: f, child: Text(_filterLabel(l, f)))],
                    onChanged: (v) {
                      setState(() {
                        _filter = v ?? _Filter.all;
                        _page = 1;
                      });
                      _load();
                    },
                  ),
                ),
              ),
              if (_loading)
                const SkeletonLines(lines: 6)
              else
                CustomTable(
                  bordered: false,
                  sort: _sort,
                  onSort: (s) => setState(() => _sort = s),
                  onRowTap: (i) => context.go('${AppRoutes.invoice}/${rows[i].id}'),
                  columns: [
                    TableColumn(header: l.invoiceDate, size: const FlexColumn(2), sortKey: 'date'),
                    if (wide) TableColumn(header: l.invoiceDueDate, size: const FlexColumn(2), sortKey: 'due'),
                    TableColumn(header: l.invoiceReference, size: const FlexColumn(2), sortKey: 'number'),
                    if (wide) TableColumn(header: l.invoiceContactAndProject, size: const FlexColumn(4), sortKey: 'project'),
                    TableColumn(header: l.invoiceTotalValue, size: const FlexColumn(2), align: TextAlign.right, sortKey: 'total'),
                    TableColumn(header: l.invoiceStatus, size: const FlexColumn(3), sortKey: 'status', padding: const EdgeInsets.only(left: 20)),
                    const TableColumn(header: '', size: FixedColumn(110), align: TextAlign.right),
                  ],
                  itemCount: rows.length,
                  emptyState: EmptyState(
                    icon: Icons.receipt_long_outlined,
                    title: l.noInvoicesTitle,
                    subtitle: l.noInvoicesBody,
                    buttonLabel: l.newInvoice,
                    onButtonPressed: () => context.go(AppRoutes.invoiceNew),
                  ),
                  footer: _total > _pageSize
                      ? TablePager(
                          page: _page,
                          pageSize: _pageSize,
                          total: _total,
                          label: (p, t) => l.pageOf(p, t),
                          onPage: (p) {
                            setState(() => _page = p);
                            _load();
                          },
                        )
                      : null,
                  rowBuilder: (i) {
                    final inv = rows[i];
                    return [
                      Text(formatIsoDate(inv.issueDate)),
                      if (wide) Text(formatIsoDate(inv.dueDate)),
                      LinkText(inv.number.isEmpty ? l.draftInvoice : l.invoiceTitle(inv.number), onTap: () => context.go('${AppRoutes.invoice}/${inv.id}')),
                      if (wide) LinkText(inv.projectName.toUpperCase(), onTap: () => context.go('${AppRoutes.project}/${inv.projectId}')),
                      MoneyText(inv.totalCents, currency: inv.currency, style: theme.textTheme.bodyMedium),
                      invoiceStatusText(context, inv),
                      InvoiceActionsButton(invoice: inv, onChanged: _load),
                    ];
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
