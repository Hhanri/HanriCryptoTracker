import 'package:crypto_tracker/models/crypto_id_model.dart';
import 'package:crypto_tracker/porviders/crypto_id_notifier.dart';
import 'package:crypto_tracker/porviders/timer_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<TimerNotifier, TimerModel> timerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref) => TimerNotifier()
);

final StateNotifierProvider<CryptoIdNotifier, List<CryptoIdModel>> cryptoIdsProvider = StateNotifierProvider<CryptoIdNotifier, List<CryptoIdModel>>(
  (ref) => CryptoIdNotifier()
);