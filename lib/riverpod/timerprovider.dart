import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final timerProvider = StateProvider<bool>((ref) {
  return false;
});

final timer = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(10);

  void startTimer() {
    state = 10;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        timer.cancel();
      }
    });
  }
}
