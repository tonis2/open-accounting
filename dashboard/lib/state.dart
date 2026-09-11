import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:localstorage/localstorage.dart';

import 'config.dart';
import 'grpc_channel_stub.dart' if (dart.library.js_interop) 'grpc_channel_web.dart';
import 'grpc_interceptor.dart';
import 'logging/logging.dart';

export 'config.dart';
export 'generated/routes.pbgrpc.dart';

import 'generated/routes.pbgrpc.dart';

/// Makes [AppState] available to the widget tree and rebuilds dependents on change.
class Inherited extends InheritedNotifier<AppState> {
  const Inherited({super.key, required super.notifier, required super.child});

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Inherited>()!.notifier!;
  }

  /// Read without subscribing; for callbacks that only need the client.
  static AppState read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<Inherited>()!.notifier!;
  }
}

const _tokenKey = 'auth_token';
const _userKey = 'user';
const _companyKey = 'company_id';

/// Global session state: gRPC client, signed-in user, companies and the active company.
class AppState extends ChangeNotifier {
  final ConfigurationEnvironment config;
  late final ClientChannelBase channel;
  late final LoadingInterceptor loadingInterceptor;
  late AccountingServiceClient server;

  User? user;
  List<Company> companies = [];
  Company? activeCompany;

  AppState({required this.config}) {
    loadingInterceptor = LoadingInterceptor();
    channel = createChannel(config);
    _buildClient('');
  }

  bool get signedIn => user != null;
  Int64 get companyId => activeCompany?.id ?? Int64.ZERO;

  void _buildClient(String token) {
    server = AccountingServiceClient(
      channel,
      options: CallOptions(metadata: {'authorization': token}, timeout: const Duration(seconds: 60)),
      interceptors: [loadingInterceptor],
    );
  }

  // ---- session ----

  Future<void> signIn(AuthResponse auth) async {
    _buildClient(auth.token);
    user = auth.user;
    localStorage.setItem(_tokenKey, auth.token);
    localStorage.setItem(_userKey, auth.user.writeToJson());
    await loadCompanies();
    notifyListeners();
  }

  /// Restores a saved session if the token is still valid. Returns true when signed in.
  Future<bool> restoreSession() async {
    final token = localStorage.getItem(_tokenKey);
    final userJson = localStorage.getItem(_userKey);
    if (token == null || userJson == null) return false;
    try {
      final exp = JWT.decode(token).payload['exp'] as int?;
      if (exp != null && DateTime.fromMillisecondsSinceEpoch(exp * 1000).isBefore(DateTime.now())) {
        signOut();
        return false;
      }
      _buildClient(token);
      user = User.fromJson(userJson);
      await loadCompanies();
      notifyListeners();
      return true;
    } catch (e) {
      AppLogger.debug('Session restore failed', error: e);
      signOut();
      return false;
    }
  }

  void signOut() {
    localStorage.removeItem(_tokenKey);
    localStorage.removeItem(_userKey);
    user = null;
    companies = [];
    activeCompany = null;
    _buildClient('');
    notifyListeners();
  }

  // ---- companies ----

  Future<void> loadCompanies() async {
    final res = await server.listCompanies(Empty());
    companies = res.items;
    final savedId = localStorage.getItem(_companyKey);
    activeCompany = companies.where((c) => c.id.toString() == savedId).firstOrNull ?? companies.firstOrNull;
    if (activeCompany != null) localStorage.setItem(_companyKey, activeCompany!.id.toString());
    notifyListeners();
  }

  void switchCompany(Company company) {
    activeCompany = company;
    localStorage.setItem(_companyKey, company.id.toString());
    notifyListeners();
  }

  /// Replaces a company in the list after an edit, keeping the active pointer current.
  void updateCompany(Company company) {
    companies = [for (final c in companies) c.id == company.id ? company : c];
    if (activeCompany?.id == company.id) activeCompany = company;
    notifyListeners();
  }
}
