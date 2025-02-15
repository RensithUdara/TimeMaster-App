import 'package:animated_clock/providers/datetime_provider.dart';
import 'package:animated_clock/services/notification_service.dart';
import 'package:animated_clock/shared/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/clock_painter.dart';

class AlarmPage extends HookConsumerWidget {
  const AlarmPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = ref.watch(dateTimeProvider);
    final formattedTime = ref.watch(formattedTimeProvider);
    final formattedDate = ref.watch(formattedDateProvider);
    final timeZone = ref.watch(timeZoneProvider);
    return Expanded(
      child: Scaffold(
        backgroundColor: Color(0xFF2D2F41),
        floatingActionButton: FloatingActionButton(
          child: Image.asset(
            "assets/add_alarm.png",
            fit: BoxFit.cover,
          ),
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          onPressed: () {
            LocalNotificationService()
                .showNotification(id: 1, title: "title", message: "message");
          },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alarm",
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
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemBuilder: (context, index) {
                    var gradientColor =
                        GradientTemplate.gradientTemplate[index].colors;
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientColor,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: gradientColor.last.withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: Offset(4, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.label,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "alarm.title"!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'avenir'),
                                  ),
                                ],
                              ),
                              Switch(
                                onChanged: (bool value) {},
                                value: true,
                                activeColor: Colors.white,
                              ),
                            ],
                          ),
                          Text(
                            'Mon-Fri',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'avenir'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "alarmTime",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'avenir',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.white,
                                  onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
