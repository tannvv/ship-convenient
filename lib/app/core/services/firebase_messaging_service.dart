import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  static FirebaseMessagingService get instance => _instance;
  FirebaseMessagingService._internal();

  static Future<String?> getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('Token firebase messaging: $fcmToken');
    return fcmToken;
  }
}
