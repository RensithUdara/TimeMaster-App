import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StopwatchState {
  final Duration elapsedTime;
  final bool isRunning;
  final List<Duration> lapTimes;

  StopwatchState({
    required this.elapsedTime,
    this.isRunning = false,
    this.lapTimes = const [],
  });

  String get formattedElapsedTime => _formatDuration(elapsedTime);

  static String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}

class StopwatchNotifier extends StateNotifier<StopwatchState> {
  StopwatchNotifier() : super(StopwatchState(elapsedTime: Duration.zero));

  Timer? _timer;

  void start() {
    if (state.isRunning) return;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state = StopwatchState(
        elapsedTime: state.elapsedTime + Duration(seconds: 1),
        isRunning: true,
        lapTimes: state.lapTimes,
      );
    });
  }

  void pause() {
    _timer?.cancel();
    state = StopwatchState(
      elapsedTime: state.elapsedTime,
      isRunning: false,
      lapTimes: state.lapTimes,
    );
  }

  void reset() {
    _timer?.cancel();
    state = StopwatchState(
        elapsedTime: Duration.zero, isRunning: false, lapTimes: []);
  }

  void addLap() {
    state = StopwatchState(
      elapsedTime: state.elapsedTime,
      isRunning: state.isRunning,
      lapTimes: [...state.lapTimes, state.elapsedTime],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final stopwatchProvider =
    StateNotifierProvider<StopwatchNotifier, StopwatchState>(
  (ref) => StopwatchNotifier(),
);
