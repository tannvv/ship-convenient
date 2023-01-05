import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/alert_cool_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/constants/role_name.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/request_model/create_account_model.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RegisterController extends BaseController {
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isLoadingVerify = false.obs;

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());

  String _userName = '';
  String _password = '';
  String _firstName = '';
  String _lastName = '';
  String _phone = '';
  final String _photoUrl =
      'https://cdn-icons-png.flaticon.com/512/147/147144.png';
  final String _status = 'ACTIVE';
  String _address = '';
  var _gender = 'OTHER'.obs;
  String _email = '';
  Rx<bool> isConfirmPhone = false.obs;
  Rx<LatLng?> homeLocation = Rx<LatLng?>(null);
  Rx<LatLng?> destinationLocation = Rx<LatLng?>(null);

  String? get password => _password;
  String? get gender => _gender.value;
  set setUserName(String value) {
    _userName = value;
  }

  set setPassword(String value) {
    _password = value;
  }

  set setFirstName(String value) {
    _firstName = value;
  }

  set setLastName(String value) {
    _lastName = value;
  }

  set setPhone(String value) {
    _phone = value;
  }

  set setAddress(String value) {
    _address = value;
  }

  set setGender(String value) {
    _gender.value = value;
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

  Future<void> registerAccount() async {
    if (!isConfirmPhone.value) {
      ToastService.showError('Bạn chưa xác thực sđt');
      return;
    }

    CreateAccountModel createAccountModel = CreateAccountModel(
        userName: _userName,
        password: _password,
        email: _email,
        firstName: _firstName,
        lastName: _lastName,
        phone: _phone,
        photoUrl: _photoUrl,
        role: RoleName.user,
        gender: _gender.value);
    isLoading.value = true;
    _accountRepo.create(createAccountModel).then((response) async {
      isLoading.value = false;
      await CoolAlertService.showSuccess('Đăng kí thành công');
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
    debugPrint('Phone number: 0$_phone');
    _phone = '+84$_phone';
    isLoadingVerify.value = true;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phone,
      timeout: const Duration(seconds: 20),
      verificationCompleted: (PhoneAuthCredential credential) {
        debugPrint('Auth Completed! \nCredential: $credential');
        isLoadingVerify.value = false;
      },
      verificationFailed: (FirebaseAuthException e) {
        CoolAlertService.showError('Request OTP failed!');
        isLoadingVerify.value = false;
      },
      codeSent: (String verificationId, int? resendToken) async {
        debugPrint(
            'Đã gửi mã OTP \nResendToken: $resendToken, VerificationId: $verificationId');
        var result = await Get.toNamed(Routes.VERIFY_OTP,
            arguments: [verificationId, resendToken, _phone]);
        isLoadingVerify.value = false;
        if (result == true) isConfirmPhone.value = true;
        await CoolAlertService.showSuccess('Xác thực thành công!');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // CoolAlertService.showError('Timeout to sent OTP!!');
        isLoadingVerify.value = false;
      },
    );
  }
}
