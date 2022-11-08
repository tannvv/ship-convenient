import 'dart:convert';

import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/shipper_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/package_req_imp.dart';
import 'package:convenient_way/app/data/repository/request_model/shipper_pickup_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way/app/data/repository/shipper_req.dart';
import 'package:flutter/cupertino.dart';
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

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  @override
  void onInit() {
    init();
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
      LatLng shipperHome = LatLng(10.773395476778918, 106.70155553056655);
      LatLng shipperDes = LatLng(10.840958994589215, 106.81004393023233);
      coordShipper.addAll([shipperHome, shipperDes]);
      coordBound.extend(shipperHome);
      coordBound.extend(shipperDes);
      debugPrint(
          'Coordinates ship home: ${shipperHome.latitude}, ${shipperHome.longitude}');
      debugPrint(
          'Coordinates ship des: ${shipperDes.latitude}, ${shipperDes.longitude}');
    }
    coordShop =
        LatLng(suggest.value!.shop!.latitude!, suggest.value!.shop!.longitude!);
    coordBound.extend(coordShop);
    debugPrint(
        'Coordinates shop: ${coordShop.latitude}, ${coordShop.longitude}');

    List<Package> packages = suggest.value!.packages!;
    packages.forEach((element) {
      LatLng pkCoord =
          LatLng(element.destinationLatitude!, element.destinationLongitude!);
      coordBound.extend(pkCoord);
      coordPackage.add(pkCoord);
      debugPrint(
          'Coordinates package: ${pkCoord.latitude}, ${pkCoord.longitude}');
    });

    debugPrint(
        'Center bound: ${coordBound.center.latitude}, ${coordBound.center.longitude}');
  }

  Future<void> pickUpPackages() async {
    String shipperId = AuthService.instance.shipper!.id!;
    List<String> packageIds =
        suggest.value!.packages!.map((e) => e.id!).toList();
    ShipperPickUpModel model =
        ShipperPickUpModel(shipperId: shipperId, packageIds: packageIds);
    _packageRepo.pickUpPackage(model).then((response) {
      ToastService.showSuccess(response.message!);
    }).catchError(((error) {
      ToastService.showError(error.message);
    }));
  }
}
