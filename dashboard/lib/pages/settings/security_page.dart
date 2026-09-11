import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../services/format.dart';
import '../../services/passkey_service.dart';
import '../../state.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final _pwKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  List<Passkey> _passkeys = [];
  bool _busy = false;
  bool _passkeyBusy = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    for (final c in [_current, _next, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final state = Inherited.read(context);
    try {
      final res = await state.server.listPasskeys(Empty());
      if (mounted) setState(() => _passkeys = res.items);
    } catch (e) {
      AppLogger.debug('passkeys load failed', error: e);
    }
  }

  Future<void> _changePassword() async {
    final l = AppLocalizations.of(context)!;
    if (!_pwKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    try {
      await state.server.changePassword(ChangePasswordRequest(currentPassword: _current.text, newPassword: _next.text));
      AppLogger.info(l.passwordChanged);
      for (final c in [_current, _next, _confirm]) {
        c.clear();
      }
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _addPasskey() async {
    final l = AppLocalizations.of(context)!;
    final state = Inherited.read(context);
    if (!await passkeyService.isSupported()) {
      AppLogger.warning(l.passkeyNotSupported);
      return;
    }
    if (!mounted) return;
    final name = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => DialogShell(
        title: l.addPasskey,
        width: 420,
        body: AppTextField(label: l.passkeyName, controller: name, hint: l.passkeyNameHint, autofocus: true, onSubmitted: (_) => Navigator.pop(ctx, true)),
        actions: [
          OutlinedButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l.addPasskey)),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _passkeyBusy = true);
    try {
      final options = await state.server.beginPasskeyRegistration(Empty());
      final credential = await passkeyService.register(options.optionsJson);
      await state.server.finishPasskeyRegistration(FinishPasskeyRequest(sessionId: options.sessionId, credentialJson: credential, name: name.text.trim()));
      AppLogger.info(l.passkeyAdded);
      await _load();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.passkeyFailed), error: e);
    } finally {
      if (mounted) setState(() => _passkeyBusy = false);
    }
  }

  Future<void> _removePasskey(Passkey pk) async {
    final l = AppLocalizations.of(context)!;
    if (!await confirmDialog(
      context,
      title: l.remove,
      message: l.removePasskeyConfirm(pk.name),
      confirmLabel: l.remove,
      cancelLabel: l.cancel,
      destructive: true,
    )) {
      return;
    }
    if (!mounted) return;
    final state = Inherited.read(context);
    try {
      await state.server.deletePasskey(IdRequest(id: pk.id));
      AppLogger.info(l.passkeyRemoved);
      await _load();
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = Inherited.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 20,
      children: [
        PageHeader(title: l.securityTitle, subtitle: l.signedInAs(state.user?.email ?? '')),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 20,
            children: [
              PanelCard(
                title: l.securityPasswordSection,
                child: Form(
                  key: _pwKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 16,
                    children: [
                      Text(l.securityPasswordBody, style: theme.textTheme.bodySmall),
                      if (state.user?.hasPassword ?? false) AppTextField(label: l.currentPassword, controller: _current, obscure: true),
                      FormRow(
                        children: [
                          AppTextField(
                            label: l.newPassword,
                            controller: _next,
                            obscure: true,
                            validator: (v) => (v == null || v.length < 8) ? l.passwordTooShort : null,
                          ),
                          AppTextField(
                            label: l.confirmPassword,
                            controller: _confirm,
                            obscure: true,
                            validator: (v) => v != _next.text ? l.passwordsDoNotMatch : null,
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: BusyButton(busy: _busy, onPressed: _changePassword, child: Text(l.changePassword)),
                      ),
                    ],
                  ),
                ),
              ),
              PanelCard(
                title: l.securityPasskeysSection,
                trailing: BusyButton(
                  busy: _passkeyBusy,
                  onPressed: _addPasskey,
                  child: Row(mainAxisSize: MainAxisSize.min, spacing: 6, children: [const Icon(Icons.fingerprint, size: 18), Text(l.addPasskey)]),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12,
                  children: [
                    Text(l.securityPasskeysBody, style: theme.textTheme.bodySmall),
                    if (_passkeys.isEmpty)
                      Text(l.noPasskeys, style: theme.textTheme.bodyMedium)
                    else
                      for (final pk in _passkeys)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: theme.colorScheme.outlineVariant)),
                          ),
                          child: Row(
                            spacing: 12,
                            children: [
                              Icon(Icons.key_outlined, color: theme.colorScheme.primary),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(pk.name, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                                    Text(
                                      '${l.passkeyCreated(formatTimestamp(pk.createdAt))} · ${pk.hasLastUsedAt() ? l.passkeyLastUsed(formatTimestamp(pk.lastUsedAt)) : l.passkeyNeverUsed}',
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(icon: const Icon(Icons.delete_outline, size: 18), onPressed: () => _removePasskey(pk)),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
