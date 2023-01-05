import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class QuickAlertService {
  static Future<dynamic> showSuccess(String text) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.confirm,
        text: 'Thành Công!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        showCancelBtn: false,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showWarning(String text) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Cảnh báo!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        showCancelBtn: false,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showError(String text) async{
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Lỗi!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        showCancelBtn: false,
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        //barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showInfo(String text) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Thông tin!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        showCancelBtn: false,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        //barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showConfirm(String text) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Xác nhận!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        showCancelBtn: false,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        //barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showLoading(String text) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Đang tải...!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        showCancelBtn: false,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        //barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showAlert(
    String text, {
    Function()? onCancelBtnTap,
    Function()? onConfirmBtnTap,
  }) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.loading,
        text: 'Thông tin!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        showCancelBtn: false,
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        onCancelBtnTap: onCancelBtnTap,
        onConfirmBtnTap: onCancelBtnTap,
        confirmBtnTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        //barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
    }
  }
}
