import 'package:animated_clock/pages/alarm/alarm_page.dart';
import 'package:animated_clock/pages/clock/clock_page.dart';
import 'package:animated_clock/pages/stopwatch/stopwatch_page.dart';
import 'package:animated_clock/pages/timer/timer_page.dart';
import 'package:animated_clock/providers/page_index_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexNotifierProvider);
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => ref
                              .read(pageIndexNotifierProvider.notifier)
                              .changeIndex(0),
                          child: Ink(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: pageIndex == 0
                                  ? Color(0xFF444974).withOpacity(0.2)
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              border: pageIndex == 0
                                  ? Border.all(
                                      color: Colors.blueGrey,
                                    )
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/clock_icon.png",
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    "Clock",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => ref
                              .read(pageIndexNotifierProvider.notifier)
                              .changeIndex(1),
                          child: Ink(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: pageIndex == 1
                                  ? Color(0xFF444974).withOpacity(0.2)
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              border: pageIndex == 1
                                  ? Border.all(
                                      color: Colors.blueGrey,
                                    )
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/alarm_icon.png",
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    "Alarm",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => ref
                              .read(pageIndexNotifierProvider.notifier)
                              .changeIndex(2),
                          child: Ink(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: pageIndex == 2
                                  ? Color(0xFF444974).withOpacity(0.2)
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              border: pageIndex == 2
                                  ? Border.all(
                                      color: Colors.blueGrey,
                                    )
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/timer_icon.png",
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    "Timer",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => ref
                              .read(pageIndexNotifierProvider.notifier)
                              .changeIndex(3),
                          child: Ink(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: pageIndex == 3
                                  ? Color(0xFF444974).withOpacity(0.2)
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              border: pageIndex == 3
                                  ? Border.all(
                                      color: Colors.blueGrey,
                                    )
                                  : null,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/stopwatch_icon.png",
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    "Stop\nWatch",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              VerticalDivider(),
              pageIndex == 0
                  ? ClockPage()
                  : pageIndex == 1
                      ? AlarmPage()
                      : pageIndex == 2
                          ? TimerPage()
                          : pageIndex == 3
                              ? StopwatchPage()
                              : ClockPage(),
            ],
          ),
        ),
      ),
    );
  }
}
