import 'package:crypto_tracker/porviders/timer_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StateNotifierProvider<TimerNotifier, int> timerProvider = StateNotifierProvider<TimerNotifier, int>(
  (ref) => TimerNotifier()
);