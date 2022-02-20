import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<TimerModel> {
  TimerNotifier() : super(_initialState);

  static final _initialState = TimerModel(timeLeft: Ticker.getRemainingTime(10), timer: 10, changed: false);
  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  void start()async {
    _startTimer(10);
  }

  void _startTimer(int timer) {
    _tickerSubscription?.cancel();
    _tickerSubscription =
      _ticker.tick().listen((duration) {
        //print(Ticker.getRemainingTime(timer));
        state = TimerModel(
          timeLeft: Ticker.getRemainingTime(timer),
          timer: state.timer,
          changed: Ticker.getRemainingTime(timer) == 10 ? !state.changed : state.changed
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
  Stream<int> tick() {
    return Stream.periodic(const Duration(seconds: 1), (counter) {
      return getRemainingTime(10);
    });
  }
  static int getRemainingTime(int timer) {
    return timer - (DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond)%timer;
  }
}
class TimerModel {
  final int timeLeft;
  final int timer;
  final bool changed;
  TimerModel({required this.timeLeft, required this.timer, required this.changed});
}