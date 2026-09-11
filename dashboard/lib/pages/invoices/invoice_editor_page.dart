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

class _Line {
  final description = TextEditingController();
  final quantity = TextEditingController(text: '1');
  final unitPrice = TextEditingController();
  final vatRate = TextEditingController();

  _Line({String vat = '24'}) {
    vatRate.text = vat;
  }

  _Line.from(InvoiceItem it) {
    description.text = it.description;
    quantity.text = trimDecimal(it.quantity);
    unitPrice.text = (it.unitPriceCents.toInt() / 100).toStringAsFixed(2);
    vatRate.text = trimDecimal(it.vatRate);
  }

  void dispose() {
    for (final c in [description, quantity, unitPrice, vatRate]) {
      c.dispose();
    }
  }

  double get qty => double.tryParse(quantity.text.replaceAll(',', '.')) ?? 0;
  int get unitCents => parseCents(unitPrice.text) ?? 0;
  double get vat => double.tryParse(vatRate.text.replaceAll(',', '.')) ?? 0;

  // Mirrors the server's per-line rounding so the live totals match the saved invoice.
  int get netCents => (qty * unitCents).round();
  int get vatCents => (netCents * vat / 100).round();

  InvoiceItem toProto() => InvoiceItem(
    description: description.text.trim(),
    quantity: quantity.text.replaceAll(',', '.'),
    unitPriceCents: Int64(unitCents),
    vatRate: vatRate.text.replaceAll(',', '.'),
  );
}

/// Create a draft (no [invoiceId]) or edit an existing draft.
class InvoiceEditorPage extends StatefulWidget {
  final String? invoiceId;
  final String? projectId;
  const InvoiceEditorPage({super.key, this.invoiceId, this.projectId});

  @override
  State<InvoiceEditorPage> createState() => _InvoiceEditorPageState();
}

class _InvoiceEditorPageState extends State<InvoiceEditorPage> {
  final _formKey = GlobalKey<FormState>();
  List<Project> _projects = [];
  Int64? _projectId;
  String _issueDate = isoDate(DateTime.now());
  String _dueDate = '';
  final _reference = TextEditingController();
  final _notes = TextEditingController();
  final List<_Line> _lines = [];
  Invoice? _existing;
  bool _loading = true;
  bool _busy = false;
  String _defaultVat = '24';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _reference.dispose();
    _notes.dispose();
    for (final l in _lines) {
      l.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    final company = state.activeCompany;
    _defaultVat = trimDecimal(company?.defaultVatRate ?? '24');
    _dueDate = isoDate(DateTime.now().add(Duration(days: company?.defaultDueDays ?? 14)));
    try {
      final projects = await state.server.listProjects(ListProjectsRequest(companyId: state.companyId));
      _projects = projects.items;
      if (widget.invoiceId != null) {
        final inv = await state.server.getInvoice(CompanyIdRequest(companyId: state.companyId, id: Int64.parseInt(widget.invoiceId!)));
        _existing = inv;
        _projectId = inv.projectId;
        _issueDate = inv.issueDate;
        _dueDate = inv.dueDate;
        _reference.text = inv.reference;
        _notes.text = inv.notes;
        _lines.addAll(inv.items.map(_Line.from));
      } else {
        if (widget.projectId != null) _projectId = Int64.parseInt(widget.projectId!);
        _projectId ??= _projects.length == 1 ? _projects.first.id : null;
        _lines.add(_Line(vat: _defaultVat));
      }
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Invoice _build(AppState state) => Invoice(
    id: _existing?.id,
    companyId: state.companyId,
    projectId: _projectId,
    issueDate: _issueDate,
    dueDate: _dueDate,
    reference: _reference.text.trim(),
    notes: _notes.text.trim(),
    items: [for (final line in _lines) line.toProto()],
  );

  Future<void> _save({bool issue = false}) async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    if (_projectId == null) {
      AppLogger.warning(l.invoiceNeedsProject);
      return;
    }
    final state = Inherited.read(context);
    setState(() => _busy = true);
    try {
      final inv = _build(state);
      final saved = _existing == null ? await state.server.createInvoice(inv) : await state.server.updateInvoice(inv);
      if (issue) {
        final issued = await state.server.issueInvoice(CompanyIdRequest(companyId: state.companyId, id: saved.id));
        AppLogger.info(l.invoiceIssued(issued.number));
      } else {
        AppLogger.info(l.invoiceSaved);
      }
      if (mounted) context.go('${AppRoutes.invoice}/${saved.id}');
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = Inherited.of(context);
    final cur = state.activeCompany?.currency ?? '';
    final wide = isDesktop(context);
    if (_loading) return const SkeletonLines(lines: 8);

    final subtotal = _lines.fold<int>(0, (a, l) => a + l.netCents);
    final vat = _lines.fold<int>(0, (a, l) => a + l.vatCents);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          PageHeader(
            title: _existing == null ? l.newInvoice : l.editInvoice,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go(_existing == null ? AppRoutes.invoices : '${AppRoutes.invoice}/${_existing!.id}'),
            ),
            actions: [
              BusyButton(busy: _busy, outlined: true, onPressed: () => _save(), child: Text(l.invoiceSaveDraft)),
              BusyButton(busy: _busy, onPressed: () => _save(issue: true), child: Text(l.invoiceSaveAndIssue)),
            ],
          ),
          if (_projects.isEmpty)
            AlertBanner(title: l.invoiceNeedsProject, message: '', actionLabel: l.addNewProject, onAction: () => context.go(AppRoutes.projects)),
          PanelCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                FormRow(
                  children: [
                    AppDropdown<Int64>(
                      label: l.invoiceProject,
                      required: true,
                      value: _projectId,
                      hint: l.invoiceProject,
                      items: [
                        for (final p in _projects)
                          DropdownMenuItem(
                            value: p.id,
                            child: Text(p.name, overflow: TextOverflow.ellipsis),
                          ),
                      ],
                      onChanged: (v) => setState(() => _projectId = v),
                    ),
                    AppTextField(label: l.invoiceCustomerReference, controller: _reference),
                  ],
                ),
                FormRow(
                  children: [
                    AppDateField(label: l.invoiceDate, value: _issueDate, required: true, onChanged: (v) => setState(() => _issueDate = v)),
                    AppDateField(label: l.invoiceDueDate, value: _dueDate, required: true, onChanged: (v) => setState(() => _dueDate = v)),
                  ],
                ),
              ],
            ),
          ),
          PanelCard(
            title: l.invoiceItems,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (wide)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: theme.dividerColor)),
                    ),
                    child: Row(
                      spacing: 12,
                      children: [
                        Expanded(flex: 5, child: Text(l.invoiceLineDescription, style: theme.textTheme.titleSmall)),
                        SizedBox(
                          width: 80,
                          child: Text(l.invoiceLineQuantity, style: theme.textTheme.titleSmall, textAlign: TextAlign.right),
                        ),
                        SizedBox(
                          width: 130,
                          child: Text(l.invoiceLineUnitPrice, style: theme.textTheme.titleSmall, textAlign: TextAlign.right),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(l.invoiceLineVat, style: theme.textTheme.titleSmall, textAlign: TextAlign.right),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(l.invoiceLineTotal, style: theme.textTheme.titleSmall, textAlign: TextAlign.right),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                for (var i = 0; i < _lines.length; i++) _lineRow(context, l, i, wide, cur),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () => setState(() => _lines.add(_Line(vat: _defaultVat))),
                      icon: const Icon(Icons.add, size: 18),
                      label: Text(l.invoiceAddLine),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLow,
                    border: Border(top: BorderSide(color: theme.dividerColor)),
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 320,
                        child: Column(
                          spacing: 8,
                          children: [
                            _totalRow(theme, l.invoiceSubtotal, formatMoneyInt(subtotal, currency: cur)),
                            _totalRow(theme, l.invoiceVat, formatMoneyInt(vat, currency: cur)),
                            const Divider(),
                            _totalRow(theme, l.invoiceTotal, formatMoneyInt(subtotal + vat, currency: cur), bold: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PanelCard(
            child: AppTextField(label: l.invoiceNotes, controller: _notes, maxLines: 3, hint: l.invoiceNotesHint),
          ),
        ],
      ),
    );
  }

  Widget _totalRow(ThemeData theme, String label, String value, {bool bold = false}) {
    final style = bold ? theme.textTheme.titleMedium : theme.textTheme.bodyMedium;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }

  Widget _lineRow(BuildContext context, AppLocalizations l, int i, bool wide, String cur) {
    final theme = Theme.of(context);
    final line = _lines[i];
    final desc = TextFormField(
      controller: line.description,
      decoration: InputDecoration(hintText: l.invoiceLineDescription),
      validator: (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null,
      onChanged: (_) => setState(() {}),
    );
    final qty = TextFormField(
      controller: line.quantity,
      textAlign: TextAlign.right,
      decoration: InputDecoration(hintText: l.invoiceLineQuantity),
      validator: (v) => (line.qty <= 0) ? l.invalidNumber : null,
      onChanged: (_) => setState(() {}),
    );
    final price = TextFormField(
      controller: line.unitPrice,
      textAlign: TextAlign.right,
      decoration: InputDecoration(hintText: '0.00', prefixText: currencySymbol(cur)),
      validator: (v) => parseCents(v ?? '') == null ? l.invalidNumber : null,
      onChanged: (_) => setState(() {}),
    );
    final vat = TextFormField(
      controller: line.vatRate,
      textAlign: TextAlign.right,
      decoration: const InputDecoration(suffixText: '%'),
      validator: (v) => (double.tryParse((v ?? '').replaceAll(',', '.')) == null) ? l.invalidNumber : null,
      onChanged: (_) => setState(() {}),
    );
    final total = Text(
      formatMoneyInt(line.netCents, currency: cur),
      textAlign: TextAlign.right,
      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
    );
    final remove = IconButton(
      icon: Icon(Icons.close, size: 18, color: theme.hintColor),
      onPressed: _lines.length > 1
          ? () => setState(() {
              _lines.removeAt(i).dispose();
            })
          : null,
    );
    final border = BoxDecoration(
      border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
    );
    if (wide) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: border,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Expanded(flex: 5, child: desc),
            SizedBox(width: 80, child: qty),
            SizedBox(width: 130, child: price),
            SizedBox(width: 80, child: vat),
            SizedBox(
              width: 120,
              child: Padding(padding: const EdgeInsets.only(top: 12), child: total),
            ),
            SizedBox(width: 40, child: remove),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: border,
      child: Column(
        spacing: 10,
        children: [
          Row(
            children: [
              Expanded(child: desc),
              remove,
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Expanded(child: qty),
              Expanded(flex: 2, child: price),
              Expanded(child: vat),
            ],
          ),
          Align(alignment: Alignment.centerRight, child: total),
        ],
      ),
    );
  }
}
