import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/repository/request_model/register_shipper_model.dart';
import 'package:convenient_way/app/data/repository/shipper_req.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isLoadingVerify = false.obs;

  final ShipperRep _shipperRepo = Get.find(tag: (ShipperRep).toString());

  String _userName = '';
  String _password = '';
  String _displayName = '';
  String _phoneNumber = '';
  final String _photoUrl =
      'https://cdn-icons-png.flaticon.com/512/147/147144.png';
  final String _status = 'ACTIVE';
  String _address = '';
  String _gender = 'OTHER';
  String _email = '';
  Rx<bool> isConfirmPhone = false.obs;
  Rx<LatLng?> homeLocation = Rx<LatLng?>(null);
  Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);

  String? get password => _password;
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

  set setEmail(String value) {
    _email = value;
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
    if (!isConfirmPhone.value) {
      ToastService.showError('Bạn chưa xác thực sđt');
      return;
    }

    isLoading.value = true;
    RegisterShipper registerModel = RegisterShipper(
        userName: _userName,
        password: _password,
        email: _email,
        displayName: _displayName,
        phoneNumber: _phoneNumber,
        photoUrl: _photoUrl,
        gender: _gender);
    _shipperRepo.register(registerModel).then((response) {
      ToastService.showSuccess('Đăng kí thành công');
      Get.offAllNamed(Routes.LOGIN);
    }).catchError((error) {
      ToastService.showError(error.message ?? 'Đăng kí không thành công');
    });
    isLoading.value = false;
  }

  Future<void> gotoSignIn() async {
    await Get.offAndToNamed(Routes.LOGIN);
  }

  void back() {
    Get.back();
  }

  Future<void> verifyPhone() async {
    debugPrint('Phone number: 0$_phoneNumber');
    _phoneNumber = '+84$_phoneNumber';
    isLoadingVerify.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      timeout: const Duration(seconds: 20),
      verificationCompleted: (PhoneAuthCredential credential) {
        ToastService.showSuccess("Auth Completed!");
        isLoadingVerify.value = false;
      },
      verificationFailed: (FirebaseAuthException e) {
        ToastService.showError("Request OTP failed!");
        isLoadingVerify.value = false;
      },
      codeSent: (String verificationId, int? resendToken) async {
        ToastService.showSuccess("OTP sent!");
        var result = await Get.toNamed(Routes.VERIFY_OTP,
            arguments: [verificationId, resendToken, _phoneNumber]);
        isLoadingVerify.value = false;
        if (result == true) isConfirmPhone.value = true;
        ToastService.showSuccess('result:  $result');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ToastService.showError("Timeout!");
        isLoadingVerify.value = false;
      },
    );
  }
}
