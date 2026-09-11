import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/index.dart';
import '../l10n/app_localizations.dart';
import '../responsive.dart';
import '../state.dart';

/// Signed-in layout: top navigation, global progress bar and a centred content column.
class DashboardShell extends StatelessWidget {
  final Widget child;
  const DashboardShell({super.key, required this.child});

  List<NavItem> _items(AppLocalizations l) => [
    NavItem(l.navOverview, AppRoutes.overview),
    NavItem(l.navProjects, AppRoutes.projects),
    NavItem(l.navInvoices, AppRoutes.invoices),
    NavItem(l.navBanking, AppRoutes.banking),
    NavItem(
      l.navSettings,
      '/settings',
      children: [
        NavItem(l.navCompanySettings, AppRoutes.settingsCompany),
        NavItem(l.navCompanies, AppRoutes.settingsCompanies),
        NavItem(l.navCategories, AppRoutes.settingsCategories),
        NavItem(l.navSecurity, AppRoutes.settingsSecurity),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final state = Inherited.of(context);
    final location = GoRouterState.of(context).matchedLocation;
    final compact = !isDesktop(context);
    final items = _items(l);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: compact ? _NavDrawer(items: items, location: location) : null,
      body: Column(
        children: [
          TopNav(
            items: items,
            location: location,
            onNavigate: (r) => context.go(r),
            companyName: state.activeCompany?.name ?? l.appTitle,
            companies: [for (final c in state.companies) c.name],
            onSwitchCompany: (i) {
              state.switchCompany(state.companies[i]);
              context.go(AppRoutes.overview);
            },
            onCreateCompany: () => context.go('${AppRoutes.settingsCompanies}?new=1'),
            onSignOut: () {
              state.signOut();
              context.go(AppRoutes.login);
            },
            createCompanyLabel: l.createCompany,
            signOutLabel: l.navSignOut,
            userEmail: state.user?.email ?? '',
            compact: compact,
            onMenu: () => scaffoldKey.currentState?.openDrawer(),
          ),
          ListenableBuilder(
            listenable: state.loadingInterceptor,
            builder: (context, _) => SizedBox(height: 3, child: state.loadingInterceptor.isLoading ? const LinearProgressIndicator(minHeight: 3) : null),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Scrolling, centred content column. Each page is wrapped in one so route transitions never
/// share a single scroll viewport.
class PageBody extends StatelessWidget {
  final Widget child;
  const PageBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final compact = !isDesktop(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 32, vertical: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kContentMaxWidth),
          child: child,
        ),
      ),
    );
  }
}

class _NavDrawer extends StatelessWidget {
  final List<NavItem> items;
  final String location;
  const _NavDrawer({required this.items, required this.location});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          for (final item in items) ...[
            if (item.children.isEmpty)
              ListTile(
                title: Text(item.label),
                selected: item.matches(location),
                selectedColor: theme.colorScheme.primary,
                onTap: () {
                  Navigator.pop(context);
                  context.go(item.route);
                },
              )
            else ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(item.label, style: theme.textTheme.labelSmall),
              ),
              for (final c in item.children)
                ListTile(
                  title: Text(c.label),
                  selected: c.matches(location),
                  selectedColor: theme.colorScheme.primary,
                  onTap: () {
                    Navigator.pop(context);
                    context.go(c.route);
                  },
                ),
            ],
          ],
        ],
      ),
    );
  }
}
