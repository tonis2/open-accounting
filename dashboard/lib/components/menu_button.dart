import 'package:flutter/material.dart';

enum MenuButtonStyle { primary, outlined }

/// A button that opens a popup menu — styled like ElevatedButton/OutlinedButton but without the
/// disabled look a wrapped button would get.
class MenuButton<T> extends StatelessWidget {
  final String label;
  final List<PopupMenuEntry<T>> Function(BuildContext) itemBuilder;
  final ValueChanged<T> onSelected;
  final MenuButtonStyle style;
  final bool compact;

  const MenuButton({
    super.key,
    required this.label,
    required this.itemBuilder,
    required this.onSelected,
    this.style = MenuButtonStyle.primary,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = style == MenuButtonStyle.primary;
    final bg = primary ? theme.colorScheme.secondary : theme.colorScheme.surface;
    final fg = primary ? theme.colorScheme.onSecondary : theme.colorScheme.primary;
    return PopupMenuButton<T>(
      tooltip: '',
      offset: Offset(0, compact ? 36 : 44),
      onSelected: onSelected,
      itemBuilder: itemBuilder,
      child: Container(
        padding: compact ? const EdgeInsets.fromLTRB(10, 6, 6, 6) : const EdgeInsets.fromLTRB(16, 11, 10, 11),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          border: primary ? null : Border.all(color: theme.dividerColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            Text(label, style: theme.textTheme.labelLarge?.copyWith(color: fg)),
            Icon(Icons.keyboard_arrow_down, size: compact ? 16 : 18, color: fg),
          ],
        ),
      ),
    );
  }
}
