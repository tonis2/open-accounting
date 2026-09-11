import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../services/passkey_service.dart';
import '../../state.dart';
import 'auth_layout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;
  bool _passkeyBusy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    try {
      final res = await state.server.login(LoginRequest(email: _email.text.trim(), password: _password.text));
      await state.signIn(res);
      if (mounted) context.go(AppRoutes.overview);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.signInFailed), error: e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signInWithPasskey() async {
    final l = AppLocalizations.of(context)!;
    final state = Inherited.read(context);
    if (!await passkeyService.isSupported()) {
      AppLogger.warning(l.passkeyNotSupported);
      return;
    }
    setState(() => _passkeyBusy = true);
    try {
      final options = await state.server.beginPasskeyLogin(BeginPasskeyLoginRequest(email: _email.text.trim()));
      final credential = await passkeyService.authenticate(options.optionsJson);
      final res = await state.server.finishPasskeyLogin(FinishPasskeyRequest(sessionId: options.sessionId, credentialJson: credential));
      await state.signIn(res);
      if (mounted) context.go(AppRoutes.overview);
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.passkeyFailed), error: e);
    } finally {
      if (mounted) setState(() => _passkeyBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AuthLayout(
      title: l.signInTitle,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Text(l.noAccountYet, style: theme.textTheme.bodySmall),
          TextButton(onPressed: () => context.go(AppRoutes.register), child: Text(l.createAccount)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              AppTextField(
                label: l.email,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.username, AutofillHints.email],
                autofocus: true,
                validator: (v) => (v == null || !v.contains('@')) ? l.invalidEmail : null,
              ),
              AppTextField(
                label: l.password,
                controller: _password,
                obscure: true,
                autofillHints: const [AutofillHints.password],
                onSubmitted: (_) => _signIn(),
                validator: (v) => (v == null || v.isEmpty) ? l.requiredField : null,
              ),
              BusyButton(busy: _busy, onPressed: _signIn, child: Text(l.signIn)),
              Row(
                spacing: 8,
                children: [
                  const Expanded(child: Divider()),
                  Text(l.orDivider, style: theme.textTheme.bodySmall),
                  const Expanded(child: Divider()),
                ],
              ),
              BusyButton(
                busy: _passkeyBusy,
                outlined: true,
                onPressed: _signInWithPasskey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [const Icon(Icons.fingerprint, size: 20), Text(l.signInWithPasskey)],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(onPressed: () => context.go(AppRoutes.recover), child: Text(l.forgotPassword)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
