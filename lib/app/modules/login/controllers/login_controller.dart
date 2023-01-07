import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/map_location_controller.dart';
import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  String userName = '';
  String password = '';
  RxBool isLoading = false.obs;

  late MapLocationController mapLocationController;

  set setUserName(String value) {
    userName = value;
  }

  set setPassword(String value) {
    password = value;
  }

  @override
  void onInit() {
    super.onInit();
    mapLocationController = Get.find<MapLocationController>();
  }

  Future<void> showDataDialog() async {
    await HyperDialog.show(
      barrierDismissible: false,
      title: 'Thông báo',
      content: 'User name: $userName, Password: $password',
      primaryButtonText: 'Bật định vị',
      secondaryButtonText: 'Trở về trang chủ',
      primaryOnPressed: () async {
        Get.back();
      },
    );
  }

  void back() {
    Get.back();
  }

  Future<void> gotoSignUp() async {
    await Get.offAndToNamed(Routes.REGISTER);
  }

  void login() async {
    // isLoading.value = true;
    // await AuthService.login(userName, password);
    // isLoading.value = false;
  }
}
