import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';

import 'l10n/app_localizations.dart';
import 'logging/logging.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/recover_page.dart';
import 'pages/auth/register_page.dart';
import 'pages/banking/account_page.dart';
import 'pages/banking/bank_callback_page.dart';
import 'pages/banking/banking_page.dart';
import 'pages/banking/connect_bank_page.dart';
import 'pages/invoices/invoice_detail_page.dart';
import 'pages/invoices/invoice_editor_page.dart';
import 'pages/invoices/invoices_page.dart';
import 'pages/overview/overview_page.dart';
import 'pages/projects/project_detail_page.dart';
import 'pages/projects/projects_page.dart';
import 'pages/settings/categories_page.dart';
import 'pages/settings/companies_page.dart';
import 'pages/settings/company_settings_page.dart';
import 'pages/settings/security_page.dart';
import 'pages/shell.dart';
import 'state.dart';
import 'theme.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _shellKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  if (kIsWeb) usePathUrlStrategy();

  AppLogger.init([const ConsoleLogOutput(minLevel: kDebugMode ? LogLevel.debug : LogLevel.info), SnackBarLogOutput(navigatorKey: _rootKey)]);

  const flavor = String.fromEnvironment('flavor', defaultValue: 'prod');
  final state = AppState(config: configForFlavor(flavor));
  AppLogger.debug('App started (flavor: $flavor, server: ${state.config.serverUri})');
  runApp(Inherited(notifier: state, child: const OpenAccountingApp()));
}

class OpenAccountingApp extends StatelessWidget {
  const OpenAccountingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Open Accounting',
      theme: appThemeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _router,
    );
  }
}

bool _sessionRestored = false;

Future<String?> _redirect(BuildContext context, GoRouterState routerState) async {
  final state = Inherited.read(context);
  final location = routerState.matchedLocation;
  final isAuthPage = location == AppRoutes.login || location == AppRoutes.register;
  final isRecovery = location == AppRoutes.recover;

  if (!_sessionRestored) {
    _sessionRestored = true;
    await state.restoreSession();
  }
  if (!state.signedIn) {
    return (isAuthPage || isRecovery) ? null : AppRoutes.login;
  }
  if (isAuthPage) return AppRoutes.overview;
  // A signed-in user without a company is sent to the company wizard first.
  if (state.companies.isEmpty && location != AppRoutes.settingsCompanies) {
    return '${AppRoutes.settingsCompanies}?new=1';
  }
  return null;
}

GoRoute _route(String path, Widget Function(GoRouterState state) builder, {bool scroll = false}) {
  return GoRoute(
    path: path,
    pageBuilder: (context, state) => CustomTransitionPage<void>(
      key: state.pageKey,
      child: scroll ? PageBody(child: builder(state)) : builder(state),
      transitionDuration: const Duration(milliseconds: 150),
      transitionsBuilder: (_, animation, _, child) => FadeTransition(opacity: animation, child: child),
    ),
  );
}

final _router = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: AppRoutes.overview,
  redirect: _redirect,
  routes: [
    _route(AppRoutes.login, (_) => const LoginPage()),
    _route(AppRoutes.register, (_) => const RegisterPage()),
    _route(AppRoutes.recover, (s) => RecoverPage(token: s.uri.queryParameters['token'])),
    ShellRoute(
      navigatorKey: _shellKey,
      builder: (context, state, child) => DashboardShell(child: child),
      routes: [
        _route(AppRoutes.overview, (_) => const OverviewPage(), scroll: true),
        _route(AppRoutes.projects, (_) => const ProjectsPage(), scroll: true),
        _route('${AppRoutes.project}/:id', (s) => ProjectDetailPage(projectId: s.pathParameters['id']!), scroll: true),
        _route(AppRoutes.invoices, (_) => const InvoicesPage(), scroll: true),
        _route(AppRoutes.invoiceNew, (s) => InvoiceEditorPage(projectId: s.uri.queryParameters['project']), scroll: true),
        _route('${AppRoutes.invoice}/:id', (s) => InvoiceDetailPage(invoiceId: s.pathParameters['id']!), scroll: true),
        _route('${AppRoutes.invoice}/:id/edit', (s) => InvoiceEditorPage(invoiceId: s.pathParameters['id']), scroll: true),
        _route(AppRoutes.banking, (_) => const BankingPage(), scroll: true),
        _route('${AppRoutes.bankAccount}/:id', (s) => AccountPage(accountId: s.pathParameters['id']!), scroll: true),
        _route(AppRoutes.bankConnect, (_) => const ConnectBankPage(), scroll: true),
        _route(AppRoutes.bankCallback, (s) => BankCallbackPage(reference: s.uri.queryParameters['ref'] ?? '', params: s.uri.queryParameters), scroll: true),
        _route(AppRoutes.settingsCompany, (_) => const CompanySettingsPage(), scroll: true),
        _route(AppRoutes.settingsCompanies, (s) => CompaniesPage(startNew: s.uri.queryParameters['new'] == '1'), scroll: true),
        _route(AppRoutes.settingsCategories, (_) => const CategoriesPage(), scroll: true),
        _route(AppRoutes.settingsSecurity, (_) => const SecurityPage(), scroll: true),
      ],
    ),
  ],
);
