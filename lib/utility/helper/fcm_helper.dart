import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:miniproject3/utility/helper/push_notification_helper.dart';

class FcmHelper {
  static final FcmHelper _instance = FcmHelper._internal();
  factory FcmHelper() => _instance;
  FcmHelper._internal();

  Future<void> init() async {
    await FirebaseMessaging.instance.requestPermission();

    final String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM TOKEN: $fcmToken");

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    await _handleInitialMessage();
  }

  Future<void> _handleInitialMessage() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      PushNotificationHelper().payload.value = jsonEncode({
        'title': initialMessage.notification?.title,
        'body': initialMessage.notification?.body,
        'data': initialMessage.data,
      });
    }
  }

  void _handleForegroundMessage(RemoteMessage message) async {
    final RemoteNotification? notification = message.notification;
    if (notification != null && !kIsWeb) {
      await PushNotificationHelper()
          .showNotification(notification, message.data);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    PushNotificationHelper().payload.value = jsonEncode({
      'title': message.notification?.title,
      'body': message.notification?.body,
      'data': message.data,
    });
  }
}
