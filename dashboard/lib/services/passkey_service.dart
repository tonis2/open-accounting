import 'dart:convert';

import 'package:passkeys/authenticator.dart';
import 'package:passkeys/types.dart';

/// Bridges go-webauthn option JSON and the passkeys package, which already speaks the
/// standard WebAuthn JSON shapes — so no field-by-field mapping is needed.
class PasskeyService {
  final PasskeyAuthenticator _authenticator = PasskeyAuthenticator();

  Future<bool> isSupported() async {
    try {
      // ignore: deprecated_member_use
      return await _authenticator.canAuthenticate();
    } catch (_) {
      return false;
    }
  }

  /// Runs navigator.credentials.create() and returns the credential JSON for the server.
  Future<String> register(String optionsJson) async {
    final options = jsonDecode(optionsJson) as Map<String, dynamic>;
    final request = RegisterRequestType.fromJson(options['publicKey'] as Map<String, dynamic>);
    final response = await _authenticator.register(request);
    return response.toJsonString();
  }

  /// Runs navigator.credentials.get() and returns the assertion JSON for the server.
  Future<String> authenticate(String optionsJson) async {
    final options = jsonDecode(optionsJson) as Map<String, dynamic>;
    final request = AuthenticateRequestType.fromJson(
      options['publicKey'] as Map<String, dynamic>,
      mediation: MediationType.Optional,
      preferImmediatelyAvailableCredentials: false,
    );
    final response = await _authenticator.authenticate(request);
    return response.toJsonString();
  }
}

final passkeyService = PasskeyService();
