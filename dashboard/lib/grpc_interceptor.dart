import 'package:grpc/grpc.dart';
import 'package:flutter/widgets.dart';

import 'logging/logging.dart';

/// Client interceptor that tracks active gRPC requests and logs errors.
class LoadingInterceptor extends ChangeNotifier implements ClientInterceptor {
  int _activeRequests = 0;
  bool _notifyScheduled = false;

  bool get isLoading => _activeRequests > 0;

  void _scheduleNotify() {
    if (_notifyScheduled) return;
    _notifyScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notifyScheduled = false;
      notifyListeners();
    });
  }

  void _increment() {
    _activeRequests++;
    _scheduleNotify();
  }

  void _decrement() {
    if (_activeRequests > 0) _activeRequests--;
    _scheduleNotify();
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request, CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    _increment();
    AppLogger.debug('gRPC → ${method.path}');
    final future = invoker(method, request, options);

    future
        .then(
          (_) {
            AppLogger.debug('gRPC ✓ ${method.path}');
          },
          onError: (error) {
            _logError(method.path, error);
          },
        )
        .whenComplete(_decrement);

    return future;
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options, ClientStreamingInvoker<Q, R> invoker) {
    _increment();
    final stream = invoker(method, requests, options);

    stream.handleError((error) {
      _logError(method.path, error);
    });

    stream.listen(null, onDone: _decrement, onError: (_) => _decrement());

    return stream;
  }

  void _logError(String methodPath, dynamic error) {
    if (error is GrpcError) {
      final details = error.details != null && error.details!.isNotEmpty ? ' | Details: ${error.details}' : '';
      AppLogger.debug('gRPC ✗ $methodPath: ${error.codeName} - ${error.message}$details');
    } else {
      AppLogger.debug('gRPC ✗ $methodPath: $error');
    }
  }
}
