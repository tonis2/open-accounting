import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../logging/logging.dart';
import '../../services/errors.dart';
import '../../state.dart';

/// Landing page after the user authorises access at their bank (`?ref=<connection reference>`).
class BankCallbackPage extends StatefulWidget {
  final String reference;
  final Map<String, String> params;
  const BankCallbackPage({super.key, required this.reference, required this.params});

  @override
  State<BankCallbackPage> createState() => _BankCallbackPageState();
}

class _BankCallbackPageState extends State<BankCallbackPage> {
  bool _done = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _complete());
  }

  Future<void> _complete() async {
    final state = Inherited.read(context);
    final l = AppLocalizations.of(context)!;
    try {
      await state.server.completeBankConnection(CompleteBankConnectionRequest(reference: widget.reference, params: widget.params.entries));
      if (mounted) setState(() => _done = true);
      AppLogger.info(l.connectBankConnected);
    } catch (e) {
      if (mounted) setState(() => _error = errorMessage(e, fallback: l.connectBankCallbackFailed));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: PanelCard(
          title: l.connectBankCallbackTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              if (_error != null) ...[
                Row(
                  spacing: 10,
                  children: [
                    Icon(Icons.error_outline, color: theme.colorScheme.error),
                    Expanded(child: Text(_error!, style: theme.textTheme.bodyMedium)),
                  ],
                ),
                OutlinedButton(onPressed: () => context.go(AppRoutes.bankConnect), child: Text(l.connectBankTitle)),
              ] else if (_done) ...[
                Row(
                  spacing: 10,
                  children: [
                    const Icon(Icons.check_circle, color: Color(0xFF3A8F3A)),
                    Expanded(child: Text(l.connectBankCallbackDone, style: theme.textTheme.bodyMedium)),
                  ],
                ),
                ElevatedButton(onPressed: () => context.go(AppRoutes.banking), child: Text(l.backToBanking)),
              ] else
                Row(
                  spacing: 12,
                  children: [
                    const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                    Text(l.connectBankCallbackBody, style: theme.textTheme.bodyMedium),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
