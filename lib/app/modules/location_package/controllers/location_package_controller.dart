import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/map_location_controller.dart';
import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationPackageController extends BaseController
    with GetTickerProviderStateMixin {
  late MapController _mapController;
  final MapLocationController _mapLocationController =
      Get.find<MapLocationController>();

  void onMapCreated(MapController controller) {
    _mapController = controller;
    LatLng currentLocation = _mapLocationController.location!;
    _animatedMapMove(currentLocation, AppValues.focusZoomLevel);
  }

  void gotoCurrentLocation() {
    LatLng currentLocation = _mapLocationController.location!;
    _animatedMapMove(currentLocation, AppValues.focusZoomLevel);
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    controller.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });
    controller.forward();
  }
}
