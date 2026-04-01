import 'package:bookna_app/core/di/di_locator.dart';
import 'package:bookna_app/core/network/connectivity_service.dart';
import 'package:bookna_app/core/storage/storage_service.dart';
import 'package:bookna_app/core/utils/logging/app_bloc_observer.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInitializer {
  static Future<void> init() async {
    AppLogger.info('🚀 Starting Application Initialization...');
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Global BloC Observer
    Bloc.observer = AppBlocObserver();
    AppLogger.debug('✅ Global Bloc Observer initialized');

    // Initialize Services Locator (Dependency Injection)
    setupServicesLocator();
    AppLogger.debug('✅ Service Locator (GetIt) initialized');

    // Initialize Network Connectivity Monitoring
    getIt.get<IConnectivityService>();
    AppLogger.debug('✅ Network Connectivity Service initialized');

    // Initialize Storage Service (Hive)
    await getIt.get<IStorageService>().init();
    AppLogger.debug('✅ Storage Service (Hive) initialized');

    AppLogger.info('✨ Application Initialization Completed Successfully');
  }
}
