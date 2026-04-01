import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';

abstract class IConnectivityService {
  Stream<bool> get onConnectivityChanged;
  bool get isConnected;
  void dispose();
}

class ConnectivityServiceImpl implements IConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final _connectionController = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _isConnectedNow = true;

  ConnectivityServiceImpl() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      AppLogger.error('ConnectivityService: Failed to check initial status', e);
      _connectionController.add(false);
    }
  }

  @override
  Stream<bool> get onConnectivityChanged => _connectionController.stream;

  @override
  bool get isConnected => _isConnectedNow;

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    _isConnectedNow = results.any(
      (element) => element != ConnectivityResult.none,
    );

    AppLogger.info(
      '🌐 Network Status: ${_isConnectedNow ? "CONNECTED" : "DISCONNECTED"}',
    );

    if (!_connectionController.isClosed) {
      _connectionController.add(_isConnectedNow);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _connectionController.close();
    AppLogger.debug('ConnectivityService Disposed');
  }
}
