import 'package:bookna_app/core/di/di_locator.dart';
import 'package:bookna_app/core/utils/global_bloc_observer.dart';
import 'package:bookna_app/core/utils/init_hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInitializer {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Global BloC Observer
    Bloc.observer = AppBlocObserver();

    // Initialize Hive
    await initHive();

    // Initialize Services Locator (Dependency Injection)
    setupServicesLocator();
  }
}
