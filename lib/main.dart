import 'package:ems/LeaveApplication/providers/leave_provider.dart';
import 'package:ems/core/providers/locationProvider.dart';
import 'package:ems/core/utils/BackgroundTask/background_task.dart';
import 'package:ems/view/ForgotPassword/Provider/forgot_password_provider.dart';
import 'package:ems/view/Home/providers/home_provider.dart';
import 'package:ems/view/LoginScreen/providers/auth_provider.dart';
import 'package:ems/view/SplashScreen/splashscreen.dart';
import 'package:ems/view/service/servicescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.request();

  final FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );

  await notification.initialize(settings: settings);

  await initializeService();

  // await notification.show(
  //   id: 100,
  //   title: "Test",
  //   body: "Notification Working",
  //   notificationDetails: const NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       'location_tracking',
  //       'Location Tracking',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //     ),
  //   ),
  // );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LeaveProvider()..loadEmployees()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "EMS",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
    );
  }
}
