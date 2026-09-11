import 'package:grpc/grpc.dart';

/// Human-readable message for an exception, preferring the server's gRPC status message.
String errorMessage(Object error, {String fallback = 'Something went wrong'}) {
  if (error is GrpcError) {
    final msg = error.message;
    if (msg != null && msg.isNotEmpty && msg != 'internal error') return msg;
    return switch (error.code) {
      StatusCode.unavailable => 'Server unavailable',
      StatusCode.unauthenticated => 'Please sign in again',
      StatusCode.permissionDenied => 'Permission denied',
      StatusCode.notFound => 'Not found',
      _ => fallback,
    };
  }
  return fallback;
}

bool isUnauthenticated(Object error) => error is GrpcError && error.code == StatusCode.unauthenticated;
