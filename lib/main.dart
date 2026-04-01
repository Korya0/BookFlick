import 'package:bookna_app/core/utils/app_initializer.dart';
import 'package:bookna_app/core/presentation/views/main_app.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  // Capture Flutter framework errors
  FlutterError.onError = (details) {
    AppLogger.error(
      '💥 FLUTTER FRAMEWORK ERROR',
      details.exception,
      details.stack,
    );
  };

  // Capture asynchronous errors
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLogger.error('💥 UNCAUGHT ASYNC ERROR', error, stack);
    return true;
  };

  await AppInitializer.init();

  runApp(
    kIsWeb && !kDebugMode
        ? DevicePreview(builder: (context) => const BookFlick())
        : const BookFlick(),
  );
}
