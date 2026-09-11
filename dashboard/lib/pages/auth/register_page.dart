import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../state.dart';
import 'auth_layout.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    for (final c in [_name, _email, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _register() async {
    final l = AppLocalizations.of(context)!;
    if (!_formKey.currentState!.validate()) return;
    final state = Inherited.read(context);
    setState(() => _busy = true);
    try {
      final res = await state.server.register(RegisterRequest(name: _name.text.trim(), email: _email.text.trim(), password: _password.text));
      await state.signIn(res);
      if (mounted) context.go('${AppRoutes.settingsCompanies}?new=1');
    } catch (e) {
      AppLogger.error(errorMessage(e, fallback: l.registrationFailed), error: e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return AuthLayout(
      title: l.registerTitle,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 4,
        children: [
          Text(l.alreadyHaveAccount, style: theme.textTheme.bodySmall),
          TextButton(onPressed: () => context.go(AppRoutes.login), child: Text(l.signIn)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            AppTextField(label: l.yourName, controller: _name, autofocus: true, validator: (v) => (v == null || v.trim().isEmpty) ? l.requiredField : null),
            AppTextField(
              label: l.email,
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => (v == null || !v.contains('@')) ? l.invalidEmail : null,
            ),
            AppTextField(label: l.password, controller: _password, obscure: true, validator: (v) => (v == null || v.length < 8) ? l.passwordTooShort : null),
            AppTextField(
              label: l.confirmPassword,
              controller: _confirm,
              obscure: true,
              onSubmitted: (_) => _register(),
              validator: (v) => v != _password.text ? l.passwordsDoNotMatch : null,
            ),
            BusyButton(busy: _busy, onPressed: _register, child: Text(l.createAccount)),
          ],
        ),
      ),
    );
  }
}
