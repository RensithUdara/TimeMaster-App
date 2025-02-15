import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final dateTimeProvider = StreamProvider<DateTime>((ref) {
  return Stream<DateTime>.periodic(
    Duration(seconds: 1),
    (_) => DateTime.now(),
  );
});

final formattedTimeProvider = StreamProvider<String>((ref) {
  return Stream.periodic(
    Duration(seconds: 1),
    (_) {
      final dateTime = DateTime.now();
      return DateFormat("h:MM:ss a").format(dateTime);
    },
  );
});
final formattedDateProvider = StreamProvider<String>((ref) {
  return Stream.periodic(
    Duration(seconds: 1),
    (_) {
      final dateTime = DateTime.now();
      return DateFormat("EEE d MMM").format(dateTime);
    },
  );
});
final timeZoneProvider = StreamProvider<String>((ref) {
  return Stream.periodic(
    Duration(seconds: 1),
    (_) {
      final dateTime = DateTime.now();
      final timeZoneOffset = dateTime.timeZoneOffset;
      final sign = timeZoneOffset.isNegative ? "-" : "+";
      final hours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
      final minutes =
          (timeZoneOffset.inMinutes.abs() % 60).toString().padLeft(2, '0');

      return "UTC $sign$hours:$minutes";
    },
  );
});
