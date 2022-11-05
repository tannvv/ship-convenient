import 'package:convenient_way/app/core/controllers/map_stream_location.dart';
import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:convenient_way/app/modules/pick_up_location/bindings/pick_up_location_binding.dart';
import 'package:convenient_way/app/modules/pick_up_location/views/pick_up_location_view.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String _userName = '';
  String _password = '';
  String _displayName = '';
  String _phoneNumber = '';
  String _photoUrl = '';
  String _status = 'ACTIVE';
  String _address = '';
  String _gender = '';
  Rx<LatLng?> homeLocation = Rx<LatLng?>(null);
  Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);

  set setUserName(String value) {
    _userName = value;
  }

  set setPassword(String value) {
    _password = value;
  }

  set setDisplayName(String value) {
    _displayName = value;
  }

  set setPhoneNumber(String value) {
    _phoneNumber = value;
  }

  set setPhotoUrl(String value) {
    _phoneNumber = value;
  }

  set setAddress(String value) {
    _address = value;
  }

  set setGender(String value) {
    _gender = value;
  }

  Future<void> showMapPickUpHome() async {
    final data = await Get.toNamed(Routes.PICK_UP_LOCATION);
    homeLocation.value = LatLng(data.latitude, data.longitude);
  }

  Future<void> showMapPickUpDes() async {
    final data = await Get.toNamed(Routes.PICK_UP_LOCATION);
    destinationLocation.value = LatLng(data.latitude, data.longitude);
  }

  Future<void> registerShipper() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    isLoading.value = false;
  }

  Future<void> gotoSignIn() async {
    await Get.offAndToNamed(Routes.LOGIN);
  }

  void back() {
    Get.back();
  }
}
