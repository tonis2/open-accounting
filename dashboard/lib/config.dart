import 'package:flutter/foundation.dart';

/// Route paths used by go_router and navigation widgets.
class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const recover = '/recover';

  static const overview = '/overview';
  static const projects = '/projects';
  static const project = '/projects'; // /:id
  static const invoices = '/invoices';
  static const invoiceNew = '/invoices/new';
  static const invoice = '/invoices'; // /:id and /:id/edit
  static const banking = '/banking';
  static const bankAccount = '/banking/accounts'; // /:id
  static const bankConnect = '/banking/connect';
  static const bankCallback = '/banking/callback';
  static const settingsCompany = '/settings/company';
  static const settingsCompanies = '/settings/companies';
  static const settingsCategories = '/settings/categories';
  static const settingsSecurity = '/settings/security';
}

/// Per-flavor connection settings. Selected with --dart-define=flavor=dev|prod.
class ConfigurationEnvironment {
  final String flavor;
  final String scheme;
  final String host;
  final int port;

  const ConfigurationEnvironment({required this.flavor, required this.scheme, required this.host, required this.port});

  Uri get serverUri => Uri(scheme: scheme, host: host, port: port);
  bool get isSecure => scheme == 'https';
}

/// Development: Flutter on :8000, Envoy on :8081 in front of the Go server.
const devConfig = ConfigurationEnvironment(flavor: 'dev', scheme: 'http', host: 'localhost', port: 8081);

/// Production: same origin as the page; Caddy routes gRPC-Web calls to Envoy.
ConfigurationEnvironment prodConfig() {
  if (kIsWeb) {
    final base = Uri.base;
    return ConfigurationEnvironment(flavor: 'prod', scheme: base.scheme, host: base.host, port: base.hasPort ? base.port : (base.scheme == 'https' ? 443 : 80));
  }
  return const ConfigurationEnvironment(flavor: 'prod', scheme: 'https', host: 'localhost', port: 443);
}

ConfigurationEnvironment configForFlavor(String flavor) => flavor == 'dev' ? devConfig : prodConfig();
