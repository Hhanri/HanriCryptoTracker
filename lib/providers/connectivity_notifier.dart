import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto_tracker/services/connetivity_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityNotifier extends StateNotifier<bool> {
  ConnectivityNotifier() : super(false);

  static final connectivity = ConnectivityService();

  void startListeningConnectivityState() {
    connectivity.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        state = false;
      } else {
        state = true;
      }
    });
  }
}