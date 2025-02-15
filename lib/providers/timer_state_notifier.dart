import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerState {
  final Duration elapsedTime;
  final Duration totalTime;
  final bool isRunning;

  TimerState(
      {required this.elapsedTime,
      required this.totalTime,
      this.isRunning = false});

  String get formattedElapsedTime => _formatDuration(elapsedTime);
  String get formattedTotalTime => _formatDuration(totalTime);

  static String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier()
      : super(TimerState(
            elapsedTime: Duration.zero,
            totalTime: Duration(minutes: 5))); // Default total time

  Timer? _timer;

  void start() {
    if (state.isRunning) return;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.elapsedTime < state.totalTime) {
        state = TimerState(
          elapsedTime: state.elapsedTime + Duration(seconds: 1),
          totalTime: state.totalTime,
          isRunning: true,
        );
      } else {
        pause();
      }
    });
  }

  void pause() {
    _timer?.cancel();
    state = TimerState(
      elapsedTime: state.elapsedTime,
      totalTime: state.totalTime,
      isRunning: false,
    );
  }

  void reset() {
    _timer?.cancel();
    state = TimerState(
      elapsedTime: Duration.zero,
      totalTime: state.totalTime,
      isRunning: false,
    );
  }

  void setTotalTime(Duration newTime) {
    state = TimerState(
      elapsedTime: Duration.zero,
      totalTime: newTime,
      isRunning: false,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerState>(
  (ref) => TimerNotifier(),
);
