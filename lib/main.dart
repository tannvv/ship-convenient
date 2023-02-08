import 'package:convenient_way/app/app.dart';
import 'package:convenient_way/app/core/controllers/notification_controller.dart';
import 'package:convenient_way/config/build_config.dart';
import 'package:convenient_way/config/env_config.dart';
import 'package:convenient_way/config/environment.dart';
import 'package:convenient_way/config/firebase_options.dart';
import 'package:convenient_way/config/map_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'dart:async';

Future<void> main() async {
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('SignalR: ${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: '.env');

  EnvConfig envConfig = EnvConfig(
      baseUrl: dotenv.get('BASE_URL_API'),
      baseUrlOrigin: dotenv.get('BASE_URL'));

  MapConfig mapConfig = MapConfig(
      mapboxUrlTemplate: dotenv.get('MAPBOX_URL_TEMPLATE'),
      mapboxAccessToken: dotenv.get('MAPBOX_ACCESS_TOKEN'),
      mapboxId: dotenv.get('MAPBOX_ID'));

  BuildConfig.instantiate(
      envType: Environment.DEVELOPMENT,
      envConfig: envConfig,
      mapConfig: mapConfig);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await NotificationController.instance.init();
  Intl.defaultLocale = 'vi_VN';
  initializeDateFormatting();
  FirebaseMessaging.onBackgroundMessage(
      NotificationController.firebaseMessagingBackgroundHandler);
  runApp(const App());
}
