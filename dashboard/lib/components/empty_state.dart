import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;

  const EmptyState({super.key, required this.icon, required this.title, required this.subtitle, this.buttonLabel, this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(shape: BoxShape.circle, color: theme.colorScheme.surfaceContainerHigh),
              child: Icon(icon, size: 30, color: theme.hintColor),
            ),
            Text(title, textAlign: TextAlign.center, style: theme.textTheme.titleMedium),
            Text(subtitle, textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
            if (buttonLabel != null && onButtonPressed != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ElevatedButton(onPressed: onButtonPressed, child: Text(buttonLabel!)),
              ),
          ],
        ),
      ),
    );
  }
}
