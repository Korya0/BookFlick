import 'package:bookna_app/core/utils/app_initializer.dart';
import 'package:bookna_app/core/presentation/views/main_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppInitializer.init();

  runApp(
    kIsWeb && !kDebugMode
        ? DevicePreview(builder: (context) => const BookFlick())
        : const BookFlick(),
  );
}
