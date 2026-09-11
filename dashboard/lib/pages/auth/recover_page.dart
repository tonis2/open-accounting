import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../state.dart';
import 'auth_layout.dart';

/// Without a token: request a recovery email. With ?token=: set a new password.
class RecoverPage extends StatefulWidget {
  final String? token;
  const RecoverPage({super.key, this.token});

  @override
  State<RecoverPage> createState() => _RecoverPageState();
}

class _RecoverPageState extends State<RecoverPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;
  bool _sent = false;
  bool? _tokenValid;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) WidgetsBinding.instance.addPostFrameCallback((_) => _validate());
  }

  @override
  void dispose() {
    for (final c in [_email, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _validate() async {
    final state = Inherited.read(context);
    try {
      final res = await state.server.validateRecoveryToken(RecoveryTokenRequest(token: widget.token!));
      if (mounted) setState(() => _tokenValid = res.valid);
    } catch (e) {
      if (mounted) setState(() => _tokenValid = false);
    }
  }

  Future<void> _request() async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    try {
      await state.server.requestRecovery(RequestRecoveryRequest(email: _email.text.trim()));
      setState(() => _sent = true);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _reset() async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    try {
      final res = await state.server.recoverAccount(RecoverAccountRequest(token: widget.token!, newPassword: _password.text));
      await state.signIn(res);
      if (mounted) context.go(AppRoutes.overview);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.somethingWentWrong), error: e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final footer = TextButton(onPressed: () => context.go(AppRoutes.login), child: Text(l.signIn));

    if (widget.token != null) {
      Widget body;
      if (_tokenValid == null) {
        body = const Center(child: CircularProgressIndicator());
      } else if (_tokenValid == false) {
        body = Text(l.recoveryInvalidLink, style: theme.textTheme.bodyMedium);
      } else {
        body = Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              AppTextField(
                label: l.newPassword,
                controller: _password,
                obscure: true,
                autofocus: true,
                validator: (v) => (v == null || v.length < 8) ? l.passwordTooShort : null,
              ),
              AppTextField(
                label: l.confirmPassword,
                controller: _confirm,
                obscure: true,
                onSubmitted: (_) => _reset(),
                validator: (v) => v != _password.text ? l.passwordsDoNotMatch : null,
              ),
              BusyButton(busy: _busy, onPressed: _reset, child: Text(l.setNewPassword)),
            ],
          ),
        );
      }
      return AuthLayout(title: l.recoveryTitle, footer: footer, child: body);
    }

    return AuthLayout(
      title: l.recoveryTitle,
      subtitle: l.recoverySubtitle,
      footer: footer,
      child: _sent
          ? Text(l.recoveryLinkSent, style: theme.textTheme.bodyMedium)
          : Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  AppTextField(
                    label: l.email,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    onSubmitted: (_) => _request(),
                    validator: (v) => (v == null || !v.contains('@')) ? l.invalidEmail : null,
                  ),
                  BusyButton(busy: _busy, onPressed: _request, child: Text(l.sendRecoveryLink)),
                ],
              ),
            ),
    );
  }
}
