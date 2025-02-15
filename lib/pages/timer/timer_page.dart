import 'package:animated_clock/providers/timer_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/datetime_provider.dart';

class TimerPage extends HookConsumerWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    final formattedTime = ref.watch(formattedTimeProvider);
    final timerNotifier = ref.read(timerProvider.notifier);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Timer",
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
            SizedBox(
              height: 45,
            ),
            CustomPaint(
              size: const Size(250, 250),
              painter:
                  TimerPainter(timerState.elapsedTime, timerState.totalTime),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                timerState.formattedElapsedTime,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: 40,
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                      timerState.isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40),
                  onPressed: timerState.isRunning
                      ? timerNotifier.pause
                      : timerNotifier.start,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon:
                      const Icon(Icons.refresh, color: Colors.white, size: 40),
                  onPressed: timerNotifier.reset,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Duration elapsed;
  final Duration total;

  TimerPainter(this.elapsed, this.total);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    final Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.green],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(
          center: size.center(Offset.zero), radius: size.width / 2))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final center = size.center(Offset.zero);
    final radius = size.width / 2;
    final angle = (elapsed.inSeconds / total.inSeconds) * 2 * 3.141592653589793;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -1.5708,
        angle, false, progressPaint);
  }

  @override
  bool shouldRepaint(TimerPainter oldDelegate) =>
      oldDelegate.elapsed != elapsed;
}
