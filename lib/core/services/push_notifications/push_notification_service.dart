import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

@lazySingleton
class PushNotificationService {
  PushNotificationService({
    required FirebaseMessaging firebaseMessaging,
    required FlutterLocalNotificationsPlugin localNotifications,
    required Talker talker,
  }) : _firebaseMessaging = firebaseMessaging,
       _localNotifications = localNotifications,
       _talker = talker;

  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final Talker _talker;

  static const AndroidNotificationChannel _newsChannel =
      AndroidNotificationChannel(
        'news_updates_channel',
        'News updates',
        description: 'Notifications about fresh news and app updates.',
        importance: Importance.high,
      );

  Future<void> initialize() async {
    await _requestPermission();
    await _prepareLocalNotifications();
    await _listenForegroundMessages();
    await _logCurrentToken();
  }

  Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    _talker.info('Push permission: ${settings.authorizationStatus.name}');
  }

  Future<void> _prepareLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(settings: settings);
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_newsChannel);
  }

  Future<void> _listenForegroundMessages() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    final title = notification?.title;
    final body = notification?.body;

    _talker.info(
      'Foreground push: id=${message.messageId}, title=$title, body=$body',
    );

    if (title == null && body == null) return;

    await _localNotifications.show(
      id: message.hashCode,
      title: title ?? 'News App',
      body: body ?? '',
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _newsChannel.id,
          _newsChannel.name,
          channelDescription: _newsChannel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.messageId,
    );
  }

  Future<void> _logCurrentToken() async {
    final token = await _firebaseMessaging.getToken();
    _talker.info('Firebase messaging token: $token');
  }
}
