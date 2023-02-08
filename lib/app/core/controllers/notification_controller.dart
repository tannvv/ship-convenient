import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  static final NotificationController _instance =
      NotificationController._internal();
  static NotificationController get instance => _instance;
  NotificationController._internal();

  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'convenient.way.notification', // id
    'Convenient way for delivering application', // title
    description: 'Convenient copy right', // description
    importance: Importance.max,
  );

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint(
            'Notification: Foreground message received, Title: ${message.notification?.title}, Body: ${message.notification?.body}');
        showNotification(
            title: message.notification?.title,
            body: message.notification?.body);
      },
    );
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint(
        'Notification: Background message received, Title: ${message.notification?.title}, Body: ${message.notification?.body}');
    showNotification(
        title: message.notification?.title, body: message.notification?.body);
  }

  static Future<void> showNotification({
    var id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
            'channel_id 1', // id
            'Convenient way for delivering application', // title
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(''));

    var notify = NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(id, title, body, notify,
        payload: payload);
  }

  Future<void> registerNotification() async {
    await FirebaseMessaging.instance.subscribeToTopic('all').then((_) {
      debugPrint('Notification: Subscribed to topic: all');
    });
    await FirebaseMessaging.instance
        .subscribeToTopic(AuthController.instance.account!.id!)
        .then((_) {
      debugPrint(
          'Notification: Subscribed to topic: ${AuthController.instance.account!.id}');
    });
  }

  Future<void> unregisterNotification() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic('all').then((_) {
      debugPrint('Notification: Unsubscribed from topic: all');
    });
    await FirebaseMessaging.instance
        .unsubscribeFromTopic(AuthController.instance.account!.id!)
        .then((_) {
      debugPrint(
          'Notification: Unsubscribed from topic: ${AuthController.instance.account!.id}');
    });
  }
}
