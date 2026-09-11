import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../services/format.dart';
import '../../state.dart';

/// Shared company create/edit form. Calls [onSaved] with the server's copy.
class CompanyForm extends StatefulWidget {
  final Company? company;
  final ValueChanged<Company> onSaved;
  final String submitLabel;
  final bool showInvoicing;

  const CompanyForm({super.key, this.company, required this.onSaved, required this.submitLabel, this.showInvoicing = true});

  @override
  State<CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final _formKey = GlobalKey<FormState>();
  late final _c = {
    'name': TextEditingController(text: widget.company?.name ?? ''),
    'reg': TextEditingController(text: widget.company?.regNumber ?? ''),
    'vat': TextEditingController(text: widget.company?.vatNumber ?? ''),
    'address': TextEditingController(text: widget.company?.address ?? ''),
    'email': TextEditingController(text: widget.company?.email ?? ''),
    'phone': TextEditingController(text: widget.company?.phone ?? ''),
    'iban': TextEditingController(text: widget.company?.iban ?? ''),
    'bank': TextEditingController(text: widget.company?.bankName ?? ''),
    'prefix': TextEditingController(text: widget.company?.invoicePrefix ?? 'INV-'),
    'vatRate': TextEditingController(text: trimDecimal(widget.company?.defaultVatRate ?? '24')),
    'dueDays': TextEditingController(text: '${widget.company?.defaultDueDays ?? 14}'),
  };
  late String _currency = widget.company?.currency ?? 'EUR';
  bool _busy = false;

  static const _currencies = ['EUR', 'USD', 'GBP', 'SEK', 'NOK', 'DKK', 'PLN', 'CHF'];

  @override
  void dispose() {
    for (final c in _c.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    final company = Company(
      id: widget.company?.id,
      name: _c['name']!.text.trim(),
      regNumber: _c['reg']!.text.trim(),
      vatNumber: _c['vat']!.text.trim(),
      address: _c['address']!.text.trim(),
      email: _c['email']!.text.trim(),
      phone: _c['phone']!.text.trim(),
      iban: _c['iban']!.text.trim(),
      bankName: _c['bank']!.text.trim(),
      currency: _currency,
      invoicePrefix: _c['prefix']!.text.trim(),
      defaultVatRate: _c['vatRate']!.text.trim().replaceAll(',', '.'),
      defaultDueDays: int.tryParse(_c['dueDays']!.text.trim()) ?? 14,
    );
    try {
      final saved = widget.company == null ? await state.server.createCompany(company) : await state.server.updateCompany(company);
      widget.onSaved(saved);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    String? req(String? v) => (v == null || v.trim().isEmpty) ? l.requiredField : null;
    String? num(String? v) => double.tryParse((v ?? '').replaceAll(',', '.')) == null ? l.invalidNumber : null;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20,
        children: [
          SectionTitle(l.companySectionDetails),
          AppTextField(label: l.companyName, controller: _c['name'], required: true, validator: req, autofocus: widget.company == null),
          FormRow(
            children: [
              AppTextField(label: l.companyRegNumber, controller: _c['reg']),
              AppTextField(label: l.companyVatNumber, controller: _c['vat']),
            ],
          ),
          AppTextField(label: l.companyAddress, controller: _c['address'], maxLines: 2),
          FormRow(
            children: [
              AppTextField(label: l.companyEmail, controller: _c['email'], keyboardType: TextInputType.emailAddress),
              AppTextField(label: l.companyPhone, controller: _c['phone']),
            ],
          ),
          if (widget.showInvoicing) ...[
            const Divider(),
            SectionTitle(l.companySectionInvoicing),
            FormRow(
              children: [
                AppDropdown<String>(
                  label: l.companyCurrency,
                  value: _currency,
                  items: [for (final c in _currencies) DropdownMenuItem(value: c, child: Text(c))],
                  onChanged: (v) => setState(() => _currency = v ?? 'EUR'),
                ),
                AppTextField(label: l.companyInvoicePrefix, controller: _c['prefix']),
              ],
            ),
            FormRow(
              children: [
                AppTextField(label: l.companyDefaultVat, controller: _c['vatRate'], validator: num),
                AppTextField(
                  label: l.companyDefaultDueDays,
                  controller: _c['dueDays'],
                  keyboardType: TextInputType.number,
                  validator: (v) => int.tryParse(v ?? '') == null ? l.invalidNumber : null,
                ),
              ],
            ),
            const Divider(),
            SectionTitle(l.companySectionPayment),
            FormRow(
              children: [
                AppTextField(label: l.companyBankName, controller: _c['bank']),
                AppTextField(label: l.companyIban, controller: _c['iban']),
              ],
            ),
          ],
          Align(
            alignment: Alignment.centerRight,
            child: BusyButton(busy: _busy, onPressed: _save, child: Text(widget.submitLabel)),
          ),
        ],
      ),
    );
  }
}
