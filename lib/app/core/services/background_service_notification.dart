import 'dart:async';
import 'dart:ui';

import 'package:convenient_way/app/data/constants/prefs_memory.dart';
import 'package:convenient_way/app/data/repository/request_model/send_notification_tracking_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/constants/notification_type.dart';

class BackgroundNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      debugPrint('Service is already running');
      return;
    }
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'convenient_way_background',
      'Foreground Service',
      importance: Importance.max,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: (_) {
          return false;
        },
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: true,
      ),
    );
    service.startService();
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    Timer.periodic(const Duration(seconds: 6), (timer) async {
      await sendNotificationTracking();
    });
    debugPrint('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    service.invoke('update', {
      'current_date': DateTime.now().toIso8601String(),
    });
  }

  static void stopService() async {
    final service = FlutterBackgroundService();
    if (await service.isRunning()) {
      service.invoke('stopService');
    }
  }

  static Future<bool> isRunning() async {
    final service = FlutterBackgroundService();
    return await service.isRunning();
  }

  static Future<void> sendNotificationTracking() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    debugPrint('Current position: ${position.latitude}, ${position.longitude}');
    String? userId = await getUserId();
    if (userId == null || userId.isEmpty) {
      debugPrint('Không có user id');
      return;
    } else {
      debugPrint('User id: $userId');
    }
    SendNotificationTrackingModel model = SendNotificationTrackingModel(
        deliverId: userId,
        title: TypeOfNotification.TRACKING,
        data: <String, String>{
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
          'deliverId': userId
        });
    try {
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        Response response = await Dio().post(
            'https://ship-convenient.azurewebsites.net/api/v1.0/notifications/send-tracking',
            data: model.toJson());
        debugPrint('Response: ${response.data}');
      } else {
        debugPrint('No internet connection');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  static Future<String?> getUserId() async {
    String? result;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(PrefsMemory.token);
    if (token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
      result = payload['id'];
    }
    return result;
  }
}
