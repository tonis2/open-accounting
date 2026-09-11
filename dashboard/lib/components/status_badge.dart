import 'package:flutter/material.dart';

import '../theme.dart';

enum BadgeTone { neutral, success, warning, danger, info }

/// Small coloured pill for statuses.
class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeTone tone;

  const StatusBadge({super.key, required this.label, this.tone = BadgeTone.neutral});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (bg, fg) = switch (tone) {
      BadgeTone.success => (AppColors.successBg, AppColors.success),
      BadgeTone.warning => (AppColors.warningBg, AppColors.warning),
      BadgeTone.danger => (AppColors.dangerBg, AppColors.danger),
      BadgeTone.info => (AppColors.infoBg, AppColors.info),
      BadgeTone.neutral => (theme.colorScheme.surfaceContainerHigh, theme.colorScheme.onSurfaceVariant),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// Inline coloured status text like "Paid on – 28 Aug 26" or "Open – due in 19 days".
class StatusText extends StatelessWidget {
  final String primary;
  final String? secondary;
  final BadgeTone tone;

  const StatusText({super.key, required this.primary, this.secondary, this.tone = BadgeTone.neutral});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (tone) {
      BadgeTone.success => AppColors.success,
      BadgeTone.warning => AppColors.warning,
      BadgeTone.danger => AppColors.danger,
      BadgeTone.info => AppColors.info,
      BadgeTone.neutral => theme.colorScheme.onSurfaceVariant,
    };
    return Text.rich(
      TextSpan(
        style: theme.textTheme.bodyMedium?.copyWith(color: color),
        children: [
          TextSpan(
            text: primary,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          if (secondary != null) TextSpan(text: ' – $secondary'),
        ],
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Numeric counter pill, e.g. the orange "216" next to "For approval".
class CountBadge extends StatelessWidget {
  final int count;
  final BadgeTone tone;
  const CountBadge({super.key, required this.count, this.tone = BadgeTone.warning});

  @override
  Widget build(BuildContext context) {
    if (count == 0) return const SizedBox.shrink();
    final bg = switch (tone) {
      BadgeTone.warning => AppColors.warning,
      BadgeTone.danger => AppColors.danger,
      BadgeTone.success => AppColors.success,
      BadgeTone.info => AppColors.info,
      BadgeTone.neutral => Theme.of(context).colorScheme.onSurfaceVariant,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(
        '$count',
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}
