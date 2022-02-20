import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(_initialState);

  static const _initialState = 0;
  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  void start()async {
    _startTimer();
  }

  void _startTimer() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
      _ticker.tick().listen((duration) {
        state = duration;
      });
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

class Ticker {
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (counter) {
      print(counter);
      return counter.isEven ? 1 : 0;
    });
  }
}