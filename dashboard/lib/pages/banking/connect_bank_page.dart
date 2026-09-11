import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../state.dart';
import 'key_file_field.dart';
import '../../theme.dart';
import 'connection_status.dart';

/// Two-step wizard: pick a provider, fill its fields (rendered from the server's ConfigFields),
/// then either connect directly or get redirected to the bank.
class ConnectBankPage extends StatefulWidget {
  const ConnectBankPage({super.key});

  @override
  State<ConnectBankPage> createState() => _ConnectBankPageState();
}

class _ConnectBankPageState extends State<ConnectBankPage> {
  List<BankProvider> _providers = [];
  BankProvider? _provider;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final Map<String, TextEditingController> _text = {};
  final Map<String, String> _values = {};
  List<Institution> _institutions = [];
  String _institutionSearch = '';
  bool _loading = true;
  bool _busy = false;
  bool _loadingInstitutions = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    _name.dispose();
    for (final c in _text.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      final res = await state.server.listBankProviders(Empty());
      if (mounted) setState(() => _providers = res.items);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _pick(BankProvider p) {
    _values.clear();
    for (final c in _text.values) {
      c.dispose();
    }
    _text.clear();
    for (final f in p.configFields) {
      _values[f.key] = f.defaultValue;
      if (f.kind == FieldKind.FIELD_KIND_TEXT || f.kind == FieldKind.FIELD_KIND_SECRET || f.kind == FieldKind.FIELD_KIND_MULTILINE) {
        _text[f.key] = TextEditingController(text: f.defaultValue);
      }
    }
    _name.text = p.name;
    _institutions = [];
    setState(() => _provider = p);
  }

  Map<String, String> _config() {
    final out = Map<String, String>.from(_values);
    for (final e in _text.entries) {
      out[e.key] = e.value.text;
    }
    return out;
  }

  Future<void> _loadInstitutions() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    setState(() => _loadingInstitutions = true);
    try {
      final res = await state.server.listInstitutions(
        ListInstitutionsRequest(companyId: state.companyId, provider: _provider!.id, country: _values['country'] ?? 'EE', config: _config().entries),
      );
      if (mounted) setState(() => _institutions = res.items);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _loadingInstitutions = false);
    }
  }

  Future<void> _connect() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      final res = await state.server.createBankConnection(
        CreateBankConnectionRequest(companyId: state.companyId, provider: _provider!.id, name: _name.text.trim(), config: _config().entries),
      );
      if (res.redirectUrl.isNotEmpty) {
        AppLogger.info(l.connectBankRedirecting);
        await openExternal(res.redirectUrl);
        return;
      }
      AppLogger.info(l.connectBankConnected);
      if (mounted) context.go(AppRoutes.banking);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.connectBankFailed), error: e);
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(
          title: l.connectBankTitle,
          leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go(AppRoutes.banking)),
        ),
        if (_loading)
          const PanelCard(child: SkeletonLines())
        else if (_providers.isEmpty)
          PanelCard(child: Text(l.connectBankNoProviders, style: theme.textTheme.bodyMedium))
        else
          PanelCard(
            title: l.connectBankChooseProvider,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final p in _providers)
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _pick(p),
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _provider?.id == p.id ? theme.colorScheme.primary : theme.dividerColor, width: _provider?.id == p.id ? 2 : 1),
                        color: _provider?.id == p.id ? AppColors.infoBg : theme.colorScheme.surface,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 6,
                        children: [
                          Row(
                            spacing: 8,
                            children: [
                              Icon(p.id == 'mock' ? Icons.science_outlined : Icons.account_balance, color: theme.colorScheme.primary),
                              Expanded(child: Text(p.name, style: theme.textTheme.titleMedium)),
                            ],
                          ),
                          Text(p.description, style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        if (_provider != null) _providerForm(context, l, _provider!),
      ],
    );
  }

  Widget _providerForm(BuildContext context, AppLocalizations l, BankProvider p) {
    final theme = Theme.of(context);
    final fields = <Widget>[AppTextField(label: l.connectBankConnectionName, controller: _name, hint: l.connectBankConnectionNameHint)];
    for (final f in p.configFields) {
      if (f.key == 'institution_id' && p.hasInstitutions) {
        fields.add(_institutionPicker(context, l, f));
        continue;
      }
      switch (f.kind) {
        case FieldKind.FIELD_KIND_SELECT:
          fields.add(
            AppDropdown<String>(
              label: f.label,
              required: f.required,
              value: _values[f.key],
              items: [for (final o in f.options) DropdownMenuItem(value: o, child: Text(o))],
              onChanged: (v) => setState(() => _values[f.key] = v ?? ''),
            ),
          );
        case FieldKind.FIELD_KIND_BOOL:
          fields.add(
            Row(
              spacing: 8,
              children: [
                Switch(value: _values[f.key] == 'true', onChanged: (v) => setState(() => _values[f.key] = v ? 'true' : 'false')),
                Text(f.label, style: theme.textTheme.bodyMedium),
              ],
            ),
          );
        default:
          if (f.kind == FieldKind.FIELD_KIND_MULTILINE) {
            fields.add(
              KeyFileField(
                label: f.label,
                controller: _text[f.key]!,
                helper: f.hint.isEmpty ? null : f.hint,
                validator: f.required ? (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null : null,
              ),
            );
            break;
          }
          fields.add(
            AppTextField(
              label: f.label,
              controller: _text[f.key],
              required: f.required,
              helper: f.hint.isEmpty ? null : f.hint,
              obscure: f.kind == FieldKind.FIELD_KIND_SECRET,
              maxLines: f.kind == FieldKind.FIELD_KIND_MULTILINE ? 6 : 1,
              validator: f.required ? (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null : null,
            ),
          );
      }
    }
    return PanelCard(
      title: p.name,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 12,
        children: [
          if (p.needsRedirect) Expanded(child: Text(l.connectBankRedirectHint, style: theme.textTheme.bodySmall)),
          OutlinedButton(onPressed: () => context.go(AppRoutes.banking), child: Text(l.cancel)),
          BusyButton(busy: _busy, onPressed: _connect, child: Text(p.needsRedirect ? l.connectBankContinue : l.connectBankConnect)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 16, children: fields),
        ),
      ),
    );
  }

  Widget _institutionPicker(BuildContext context, AppLocalizations l, ConfigField f) {
    final theme = Theme.of(context);
    final filtered = _institutions.where((i) => i.name.toLowerCase().contains(_institutionSearch.toLowerCase())).take(40).toList();
    final selected = _values['institution_id'] ?? '';
    return Labeled(
      label: l.connectBankChooseInstitution,
      required: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          Row(
            spacing: 8,
            children: [
              Expanded(
                child: AppSearchBar(hintText: l.connectBankSearchInstitution, onChanged: (v) => setState(() => _institutionSearch = v)),
              ),
              BusyButton(busy: _loadingInstitutions, outlined: true, onPressed: _loadInstitutions, child: Text(l.connectBankLoadInstitutions)),
            ],
          ),
          if (_institutions.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: 260),
              decoration: BoxDecoration(
                border: Border.all(color: theme.dividerColor),
                borderRadius: BorderRadius.circular(6),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final i in filtered)
                    ListTile(
                      dense: true,
                      selected: selected == i.id,
                      selectedTileColor: AppColors.infoBg,
                      leading: i.logoUrl.isNotEmpty
                          ? Image.network(i.logoUrl, width: 24, height: 24, errorBuilder: (_, _, _) => const Icon(Icons.account_balance, size: 20))
                          : const Icon(Icons.account_balance, size: 20),
                      title: Text(i.name),
                      subtitle: i.bic.isNotEmpty ? Text(i.bic) : null,
                      onTap: () => setState(() => _values['institution_id'] = i.id),
                    ),
                ],
              ),
            ),
          // Fallback: allow typing the id directly (e.g. the sandbox institution).
          TextFormField(
            initialValue: selected,
            key: ValueKey(selected),
            decoration: InputDecoration(hintText: f.hint),
            onChanged: (v) => _values['institution_id'] = v,
            validator: (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null,
          ),
        ],
      ),
    );
  }
}
