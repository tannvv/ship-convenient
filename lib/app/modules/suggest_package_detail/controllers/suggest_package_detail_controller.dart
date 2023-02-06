import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/services/animated_map_controller.dart';
import 'package:convenient_way/app/core/utils/alert_quick_service.dart';
import 'package:convenient_way/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/route_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class SuggestPackageDetailController extends BaseController
    with GetTickerProviderStateMixin {
  final suggestPackage = Get.arguments as SuggestPackage;
  final suggest = Rx<SuggestPackage?>(null);
  LatLngBounds currentBounds = LatLngBounds();
  List<LatLng> routePoints = [];
  List<LatLng> coordPackage = [];
  List<LatLng> coordAccount = [];
  List<String> packageIds = [];
  late LatLng coordSender;
  final count = 0.obs;
  int maxSelectedPackages = 3;
  final double bottomHeight = 310.h;

  RxList<String> selectedPackages = <String>[].obs;
  MapController? _mapController;
  AnimatedMapService? _animatedMapService;
  final MultiSelectController<String> _multiSelectController =
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
    _animatedMapService = AnimatedMapService(controller: _mapController!);
    gotoCurrentBound();
  }

  void gotoCurrentBound() {
    if (_animatedMapService != null) {
      _animatedMapService?.move(
          currentBounds.center, AppValues.overviewZoomLevel);
    }
  }

  void createBounds() {
    if (AuthController.instance.account != null) {
      Account account = AuthController.instance.account!;
      RouteAcc activeRoute = account.infoUser!.routes!
          .where((element) => element.isActive == true)
          .first;
      LatLng accountHome =
          LatLng(activeRoute.fromLatitude!, activeRoute.fromLongitude!);
      LatLng accountDes =
          LatLng(activeRoute.toLatitude!, activeRoute.toLongitude!);
      coordAccount.addAll([accountHome, accountDes]);
      currentBounds.extend(accountHome);
      currentBounds.extend(accountDes);
      debugPrint(
          'Coordinates ship home: ${accountHome.latitude}, ${accountHome.longitude}');
      debugPrint(
          'Coordinates ship des: ${accountDes.latitude}, ${accountDes.longitude}');
    }
    List<Package> packages = suggest.value!.packages!;
    coordSender =
        LatLng(packages[0].startLatitude!, packages[0].startLongitude!);
    currentBounds.extend(coordSender);
    debugPrint(
        'Coordinates sender: ${coordSender.latitude}, ${coordSender.longitude}');
    for (var element in packages) {
      LatLng pkCoord =
          LatLng(element.destinationLatitude!, element.destinationLongitude!);
      currentBounds.extend(pkCoord);
      coordPackage.add(pkCoord);
      packageIds.add(element.id!);
      debugPrint(
          'Coordinates package: ${pkCoord.latitude}, ${pkCoord.longitude}');
    }

    debugPrint(
        'Center bound: ${currentBounds.center.latitude}, ${currentBounds.center.longitude}');
    centerZoomFitBounds();
  }

  void centerZoomFitBounds() {
    currentBounds.pad(0.4);
    LatLng? ne = currentBounds.northEast;
    LatLng? sw = currentBounds.southWest;
    final heightBuffer = (sw!.latitude - ne!.latitude).abs() * 0.8;
    sw = LatLng(sw.latitude - heightBuffer, sw.longitude);
    currentBounds.extend(sw);
  }

  Future<void> pickUpPackages() async {
    if (selectedPackages.isEmpty) {
      MotionToastService.showError(
        'Chưa chọn gói hàng nào để pickup',
      );
      return;
    }
    if (selectedPackages.length > maxSelectedPackages) {
      MotionToastService.showError(
          'Số gói hàng tối đa có thể chọn là $maxSelectedPackages');
      return;
    }
    await MaterialDialogService.showConfirmDialog(
        msg: 'Bạn xác nhận chọn những đơn hàng này?',
        onConfirmTap: () {
          String accountId = AuthController.instance.account!.id!;
          AccountPickUpModel model = AccountPickUpModel(
              deliverId: accountId, packageIds: selectedPackages);
          Future<SimpleResponseModel> future =
              _packageRepo.pickUpPackage(model);
          callDataService(
            future,
            onSuccess: (response) async {
              Get.back(); // close dialog
              await QuickAlertService.showSuccess('Chọn gói hàng thành công',
                  duration: 3);
              Get.back(result: true);
            },
            onError: (error) {
              if (error is BaseException) {
                QuickAlertService.showError(error.message);
              }
            },
          );
        });
  }

  void selectedAllPackages() {
    selectedPackages.value = [];
    for (var packageId in packageIds) {
      selectedPackages.add(packageId);
    }
    _multiSelectController.selectAll();
  }

  void clearAllPackages() {
    selectedPackages.value = [];
    _multiSelectController.deselectAll();
  }
}
