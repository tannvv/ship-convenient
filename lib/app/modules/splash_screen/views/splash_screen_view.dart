import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen.withScreenRouteFunction(
      duration: 4000,
      splash: Container(
        width: Get.width * 0.4,
        height: Get.height * 0.6,
        decoration: BoxDecoration(
            image: DecorationImage(image: Image.asset(AppAssets.splash).image)),
      ),
      splashIconSize: Get.height * 0.5,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.scale,
      screenRouteFunction: controller.screenRouteFunction,
    ));
  }
}
