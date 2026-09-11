import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../state.dart';
import 'choice_dialog.dart';
import 'key_file_field.dart';

/// Edits a connection's name and provider settings. Secret fields start empty and are only
/// sent when filled in, so existing tokens/keys are kept.
class EditConnectionDialog extends StatefulWidget {
  final BankConnection connection;
  final BankProvider provider;

  const EditConnectionDialog({super.key, required this.connection, required this.provider});

  static Future<BankConnection?> show(BuildContext context, {required BankConnection connection, required BankProvider provider}) {
    return showDialog<BankConnection>(
      context: context,
      builder: (_) => EditConnectionDialog(connection: connection, provider: provider),
    );
  }

  @override
  State<EditConnectionDialog> createState() => _EditConnectionDialogState();
}

class _EditConnectionDialogState extends State<EditConnectionDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.connection.name);
  final Map<String, TextEditingController> _text = {};
  final Map<String, String> _values = {};
  bool _busy = false;

  bool _isSecret(ConfigField f) => f.kind == FieldKind.FIELD_KIND_SECRET || f.kind == FieldKind.FIELD_KIND_MULTILINE;

  @override
  void initState() {
    super.initState();
    for (final f in widget.provider.configFields) {
      final current = widget.connection.config[f.key] ?? '';
      switch (f.kind) {
        case FieldKind.FIELD_KIND_SELECT:
        case FieldKind.FIELD_KIND_BOOL:
          _values[f.key] = current.isEmpty ? f.defaultValue : current;
        default:
          _text[f.key] = TextEditingController(text: _isSecret(f) ? '' : current);
      }
    }
  }

  @override
  void dispose() {
    _name.dispose();
    for (final c in _text.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    final config = Map<String, String>.from(_values);
    for (final e in _text.entries) {
      config[e.key] = e.value.text.trim();
    }
    try {
      final res = await state.server.updateBankConnection(
        UpdateBankConnectionRequest(companyId: widget.connection.companyId, id: widget.connection.id, name: _name.text.trim(), config: config.entries),
      );
      if (res.hasChoice()) {
        // The provider needs one more answer (e.g. which Wise profile) — ask, fill the field, retry.
        final picked = mounted ? await ChoiceDialog.show(context, res.choice) : null;
        if (!mounted) return;
        setState(() => _busy = false);
        if (picked == null) return;
        _text[res.choice.key]?.text = picked;
        await _save();
        return;
      }
      AppLogger.info(l.connectionUpdated);
      if (mounted) Navigator.pop(context, res.connection);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final fields = <Widget>[AppTextField(label: l.connectBankConnectionName, controller: _name)];
    for (final f in widget.provider.configFields) {
      if (f.key == 'institution_id') continue; // changing the bank means reconnecting
      switch (f.kind) {
        case FieldKind.FIELD_KIND_SELECT:
          fields.add(
            AppDropdown<String>(
              label: f.label,
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
          final secret = _isSecret(f);
          if (f.kind == FieldKind.FIELD_KIND_MULTILINE) {
            fields.add(KeyFileField(label: f.label, controller: _text[f.key]!, hint: l.keepCurrentKeyHint, helper: f.hint.isEmpty ? null : f.hint));
            break;
          }
          fields.add(
            AppTextField(
              label: f.label,
              controller: _text[f.key],
              hint: secret ? l.keepCurrentValueHint : null,
              helper: f.hint.isEmpty ? null : f.hint,
              obscure: f.kind == FieldKind.FIELD_KIND_SECRET,
              maxLines: f.kind == FieldKind.FIELD_KIND_MULTILINE ? 6 : 1,
              validator: (f.required && !secret) ? (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null : null,
            ),
          );
      }
    }
    if (widget.provider.id == 'wise') {
      fields.add(Text(l.wiseKeyHelp, style: theme.textTheme.bodySmall));
    }
    return DialogShell(
      title: l.editConnection,
      width: 600,
      actions: [
        OutlinedButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
        BusyButton(busy: _busy, onPressed: _save, child: Text(l.saveChanges)),
      ],
      body: Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 16, children: fields),
      ),
    );
  }
}
