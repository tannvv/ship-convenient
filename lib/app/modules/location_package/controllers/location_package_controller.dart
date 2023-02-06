import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/map_location_controller.dart';
import 'package:convenient_way/app/core/services/animated_map_controller.dart';
import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationPackageController extends BaseController {
  late MapController _mapController;
  late AnimatedMapService _animatedMapService;
  final MapLocationController _mapLocationController =
      Get.find<MapLocationController>();

  void onMapCreated(MapController controller) {
    _mapController = controller;
    _animatedMapService = AnimatedMapService(controller: controller);
    gotoCurrentLocation();
  }

  void gotoCurrentLocation() {
    LatLng currentLocation = _mapLocationController.location!;
    _animatedMapService.move(currentLocation, AppValues.focusZoomLevel);
  }
}
