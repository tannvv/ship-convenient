import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/controllers/map_location_controller.dart';
import 'package:convenient_way/app/core/services/animated_map_controller.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class LocationPackageController extends BaseController {
  MapController? _mapController;
  late AnimatedMapService _animatedMapService;
  final MapLocationController _mapLocationController =
      Get.find<MapLocationController>();
  final RxList<Package> packages = <Package>[].obs;
  LatLngBounds currentBounds = LatLngBounds();

  final PackageReq _packageReq = Get.find(tag: (PackageReq).toString());

  @override
  void onInit() {
    fetchPackages();
    super.onInit();
  }

  void onMapCreated(MapController controller) {
    _mapController = controller;
    _animatedMapService = AnimatedMapService(controller: controller);
    if (packages.isNotEmpty) {
      gotoCurrentBound();
    } else {
      gotoCurrentLocation();
    }
  }

  void gotoCurrentLocation() {
    LatLng currentLocation = _mapLocationController.location!;
    _animatedMapService.move(currentLocation, AppValues.focusZoomLevel);
  }

  Future<void> fetchPackages() async {
    String deliverId = AuthController.instance.account!.id!;
    PackageListModel model = PackageListModel(
      deliverId: deliverId,
      status:
          '${PackageStatus.DELIVER_PICKUP},${PackageStatus.DELIVERY},${PackageStatus.DELIVERY_FAILED}',
    );
    var future = _packageReq.getList(model);
    await callDataService<List<Package>>(
      future,
      onSuccess: (response) async {
        packages(response);
        await createBounds();
      },
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> createBounds() async {
    await _mapLocationController.loadLocation();
    LatLng currentPosition = _mapLocationController.location!;
    currentBounds.extend(currentPosition);

    for (var package in packages) {
      if (package.status == PackageStatus.DELIVER_PICKUP) {
        LatLng packagePosition = LatLng(
          package.startLatitude!,
          package.startLongitude!,
        );
        currentBounds.extend(packagePosition);
      } else if (package.status == PackageStatus.DELIVERY) {
        LatLng packagePosition = LatLng(
          package.destinationLatitude!,
          package.destinationLongitude!,
        );
        currentBounds.extend(packagePosition);
      } else if (package.status == PackageStatus.DELIVERY_FAILED) {
        LatLng packagePosition = LatLng(
          package.startLatitude!,
          package.startLongitude!,
        );
        currentBounds.extend(packagePosition);
      }
    }
    currentBounds.pad(0.2);
  }

  LatLng getLatLngWithStatus(Package package) {
    if (package.status == PackageStatus.DELIVER_PICKUP) {
      return LatLng(package.startLatitude!, package.startLongitude!);
    } else if (package.status == PackageStatus.DELIVERY) {
      return LatLng(
          package.destinationLatitude!, package.destinationLongitude!);
    } else if (package.status == PackageStatus.DELIVERY_FAILED) {
      return LatLng(package.startLatitude!, package.startLongitude!);
    }
    return LatLng(package.startLatitude!, package.startLongitude!);
  }

  String getAssetsWithStatus(Package package) {
    if (package.status == PackageStatus.DELIVER_PICKUP) {
      return AppAssets.locationIcon;
    } else if (package.status == PackageStatus.DELIVERY) {
      return AppAssets.locationGreenIcon;
    } else if (package.status == PackageStatus.DELIVERY_FAILED) {
      return AppAssets.locationBlueIcon2;
    }
    return 'assets/images/pickup.png';
  }

  void gotoCurrentBound() {
    _animatedMapService.move(currentBounds.center, AppValues.overviewZoomLevel);
  }
}
