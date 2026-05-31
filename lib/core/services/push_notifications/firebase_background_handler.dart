import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:talker_flutter/talker_flutter.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  final talker = TalkerFlutter.init();
  talker.info(
    'Background push: id=${message.messageId}, '
    'title=${message.notification?.title}, '
    'body=${message.notification?.body}, '
    'data=${message.data}',
  );
}
