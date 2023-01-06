import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController {
  final infoVerify = Get.arguments;

  String _otpField = '';
  String _verificationId = '';
  String _phone = '';
  int? _resendToken;
  set setOtpField(String value) {
    _otpField = value;
  }

  String get phone => _phone;

  @override
  void onInit() {
    _verificationId = infoVerify[0];
    _resendToken = infoVerify[1];
    _phone = infoVerify[2];
    super.onInit();
  }

  Future<void> verifyOTP(String value) async {
    await FirebaseAuth.instance
        .signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: value,
      ),
    )
        .then((value) async {
      await FirebaseAuth.instance.signOut();
      Get.back(result: true);
    }).catchError((error) {
      MotionToastService.showError('OTP không đúng, ${error.toString()}');
    });
  }

  Future<bool> resendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        MotionToastService.showSuccess("Auth Completed!");
      },
      verificationFailed: (FirebaseAuthException e) {
        MotionToastService.showError("Request OTP failed!");
      },
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
        MotionToastService.showSuccess('Đã gửi lại OTP');
      },
      timeout: const Duration(seconds: 25),
      forceResendingToken: _resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = _verificationId;
      },
    );
    debugPrint("_verificationId: $_verificationId");
    return true;
  }
}
