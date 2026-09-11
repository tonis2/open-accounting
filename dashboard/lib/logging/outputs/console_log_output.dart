import 'package:flutter/foundation.dart';

import '../index.dart';

class ConsoleLogOutput extends LogOutput {
  const ConsoleLogOutput({super.minLevel = LogLevel.verbose});

  @override
  void log(LogEvent event) {
    final label = _label(event.level);
    final time = _formatTime(event.timestamp);
    final buffer = StringBuffer('[$label] $time ${event.message}');

    if (event.error != null) {
      buffer.write('\n         -> ${event.error}');
    }
    if (event.stackTrace != null) {
      buffer.write('\n${event.stackTrace}');
    }

    debugPrint(buffer.toString());
  }

  String _label(LogLevel level) {
    return switch (level) {
      LogLevel.verbose => 'VERBOSE',
      LogLevel.debug => 'DEBUG  ',
      LogLevel.info => 'INFO   ',
      LogLevel.warning => 'WARNING',
      LogLevel.error => 'ERROR  ',
      LogLevel.fatal => 'FATAL  ',
    };
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    final ms = dt.millisecond.toString().padLeft(3, '0');
    return '$h:$m:$s.$ms';
  }
}
