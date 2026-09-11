import 'package:flutter/material.dart';

import '../theme.dart';

/// Orange attention strip with a title, message and optional link action.
class AlertBanner extends StatelessWidget {
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final BadgeKind kind;

  const AlertBanner({super.key, required this.title, required this.message, this.actionLabel, this.onAction, this.kind = BadgeKind.warning});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (bg, accent) = switch (kind) {
      BadgeKind.warning => (AppColors.warningBg, AppColors.warning),
      BadgeKind.danger => (AppColors.dangerBg, AppColors.danger),
      BadgeKind.info => (AppColors.infoBg, AppColors.info),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: accent, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Icon(Icons.error_outline, color: accent, size: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(title, style: theme.textTheme.titleMedium),
                Text.rich(
                  TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      TextSpan(text: message),
                      if (actionLabel != null) ...[
                        const TextSpan(text: ' '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: InkWell(
                            onTap: onAction,
                            child: Text(
                              actionLabel!,
                              style: theme.textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum BadgeKind { warning, danger, info }
