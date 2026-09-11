import 'package:flutter/material.dart';

enum StatTone { neutral, positive, negative, warning }

/// Label above a big value, e.g. "Incoming / £59,807".
class StatTile extends StatelessWidget {
  final String label;
  final String value;
  final StatTone tone;
  final String? caption;

  const StatTile({super.key, required this.label, required this.value, this.tone = StatTone.neutral, this.caption});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (tone) {
      StatTone.positive => const Color(0xFF3A8F3A),
      StatTone.negative => theme.colorScheme.error,
      StatTone.warning => const Color(0xFFE0851A),
      StatTone.neutral => theme.colorScheme.onSurface,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(label, style: theme.textTheme.bodySmall),
        Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontSize: 24, color: color)),
        if (caption != null) Text(caption!, style: theme.textTheme.labelSmall),
      ],
    );
  }
}

/// Vertical list of StatTiles separated by dividers — the right-hand column of chart panels.
class StatColumn extends StatelessWidget {
  final List<Widget> tiles;
  const StatColumn({super.key, required this.tiles});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < tiles.length; i++) ...[
          Padding(padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20), child: tiles[i]),
          if (i < tiles.length - 1) Divider(color: theme.dividerColor),
        ],
      ],
    );
  }
}
