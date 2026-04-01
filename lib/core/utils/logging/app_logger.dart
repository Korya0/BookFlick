import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    _log('🛠️ DEBUG', message, error, stackTrace);
  }

  static void info(String message) {
    _log('ℹ️ INFO', message);
  }

  static void warning(String message, [Object? error, StackTrace? stackTrace]) {
    _log('⚠️ WARNING', message, error, stackTrace);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _log('❌ ERROR', message, error, stackTrace);
  }

  static void _log(
    String level,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    if (!kDebugMode) return;

    final timestamp = DateTime.now().toLocal().toString().split('.').first;

    debugPrint('[$timestamp] [$level] $message');
    if (error != null) debugPrint('   ↳ Error: $error');
    if (stackTrace != null) debugPrint('   ↳ StackTrace: $stackTrace');
  }
}
