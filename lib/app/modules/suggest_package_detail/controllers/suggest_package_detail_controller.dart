import 'dart:convert';

import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/shipper_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/shipper_pickup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class SuggestPackageDetailController extends GetxController {
  final suggestPackage = Get.arguments as SuggestPackage;
  final suggest = Rx<SuggestPackage?>(null);
  LatLngBounds coordBound = LatLngBounds();
  List<LatLng> coordPackage = [];
  List<LatLng> coordShipper = [];
  List<String> packageIds = [];
  late LatLng coordShop;
  final count = 0.obs;
  int maxSelectedPackages = 3;

  RxList<String> selectedPackages = <String>[].obs;
  MapController? _mapController;
  MultiSelectController<String> _multiSelectController =
      MultiSelectController();

  MapController? get mapController => _mapController;
  MultiSelectController<String> get multiSelectController =>
      _multiSelectController;

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
    for (var element in packages) {
      LatLng pkCoord =
          LatLng(element.destinationLatitude!, element.destinationLongitude!);
      coordBound.extend(pkCoord);
      coordPackage.add(pkCoord);
      packageIds.add(element.id!);
      debugPrint(
          'Coordinates package: ${pkCoord.latitude}, ${pkCoord.longitude}');
    }

    debugPrint(
        'Center bound: ${coordBound.center.latitude}, ${coordBound.center.longitude}');
  }

  Future<void> pickUpPackages() async {
    if (selectedPackages.isEmpty) {
      ToastService.showError('Chưa chọn gói hàng nào để pickup');
      return;
    }
    if (selectedPackages.length > maxSelectedPackages) {
      ToastService.showError(
          'Số gói hàng tối đa có thể chọn là $maxSelectedPackages');
      return;
    }
    HyperDialog.show(
        title: 'Xác nhận',
        content: 'Bạn xác nhận chọn những đơn hàng này?',
        primaryButtonText: 'Đồng ý',
        secondaryButtonText: 'Hủy',
        primaryOnPressed: () {
          String shipperId = AuthService.instance.shipper!.id!;
          ShipperPickUpModel model = ShipperPickUpModel(
              shipperId: shipperId, packageIds: selectedPackages);
          _packageRepo.pickUpPackage(model).then((response) {
            ToastService.showSuccess(response.message!);
            Get.back(); // close dialog
            Get.back(); // return suggest packages page
          }).catchError(((error) {
            ToastService.showError(error.message);
          }));
        });
  }

  void selectedAllPackages() {
    selectedPackages.value = [];
    for (var packageId in packageIds) {
      selectedPackages.value.add(packageId);
    }
    _multiSelectController.selectAll();
  }

  void clearAllPackages() {
    selectedPackages.value = [];
    _multiSelectController.deselectAll();
  }
}
