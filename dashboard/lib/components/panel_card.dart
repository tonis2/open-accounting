import 'package:flutter/material.dart';

import '../theme.dart';

/// White card with a header row (title, optional tabs, trailing widget), body and footer —
/// the building block of the dashboard pages.
class PanelCard extends StatelessWidget {
  final String? title;
  final List<String>? tabs;
  final int tabIndex;
  final ValueChanged<int>? onTab;
  final Widget? trailing;
  final Widget child;
  final Widget? footer;
  final EdgeInsets padding;
  final double? height;

  const PanelCard({
    super.key,
    this.title,
    this.tabs,
    this.tabIndex = 0,
    this.onTab,
    this.trailing,
    required this.child,
    this.footer,
    this.padding = const EdgeInsets.all(20),
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasHeader = title != null || tabs != null || trailing != null;
    return Container(
      height: height,
      decoration: panelDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: height == null ? MainAxisSize.min : MainAxisSize.max,
        children: [
          if (hasHeader)
            Container(
              padding: const EdgeInsets.only(left: 20, right: 16),
              constraints: const BoxConstraints(minHeight: 56),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: theme.dividerColor)),
              ),
              child: Row(
                children: [
                  if (tabs != null)
                    Expanded(
                      child: _PanelTabs(tabs: tabs!, index: tabIndex, onTab: onTab),
                    )
                  else if (title != null)
                    Expanded(child: Text(title!, style: theme.textTheme.titleLarge?.copyWith(fontSize: 17))),
                  ?trailing,
                ],
              ),
            ),
          if (height == null)
            Padding(padding: padding, child: child)
          else
            Expanded(
              child: Padding(padding: padding, child: child),
            ),
          if (footer != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: theme.dividerColor)),
              ),
              child: footer,
            ),
        ],
      ),
    );
  }
}

class _PanelTabs extends StatelessWidget {
  final List<String> tabs;
  final int index;
  final ValueChanged<int>? onTab;

  const _PanelTabs({required this.tabs, required this.index, this.onTab});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < tabs.length; i++)
            InkWell(
              onTap: onTab == null ? null : () => onTab!(i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 18),
                margin: const EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: i == index ? theme.colorScheme.primary : Colors.transparent, width: 3)),
                ),
                child: Text(
                  tabs[i],
                  style: i == index
                      ? theme.tabBarTheme.labelStyle
                      : theme.tabBarTheme.unselectedLabelStyle?.copyWith(color: theme.tabBarTheme.unselectedLabelColor),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Page title row with actions on the right, like "Overview ....... [Add new]".
class PageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget? leading;

  const PageHeader({super.key, required this.title, this.subtitle, this.actions = const [], this.leading});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 12,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            ?leading,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 2,
              children: [
                Text(title, style: theme.textTheme.headlineSmall),
                if (subtitle case final s?) Text(s, style: theme.textTheme.bodySmall),
              ],
            ),
          ],
        ),
        Wrap(spacing: 8, runSpacing: 8, children: actions),
      ],
    );
  }
}
