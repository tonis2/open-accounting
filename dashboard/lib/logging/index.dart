enum LogLevel { verbose, debug, info, warning, error, fatal }

abstract class LogOutput {
  final LogLevel minLevel;

  const LogOutput({required this.minLevel});

  void log(LogEvent event);

  bool shouldLog(LogLevel level) => level.index >= minLevel.index;
}

class LogEvent {
  final LogLevel level;
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
  final DateTime timestamp;

  LogEvent({required this.level, required this.message, this.error, this.stackTrace, DateTime? timestamp}) : timestamp = timestamp ?? DateTime.now();
}

class AppLogger {
  AppLogger._();

  static List<LogOutput>? _outputs;

  static void init(List<LogOutput> outputs) {
    _outputs = List.unmodifiable(outputs);
  }

  static void _log(LogLevel level, String message, {Object? error, StackTrace? stackTrace}) {
    final outputs = _outputs;
    if (outputs == null) {
      throw StateError('AppLogger.init() must be called before logging.');
    }
    final event = LogEvent(level: level, message: message, error: error, stackTrace: stackTrace);
    for (final output in outputs) {
      if (output.shouldLog(level)) {
        output.log(event);
      }
    }
  }

  static void verbose(String message, {Object? error, StackTrace? stackTrace}) => _log(LogLevel.verbose, message, error: error, stackTrace: stackTrace);

  static void debug(String message, {Object? error, StackTrace? stackTrace}) => _log(LogLevel.debug, message, error: error, stackTrace: stackTrace);

  static void info(String message, {Object? error, StackTrace? stackTrace}) => _log(LogLevel.info, message, error: error, stackTrace: stackTrace);

  static void warning(String message, {Object? error, StackTrace? stackTrace}) => _log(LogLevel.warning, message, error: error, stackTrace: stackTrace);

  static void error(String message, {Object? error, StackTrace? stackTrace}) => _log(LogLevel.error, message, error: error, stackTrace: stackTrace);

  static void fatal(String message, {Object? error, StackTrace? stackTrace}) => _log(LogLevel.fatal, message, error: error, stackTrace: stackTrace);
}
