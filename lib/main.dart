import 'package:animated_clock/pages/main_page.dart';
import 'package:animated_clock/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //local notification
  LocalNotificationService().initNotification();

  runApp(
    ProviderScope(child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Clock',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF2D2F41),
        ),
      ),
      home: MainPage(),
    );
  }
}
