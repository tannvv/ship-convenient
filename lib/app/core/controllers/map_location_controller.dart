import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/controllers/map_stream_location.dart';
import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapLocationController extends GetxController {
  LatLng? location;
  LocationPermission? permission;
  bool isUsedCurrentLocation = true;
  MapStreamLocation? _mapStreamLocation;

  @override
  void onInit() {
    super.onInit();
    loadLocation();
  }

  Future<bool> loadLocation() async {
    try {
      location = await _getCurrentLocation();
      if (isUsedCurrentLocation) {
        initPositionStream(onPositionChanged: (position) {});
      }
      return true;
    } catch (e) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          await _deniedDialog();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        await _deniedForeverDialog();
      }

      return Future.error('Unknown error');
    }
  }

  Future<bool> getPermission() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) return true;

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await _deniedDialog();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await _deniedForeverDialog();
    }

    return false;
  }

  Future<LatLng> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      LatLng result = LatLng(position.latitude, position.longitude);
      debugPrint('Location: ${result.latitude}, ${result.longitude}');
      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> _deniedDialog() async {
    await HyperDialog.show(
      barrierDismissible: false,
      title: 'Thông báo',
      content:
          'Vui lòng bật quyền truy cập vị trí của bạn để tiếp tục sử dụng dịch vụ',
      primaryButtonText: 'Bật định vị',
      secondaryButtonText: 'Trở về trang chủ',
      primaryOnPressed: () async {
        try {
          permission = await Geolocator.requestPermission();
          var result = await Geolocator.getCurrentPosition();
          Get.back();
          return result;
        } catch (e) {
          // return Future.error(e);
          setDefaultLocation();
        }
      },
      secondaryOnPressed: () {
        if (AuthController.instance.account != null) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      },
    );
  }

  Future<void> _deniedForeverDialog() async {
    await HyperDialog.show(
      barrierDismissible: false,
      title: 'Thông báo',
      content:
          'Bạn đã từ chối cho ứng dụng sử dụng vị trí của bạn. Vui lòng bật lại trong cài đặt.',
      primaryButtonText: 'Mở cài đặt',
      secondaryButtonText: 'Trở về trang chủ',
      primaryOnPressed: () async {
        await Geolocator.openAppSettings();
        try {
          var result = await Geolocator.getCurrentPosition();
          Get.back();
          return result;
        } catch (e) {
          return Future.error(e);
        }
      },
      secondaryOnPressed: () {
        if (AuthController.instance.account != null) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      },
    );
  }

  void setDefaultLocation() {
    location = LatLng(10.808419535302706, 106.66612575654806);
    isUsedCurrentLocation = false;
    debugPrint(
        'Location default: ${location?.latitude}, ${location?.longitude}');
  }

  void initPositionStream({required Function(Position?) onPositionChanged}) {
    _mapStreamLocation =
        MapStreamLocation(onPositionChanged: onPositionChanged, isPause: false);
  }

  void pausePositionStream() {
    _mapStreamLocation?.pausePositionStream();
  }

  void resumePositionStream() {
    _mapStreamLocation?.resumePositionStream();
  }

  void closePositionStream() {
    _mapStreamLocation?.close();
  }
}
