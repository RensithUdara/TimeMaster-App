import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/datetime_provider.dart';
import '../../providers/stopwatch_state_notifier.dart';

class StopwatchPage extends HookConsumerWidget {
  const StopwatchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchState = ref.watch(stopwatchProvider);
    final formattedTime = ref.watch(formattedTimeProvider);
    final stopwatchNotifier = ref.read(stopwatchProvider.notifier);

    // Helper function to format duration
    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$hours:$minutes:$seconds";
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Stopwatch",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 30,
                    color: Colors.white,
                  ),
            ),
            SizedBox(
              height: 25,
            ),
            formattedTime.maybeWhen(
              data: (time) => Text(
                time,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 50,
                      color: Colors.white,
                    ),
              ),
              orElse: () => Text(
                "Loading..",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 50,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(height: 250),
            Center(
              child: Text(
                stopwatchState.formattedElapsedTime,
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: stopwatchState.isRunning
                      ? stopwatchNotifier.pause
                      : stopwatchNotifier.start,
                  child: Text(stopwatchState.isRunning ? "Pause" : "Start"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: stopwatchNotifier.reset,
                  child: Text("Reset"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: stopwatchNotifier.addLap,
                  child: Text("Lap"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: stopwatchState.lapTimes.length,
                itemBuilder: (context, index) {
                  final lapTime = stopwatchState.lapTimes[index];
                  return ListTile(
                    title: Text(
                      "Lap ${index + 1}: ${formatDuration(lapTime)}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
