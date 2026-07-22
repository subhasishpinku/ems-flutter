import 'dart:async';

class CountdownTimer {
  static const int totalSeconds = 30 * 60;

  int remainingSeconds = totalSeconds;
  Timer? timer;

  void start(Future<void> Function() onTimerComplete) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (remainingSeconds > 0) {
        remainingSeconds--;

        final minutes = remainingSeconds ~/ 60;
        final seconds = remainingSeconds % 60;

        print(
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
        );
      } else {
        timer.cancel();
        await onTimerComplete();
      }
    });
  }

  Future<void> stop(Future<void> Function() onStop) async {
    timer?.cancel();
    await onStop();
  }
}

void onTimerComplete() {
  print("30 minutes completed!");
  // Call your function here
}
