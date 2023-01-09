import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  Future<String> screenRouteFunction() async {
    await Future.delayed(const Duration(seconds: 3));
    return '/login';
  }
}
