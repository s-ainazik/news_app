import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lesson_1/core/di/app_dependencies.dart';
import 'package:lesson_1/core/router/app_router.dart';
import 'package:lesson_1/core/services/push_notifications/firebase_background_handler.dart';
import 'package:lesson_1/core/services/push_notifications/push_notification_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final firebaseIsReady = await _initializeFirebase();
  if (firebaseIsReady) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  await configureDependencies();

  if (firebaseIsReady) {
    await getIt<PushNotificationService>().initialize();
  }

  runApp(MyApp());
}

Future<bool> _initializeFirebase() async {
  try {
    await Firebase.initializeApp();
    return true;
  } catch (error, stackTrace) {
    TalkerFlutter.init().warning(
      'Firebase is not configured yet. Add your Firebase config to enable push notifications.',
      error,
      stackTrace,
    );
    return false;
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
