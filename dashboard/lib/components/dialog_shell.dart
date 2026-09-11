import 'package:flutter/material.dart';

/// Standard dialog frame: title bar, scrollable body, right-aligned actions.
class DialogShell extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final double width;

  const DialogShell({super.key, required this.title, required this.body, this.actions, this.width = 520});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = BorderSide(color: theme.dividerColor);
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: width.clamp(0.0, size.width - 32),
        constraints: BoxConstraints(maxHeight: size.height * 0.9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(border: Border(bottom: border)),
              child: Row(
                children: [
                  Expanded(child: Text(title, style: theme.dialogTheme.titleTextStyle)),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: body),
            ),
            if (actions != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(border: Border(top: border)),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, spacing: 12, children: actions!),
              ),
          ],
        ),
      ),
    );
  }
}

/// Yes/no confirmation. Resolves to true when confirmed.
Future<bool> confirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  bool destructive = false,
}) async {
  final theme = Theme.of(context);
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => DialogShell(
      title: title,
      width: 440,
      body: Text(message, style: theme.textTheme.bodyMedium),
      actions: [
        OutlinedButton(onPressed: () => Navigator.pop(ctx, false), child: Text(cancelLabel)),
        if (destructive)
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(confirmLabel),
          )
        else
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: Text(confirmLabel)),
      ],
    ),
  );
  return result ?? false;
}
