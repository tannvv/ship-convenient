import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/repository/request_model/register_route_model.dart';
import 'package:convenient_way/app/data/repository/shipper_req.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class CreateRouteController extends GetxController {
  final formKey = GlobalKey<FormState>();
  String _toAddress = '';
  final Rx<LatLng?> _toCoord = Rx<LatLng?>(null);
  String _fromAddress = '';
  final Rx<LatLng?> _fromCoord = Rx<LatLng?>(null);
  var isLoading = false.obs;

  final ShipperRep _shipperRepo = Get.find(tag: (ShipperRep).toString());

  set setToAddress(String value) {
    _toAddress = value;
  }

  set setFromAddress(String value) {
    _fromAddress = value;
  }

  LatLng? get fromCoord => _fromCoord.value;
  LatLng? get toCoord => _toCoord.value;

  Future<void> showMapPickUpFrom() async {
    final data = await Get.toNamed(Routes.PICK_UP_LOCATION);
    if (data != null) {
      _fromCoord.value = LatLng(data.latitude, data.longitude);
    }
  }

  Future<void> showMapPickUpTo() async {
    final data = await Get.toNamed(Routes.PICK_UP_LOCATION);
    if (data != null) {
      _toCoord.value = LatLng(data.latitude, data.longitude);
    }
  }

  void back() {
    Get.back();
  }




  Future<void> registerRoute() async {
    isLoading.value = true;
    String shipperId = AuthService.instance.shipper!.id!;
    if (_fromCoord.value == null || _toCoord.value == null) {
      ToastService.showError('Vui lòng chọn địa điểm của bạn trên bản đồ');
    }
    RegisterRoute registerRouteModel = RegisterRoute(
        fromAddress: _fromAddress,
        fromLongitude: _fromCoord.value!.longitude,
        fromLatitude: _fromCoord.value!.latitude,
        toAddress: _toAddress,
        toLongitude: _toCoord.value!.longitude,
        toLatitude: _toCoord.value!.latitude,
        shipperId: shipperId);

    _shipperRepo.registerRoute(registerRouteModel).then((shipper) {
      if (shipper != null) {
        AuthService.instance.setShipper = shipper;
        ToastService.showSuccess('Đăng kí thành công');
        Get.offAllNamed(Routes.HOME);
      } else {
        ToastService.showError('Lỗi không xác định');
      }
    }).catchError((error) {
      ToastService.showError(
          error.message ?? 'Đăng kí tuyến dường không thành công');
    });
    isLoading.value = false;
  }
}
