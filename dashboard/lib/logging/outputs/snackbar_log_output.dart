import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../index.dart';

class SnackBarLogOutput extends LogOutput {
  final GlobalKey<NavigatorState> navigatorKey;

  const SnackBarLogOutput({required this.navigatorKey, super.minLevel = LogLevel.info});

  @override
  void log(LogEvent event) {
    // Schedule for next frame so overlay is guaranteed to be available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = navigatorKey.currentState?.overlay;
      if (overlay == null) return;

      showTopSnackBar(
        overlay,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: _colorForLevel(event.level)),
          child: Row(
            spacing: 12,
            children: [
              Icon(_iconForLevel(event.level), color: Colors.white, size: 22),
              Expanded(
                child: Text(
                  event.message,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'ValueSansPro', decoration: TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
        displayDuration: _durationForLevel(event.level),
      );
    });
  }

  static Color _colorForLevel(LogLevel level) {
    return switch (level) {
      LogLevel.verbose || LogLevel.debug => const Color(0xFF6B7280),
      LogLevel.info => const Color(0xFF2E7D32),
      LogLevel.warning => const Color(0xFFF59E0B),
      LogLevel.error || LogLevel.fatal => const Color(0xFFDC2626),
    };
  }

  static IconData _iconForLevel(LogLevel level) {
    return switch (level) {
      LogLevel.verbose || LogLevel.debug || LogLevel.info => Icons.info_outline,
      LogLevel.warning => Icons.warning_amber,
      LogLevel.error || LogLevel.fatal => Icons.error_outline,
    };
  }

  static Duration _durationForLevel(LogLevel level) {
    return switch (level) {
      LogLevel.verbose || LogLevel.debug || LogLevel.info => const Duration(seconds: 2),
      LogLevel.warning => const Duration(seconds: 3),
      LogLevel.error || LogLevel.fatal => const Duration(seconds: 4),
    };
  }
}
