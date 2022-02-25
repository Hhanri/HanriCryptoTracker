import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/providers/connectivity_notifier.dart';
import 'package:crypto_tracker/providers/crypto_id_notifier.dart';
import 'package:crypto_tracker/providers/search_notifier.dart';
import 'package:crypto_tracker/providers/timer_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<TimerNotifier, TimerModel> timerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) => TimerNotifier()
);

final StateNotifierProvider<CryptoIdNotifier, List<CryptoIdModel>> cryptoIdsProvider = StateNotifierProvider<CryptoIdNotifier, List<CryptoIdModel>>(
  (ref) => CryptoIdNotifier()
);

final StateNotifierProvider<SearchIdNotifier, SearchModel> searchIdProvider = StateNotifierProvider<SearchIdNotifier, SearchModel>(
  (ref) => SearchIdNotifier()
);

final StateNotifierProvider<ConnectivityNotifier, bool> connectivityProvider = StateNotifierProvider<ConnectivityNotifier, bool>(
  (ref) => ConnectivityNotifier()
);