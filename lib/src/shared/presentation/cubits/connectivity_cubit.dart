import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app_task/src/core/services/connectivity_service.dart';

class ConnectivityCubit extends Cubit<NetworkStatus> {
  final ConnectivityService _connectivityService;
  late final StreamSubscription<NetworkStatus> _subscription;

  ConnectivityCubit(this._connectivityService) : super(NetworkStatus.connected) {
    _subscription = _connectivityService.networkStatusStream.listen((status) {
      emit(status);
    });
  }

  Future<void> checkInitialStatus() async {
    final status = await _connectivityService.checkCurrentStatus();
    emit(status);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
