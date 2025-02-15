import 'package:animated_clock/providers/datetime_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/clock_painter.dart';

class ClockPage extends HookConsumerWidget {
  const ClockPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = ref.watch(dateTimeProvider);
    final formattedTime = ref.watch(formattedTimeProvider);
    final formattedDate = ref.watch(formattedDateProvider);
    final timeZone = ref.watch(timeZoneProvider);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Clock",
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
              height: 20,
            ),
            formattedDate.maybeWhen(
              data: (date) => Text(
                date,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
              ),
              orElse: () => Text(
                "Loading..",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
              ),
            ),
            dateTime.maybeWhen(
              data: (dateTime) => ClockPainterView(dateTime),
              orElse: () => ClockPainterView(DateTime.now()),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "TimeZone",
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.language_rounded,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                timeZone.maybeWhen(
                  data: (timeZoneStr) {
                    return Text(
                      timeZoneStr,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                    );
                  },
                  orElse: () => Text(
                    "",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
