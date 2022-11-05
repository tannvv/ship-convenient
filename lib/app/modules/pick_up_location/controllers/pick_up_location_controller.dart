import 'dart:async';

import 'package:convenient_way/app/core/controllers/map_location_controller.dart';
import 'package:convenient_way/app/core/controllers/map_stream_location.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class PickUpLocationController extends GetxController
    with GetTickerProviderStateMixin {
  final MapLocationController _mapLocationController = MapLocationController();
  MapController _mapController = MapController();
  late Rx<LatLng> centerLocation = Rx<LatLng>(LatLng(10, 100));

  late StreamSubscription<MapEvent> subscription;

  get mapController => _mapController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  void onMapCreated(MapController controller) {
    _mapController = controller;
    _mapController.onReady.then((_) async {
      bool isAcceptLocation = await _mapLocationController.loadLocation();
      if (isAcceptLocation) {
        Position position = await Geolocator.getCurrentPosition();
        centerLocation.value = LatLng(position.latitude, position.longitude);
        _animatedMapMove(centerLocation.value, 12);
      }
      subscription = controller.mapEventStream.listen((MapEvent mapEvent) {
        if (mapEvent is MapEventMove) {
          centerLocation.value =
              LatLng(mapEvent.center.latitude, mapEvent.center.longitude);
        }
      });
    });
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

  void back() {
    Get.back(result: centerLocation.value);
  }
}
