import 'package:flutter/material.dart';

import '../theme.dart';

/// Shared look for MenuAnchor menus (matches the popup menu theme).
MenuStyle menuStyle(BuildContext context) {
  final theme = Theme.of(context);
  return MenuStyle(
    backgroundColor: WidgetStatePropertyAll(theme.colorScheme.surface),
    surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
    elevation: const WidgetStatePropertyAll(4),
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 6)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: theme.dividerColor),
      ),
    ),
  );
}

class NavItem {
  final String label;
  final String route;
  final List<NavItem> children;
  const NavItem(this.label, this.route, {this.children = const []});

  bool matches(String location) => location == route || location.startsWith('$route/') || children.any((c) => c.matches(location));
}

/// FreeAgent-style blue navigation bar with dropdown menus and a company switcher.
class TopNav extends StatelessWidget {
  final List<NavItem> items;
  final String location;
  final ValueChanged<String> onNavigate;
  final String companyName;
  final List<String> companies;
  final ValueChanged<int>? onSwitchCompany;
  final VoidCallback? onCreateCompany;
  final VoidCallback onSignOut;
  final String createCompanyLabel;
  final String signOutLabel;
  final String userEmail;
  final bool compact;
  final VoidCallback? onMenu;

  const TopNav({
    super.key,
    required this.items,
    required this.location,
    required this.onNavigate,
    required this.companyName,
    required this.companies,
    required this.onSwitchCompany,
    required this.onCreateCompany,
    required this.onSignOut,
    required this.createCompanyLabel,
    required this.signOutLabel,
    required this.userEmail,
    this.compact = false,
    this.onMenu,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.appBarTheme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: theme.appBarTheme.toolbarHeight,
          child: Row(
            children: [
              if (compact)
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: onMenu,
                )
              else ...[
                const SizedBox(width: 12),
                for (final item in items) _NavButton(item: item, active: item.matches(location), onNavigate: onNavigate),
              ],
              const Spacer(),
              _CompanyMenu(
                companyName: companyName,
                companies: companies,
                onSwitch: onSwitchCompany,
                onCreate: onCreateCompany,
                onSignOut: onSignOut,
                createLabel: createCompanyLabel,
                signOutLabel: signOutLabel,
                userEmail: userEmail,
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final NavItem item;
  final bool active;
  final ValueChanged<String> onNavigate;
  const _NavButton({required this.item, required this.active, required this.onNavigate});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.active ? AppColors.navActive : (_hover ? AppColors.navActive.withValues(alpha: 0.6) : Colors.transparent);
    final label = Text(
      widget.item.label,
      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
    );
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          label,
          if (widget.item.children.isNotEmpty) const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
        ],
      ),
    );
    Widget child;
    if (widget.item.children.isEmpty) {
      child = InkWell(onTap: () => widget.onNavigate(widget.item.route), child: content);
    } else {
      child = MenuAnchor(
        style: menuStyle(context),
        menuChildren: [
          for (final c in widget.item.children)
            MenuItemButton(
              onPressed: () => widget.onNavigate(c.route),
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text(c.label)),
            ),
        ],
        builder: (context, controller, _) => InkWell(onTap: () => controller.isOpen ? controller.close() : controller.open(), child: content),
      );
    }
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Container(color: bg, height: double.infinity, child: child),
    );
  }
}

class _CompanyMenu extends StatelessWidget {
  final String companyName;
  final List<String> companies;
  final ValueChanged<int>? onSwitch;
  final VoidCallback? onCreate;
  final VoidCallback onSignOut;
  final String createLabel;
  final String signOutLabel;
  final String userEmail;

  const _CompanyMenu({
    required this.companyName,
    required this.companies,
    required this.onSwitch,
    required this.onCreate,
    required this.onSignOut,
    required this.createLabel,
    required this.signOutLabel,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget item(IconData? icon, String label, VoidCallback? onTap, {Color? iconColor}) => MenuItemButton(
      onPressed: onTap,
      leadingIcon: icon == null ? null : Icon(icon, size: 16, color: iconColor ?? theme.colorScheme.onSurfaceVariant),
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Text(label, overflow: TextOverflow.ellipsis),
      ),
    );
    return MenuAnchor(
      style: menuStyle(context),
      alignmentOffset: const Offset(-160, 0),
      menuChildren: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
          child: Text(userEmail, style: theme.textTheme.labelSmall),
        ),
        for (var i = 0; i < companies.length; i++)
          item(
            companies[i] == companyName ? Icons.radio_button_checked : Icons.radio_button_off,
            companies[i],
            () => onSwitch?.call(i),
            iconColor: companies[i] == companyName ? theme.colorScheme.primary : theme.hintColor,
          ),
        if (onCreate != null) item(Icons.add, createLabel, onCreate),
        const Divider(height: 8),
        item(Icons.logout, signOutLabel, onSignOut),
      ],
      builder: (context, controller, _) => InkWell(
        onTap: () => controller.isOpen ? controller.close() : controller.open(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 220),
                child: Text(
                  companyName.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.3),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
