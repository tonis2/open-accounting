import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../services/format.dart';
import '../../state.dart';
import '../invoices/invoice_status.dart';
import 'project_form_dialog.dart';

class ProjectDetailPage extends StatefulWidget {
  final String projectId;
  const ProjectDetailPage({super.key, required this.projectId});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  Project? _project;
  List<Invoice> _invoices = [];
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
    final pid = Int64.parseInt(widget.projectId);
    try {
      final results = await Future.wait([
        state.server.getProject(CompanyIdRequest(companyId: _companyId, id: pid)),
        state.server.listInvoices(ListInvoicesRequest(companyId: _companyId, projectId: pid, pageSize: 100)),
      ]);
      if (!mounted) return;
      setState(() {
        _project = results[0] as Project;
        _invoices = (results[1] as ListInvoicesResponse).items;
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
    final cur = Inherited.of(context).activeCompany?.currency ?? '';
    final p = _project;
    if (_loading || p == null) return const SkeletonLines(lines: 6);

    Widget detail(String label, String value) => value.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.labelSmall),
              Text(value, style: theme.textTheme.bodyMedium),
            ],
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: p.name,
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go(AppRoutes.projects)),
          actions: [
            OutlinedButton(
              onPressed: () async {
                final saved = await ProjectFormDialog.show(context, project: p);
                if (saved != null) setState(() => _project = saved);
              },
              child: Text(l.edit),
            ),
            ElevatedButton(onPressed: () => context.go('${AppRoutes.invoiceNew}?project=${p.id}'), child: Text(l.newInvoice)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Expanded(
              flex: 2,
              child: PanelCard(
                title: l.projectContact,
                child: Wrap(
                  spacing: 32,
                  runSpacing: 16,
                  children: [
                    detail(l.projectContactName, p.contactName),
                    detail(l.projectEmail, p.email),
                    detail(l.projectAddress, p.address),
                    detail(l.projectRegNumber, p.regNumber),
                    detail(l.projectVatNumber, p.vatNumber),
                    detail(l.projectDescription, p.description),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PanelCard(
                padding: EdgeInsets.zero,
                child: StatColumn(
                  tiles: [
                    StatTile(
                      label: l.projectInvoiced,
                      value: formatMoney(p.invoicedCents, currency: cur),
                    ),
                    StatTile(
                      label: l.projectOutstanding,
                      value: formatMoney(p.outstandingCents, currency: cur),
                      tone: p.outstandingCents > Int64.ZERO ? StatTone.warning : StatTone.neutral,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        PanelCard(
          title: l.projectInvoices,
          padding: EdgeInsets.zero,
          child: CustomTable(
            bordered: false,
            columns: [
              TableColumn(header: l.invoiceDate, size: const FlexColumn(2)),
              TableColumn(header: l.invoiceDueDate, size: const FlexColumn(2)),
              TableColumn(header: l.invoiceReference, size: const FlexColumn(2)),
              TableColumn(header: l.invoiceTotalValue, size: const FlexColumn(2), align: TextAlign.right),
              TableColumn(header: l.invoiceStatus, size: const FlexColumn(3), padding: const EdgeInsets.only(left: 20)),
            ],
            itemCount: _invoices.length,
            emptyState: Text(l.noResults, style: theme.textTheme.bodySmall),
            onRowTap: (i) => context.go('${AppRoutes.invoice}/${_invoices[i].id}'),
            rowBuilder: (i) {
              final inv = _invoices[i];
              return [
                Text(formatIsoDate(inv.issueDate)),
                Text(formatIsoDate(inv.dueDate)),
                LinkText(inv.number.isEmpty ? l.draftInvoice : inv.number, onTap: () => context.go('${AppRoutes.invoice}/${inv.id}')),
                MoneyText(inv.totalCents, currency: inv.currency),
                invoiceStatusText(context, inv),
              ];
            },
          ),
        ),
      ],
    );
  }
}
