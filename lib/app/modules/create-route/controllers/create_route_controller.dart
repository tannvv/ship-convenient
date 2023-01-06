import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/alert_quick_service.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/models/response_goong_model.dart';
import 'package:convenient_way/app/data/models/route_model.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/goong_req.dart';
import 'package:convenient_way/app/data/repository/request_model/create_route_model.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class CreateRouteController extends BaseController {
  final formKey = GlobalKey<FormState>();
  String _toName = '';
  final Rx<LatLng?> _toCoord = Rx<LatLng?>(null);
  String _fromName = '';
  final Rx<LatLng?> _fromCoord = Rx<LatLng?>(null);
  final TextEditingController homeController = TextEditingController();
  final TextEditingController workController = TextEditingController();
  var isLoading = false.obs;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());
  final GoongReq _goongRepo = Get.find(tag: (GoongReq).toString());

  set setToName(String value) => _toName = value;

  set setFromName(String value) => _fromName = value;
  set setToCoord(LatLng value) => _toCoord.value = value;
  set setFromCoord(LatLng value) => _fromCoord.value = value;

  LatLng? get fromCoord => _fromCoord.value;
  LatLng? get toCoord => _toCoord.value;

  Future<void> showMapPickUpFrom() async {
    final data =
        await Get.toNamed(Routes.PICK_UP_LOCATION, arguments: fromCoord);
    if (data != null) {
      _fromCoord.value = LatLng(data.latitude, data.longitude);
    }
  }

  Future<void> showMapPickUpTo() async {
    final data = await Get.toNamed(Routes.PICK_UP_LOCATION, arguments: toCoord);
    if (data != null) {
      _toCoord.value = LatLng(data.latitude, data.longitude);
    }
  }

  Future<List<ResponseGoong>> queryLocation(String query) async {
    return _goongRepo.getList(query);
  }

  void back() {
    Get.back();
  }

  Future<void> registerRoute() async {
    isLoading.value = true;
    String accountId = AuthService.instance.account!.id!;
    if (_fromCoord.value == null || _toCoord.value == null) {
      MotionToastService.showError(
          'Vui lòng chọn địa điểm của bạn trên bản đồ');
    }
    CreateRoute createRouteModel = CreateRoute(
        fromName: _fromName,
        fromLongitude: _fromCoord.value!.longitude,
        fromLatitude: _fromCoord.value!.latitude,
        toName: _toName,
        toLongitude: _toCoord.value!.longitude,
        toLatitude: _toCoord.value!.latitude,
        accountId: accountId);
    final future = _accountRepo.createRoute(createRouteModel);
    await callDataService<RouteAcc?>(future, onSuccess: (newRoute) async {
      if (newRoute != null) {
        AuthService.instance.account!.infoUser!.routes!.add(newRoute);
        await QuickAlertService.showSuccess(
            'Bạn đã đăng kí tuyến đường thành công');
        Get.offAllNamed(Routes.HOME);
      } else {
        MotionToastService.showError('Lỗi không xác định');
      }
    }, onError: (ex) {
      MotionToastService.showError('Đăng kí tuyến dường không thành công');
    }, onStart: () {
      isLoading.value = true;
    }, onComplete: () {
      isLoading.value = false;
    });
  }
}
