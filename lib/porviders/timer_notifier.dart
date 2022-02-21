import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<TimerModel> {
  TimerNotifier() : super(_initialState);

  static final _initialState = TimerModel(timer: 1, changed: false);
  final Ticker _ticker = Ticker();
  StreamSubscription<void>? _tickerSubscription;

  void start()async {
    _startTimer(1);
  }

  void _startTimer(int timer) {
    _tickerSubscription?.cancel();
    _tickerSubscription =
      _ticker.tick(timer).listen((duration) {
        //print(Ticker.getRemainingTime(timer));
        state = TimerModel(
          timer: state.timer,
          changed: !state.changed// Ticker.getRemainingTime(timer) == timer ? !state.changed : state.changed
        );
        print(state.changed);
      });
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

class Ticker {
  Stream<void> tick(int timer) {
    return Stream.periodic(Duration(seconds: timer), (counter) {
    });
  }
}

class TimerModel {
  final int timer;
  final bool changed;
  TimerModel({ required this.timer, required this.changed});
}