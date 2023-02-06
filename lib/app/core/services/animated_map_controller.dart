import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:latlong2/latlong.dart';

class AnimatedMapService extends GetxController
    with GetTickerProviderStateMixin {
  AnimatedMapService({required this.controller});

  late MapController controller;

  move(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: controller.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: controller.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: controller.zoom, end: destZoom);

    var animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    Animation<double> animation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    animationController.addListener(() {
      try {
        controller.move(
            LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
            zoomTween.evaluate(animation));
      } catch (e) {
        animationController.dispose();
        return;
      }
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animationController.dispose();
      }
    });

    animationController.forward();
  }
}
