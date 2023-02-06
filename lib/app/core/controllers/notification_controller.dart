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

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    debugPrint(
        'Notification: Background message received, Title: ${message.notification?.title}, Body: ${message.notification?.body}');
    showNotification(
        title: message.notification?.title, body: message.notification?.body);
  }

  static Future<void> showNotification(
      {String? title, String? body, String? payload}) async {
    showBigTextNotification(
        fln: flutterLocalNotificationsPlugin,
        title: title,
        body: body,
        payload: payload);
  }

  static Future<void> showBigTextNotification(
      {var id = 0,
      String? title,
      String? body,
      String? payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel_id 1', // id
      'Convenient way for delivering application', // title
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    var notify = NotificationDetails(android: androidPlatformChannelSpecifics);

    await fln.show(id, title, body, notify, payload: payload);
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
