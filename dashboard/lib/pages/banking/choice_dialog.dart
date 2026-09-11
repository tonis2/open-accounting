import 'package:flutter/material.dart';

import '../../components/index.dart';
import '../../l10n/app_localizations.dart';
import '../../state.dart';

/// Lets the user pick one of the options a bank provider needs before it can connect,
/// e.g. which Wise profile to use. Returns the chosen value or null.
class ChoiceDialog extends StatefulWidget {
  const ChoiceDialog({super.key, required this.choice});

  final ChoiceRequired choice;

  static Future<String?> show(BuildContext context, ChoiceRequired choice) => showDialog<String>(
    context: context,
    builder: (_) => ChoiceDialog(choice: choice),
  );

  @override
  State<ChoiceDialog> createState() => _ChoiceDialogState();
}

class _ChoiceDialogState extends State<ChoiceDialog> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return DialogShell(
      title: l.selectOne(widget.choice.label),
      width: 460,
      actions: [
        OutlinedButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
        ElevatedButton(onPressed: _value == null ? null : () => Navigator.pop(context, _value), child: Text(l.next)),
      ],
      body: RadioGroup<String>(
        groupValue: _value,
        onChanged: (v) => setState(() => _value = v),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final o in widget.choice.options)
              RadioListTile<String>(
                value: o.value,
                title: Text(o.label.isEmpty ? o.value : o.label, style: theme.textTheme.bodyMedium),
                subtitle: o.label.isEmpty ? null : Text(o.value, style: theme.textTheme.bodySmall),
                contentPadding: EdgeInsets.zero,
              ),
          ],
        ),
      ),
    );
  }
}
