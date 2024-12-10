import 'dart:async';

import 'package:flutter/material.dart';

class TimerController {
  final VoidCallback? onTick;

  Timer? timer;
  bool pause = false;
  Duration initialDuration;

  late Duration currentDurationLeft;

  TimerController({required this.initialDuration, this.onTick}) {
    currentDurationLeft = initialDuration;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (currentDurationLeft == Duration.zero) {
        timer.cancel();
      } else {
        if (pause) return;

        currentDurationLeft = currentDurationLeft - const Duration(seconds: 1);
        if (onTick != null) onTick!();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void resetTimer({required Duration initialDuration}) {
    stopTimer();
    currentDurationLeft = initialDuration;
    startTimer();
  }

  void pauseTimer(bool pause) {
    this.pause = pause;
  }

  void addTime({required Duration duration}) {
    currentDurationLeft = currentDurationLeft + duration;
  }

  void subtractTime({required Duration duration}) {
    currentDurationLeft = currentDurationLeft - duration;
  }
}
