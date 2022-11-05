import 'dart:convert';

import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/shipper_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class SuggestPackageDetailController extends GetxController {
  final suggestPackage = Get.arguments as SuggestPackage;
  final suggest = Rx<SuggestPackage?>(null);
  LatLngBounds coordBound = LatLngBounds();
  List<LatLng> coordPackage = [];
  List<LatLng> coordShipper = [];
  late LatLng coordShop;
  final count = 0.obs;

  MapController? _mapController;

  MapController? get mapController => _mapController;
  @override
  void onInit() {
    suggest.value = suggestPackage;
    super.onInit();
  }

  void init() {
    suggest.value = suggestPackage;
    createBounds();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onMapCreated(MapController? mapController) {
    _mapController = mapController;
    _mapController?.onReady.then((_) {
      _mapController?.move(coordBound.center, 12);
    });
  }

  void createBounds() {
    if (AuthService.instance.shipper != null) {
      Shipper shipper = AuthService.instance.shipper!;
      LatLng shipperHome =
          LatLng(shipper.homeLatitude!, shipper.homeLongitude!);
      LatLng shipperDes =
          LatLng(shipper.destinationLatitude!, shipper.destinationLongitude!);
      coordShipper.addAll([shipperHome, shipperDes]);
      coordBound.extend(shipperHome);
      coordBound.extend(shipperDes);
    }
    coordShop =
        LatLng(suggest.value!.shop!.latitude!, suggest.value!.shop!.longitude!);
    coordBound.extend(coordShop);

    List<Package> packages = suggest.value!.packages!;
    packages.forEach((element) {
      LatLng pkCoord =
          LatLng(element.destinationLatitude!, element.destinationLongitude!);
      coordBound.extend(pkCoord);
      coordPackage.add(pkCoord);
    });
  }
}
