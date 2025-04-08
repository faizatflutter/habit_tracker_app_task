import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Enum to represent internet connectivity status
enum NetworkStatus { connected, disconnected }

/// Service to monitor network changes
class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<NetworkStatus> _controller = StreamController<NetworkStatus>.broadcast();

  /// Constructor: starts listening to connectivity changes
  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen((result) {
      final status = _mapResultToStatus(result);
      _controller.sink.add(status);
    });
  }

  /// Expose network status stream
  Stream<NetworkStatus> get networkStatusStream => _controller.stream;

  /// Check the current status manually
  Future<NetworkStatus> checkCurrentStatus() async {
    final result = await _connectivity.checkConnectivity();
    return _mapResultToStatus(result);
  }

  /// Map ConnectivityResult from the plugin to our enum
  NetworkStatus _mapResultToStatus(List<ConnectivityResult> result) {
    switch (result.first) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return NetworkStatus.connected;
      case ConnectivityResult.none:
      default:
        return NetworkStatus.disconnected;
    }
  }

  /// Dispose stream controller when not needed
  void dispose() {
    _controller.close();
  }
}
