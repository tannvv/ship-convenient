import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/route_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class SuggestPackageDetailController extends GetxController {
  final suggestPackage = Get.arguments as SuggestPackage;
  final suggest = Rx<SuggestPackage?>(null);
  LatLngBounds coordBound = LatLngBounds();
  List<LatLng> coordPackage = [];
  List<LatLng> coordAccount = [];
  List<String> packageIds = [];
  late LatLng coordShop;
  final count = 0.obs;
  int maxSelectedPackages = 3;

  RxList<String> selectedPackages = <String>[].obs;
  MapController? _mapController;
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
    _mapController?.onReady.then((_) {
      _mapController?.move(coordBound.center, 12);
    });
  }

  void createBounds() {
    if (AuthService.instance.account != null) {
      Account account = AuthService.instance.account!;
      RouteAcc activeRoute = account.infoUser!.routes!
          .where((element) => element.isActive == true)
          .first;
      LatLng accountHome =
          LatLng(activeRoute.fromLatitude!, activeRoute.fromLongitude!);
      LatLng accountDes =
          LatLng(activeRoute.toLatitude!, activeRoute.toLongitude!);
      coordAccount.addAll([accountHome, accountDes]);
      coordBound.extend(accountHome);
      coordBound.extend(accountDes);
      debugPrint(
          'Coordinates ship home: ${accountHome.latitude}, ${accountHome.longitude}');
      debugPrint(
          'Coordinates ship des: ${accountDes.latitude}, ${accountDes.longitude}');
    }
    RouteAcc routeSender = suggest.value!.sender!.infoUser!.routes!
        .where((element) => element.isActive == true)
        .first;
    coordShop = LatLng(routeSender.fromLatitude!, routeSender.fromLongitude!);
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
      ToastService.showError('Ch??a ch???n g??i h??ng n??o ????? pickup');
      return;
    }
    if (selectedPackages.length > maxSelectedPackages) {
      ToastService.showError(
          'S??? g??i h??ng t???i ??a c?? th??? ch???n l?? $maxSelectedPackages');
      return;
    }
    HyperDialog.show(
        title: 'X??c nh???n',
        content: 'B???n x??c nh???n ch???n nh???ng ????n h??ng n??y?',
        primaryButtonText: '?????ng ??',
        secondaryButtonText: 'H???y',
        primaryOnPressed: () {
          String accountId = AuthService.instance.account!.id!;
          AccountPickUpModel model = AccountPickUpModel(
              deliverId: accountId, packageIds: selectedPackages);
          _packageRepo.pickUpPackage(model).then((response) {
            ToastService.showSuccess(response.message!);
            Get.back(); // close dialog
            Get.back(result: true); // return suggest packages page
          }).catchError(((error) {
            ToastService.showError(error.message);
          }));
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
