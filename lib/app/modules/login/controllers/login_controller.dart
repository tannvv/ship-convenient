import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/controllers/map_location_controller.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final formKey = GlobalKey<FormState>();
  String userName = '';
  String password = '';

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

  void back() {
    Get.back();
  }

  Future<void> gotoSignUp() async {
    await Get.offAndToNamed(Routes.REGISTER);
  }

  Future<void> login() async {
    isLoading = true;
    await AuthController.login(userName, password);
    isLoading = false;
  }
}
