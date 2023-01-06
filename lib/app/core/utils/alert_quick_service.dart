import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class QuickAlertService {
  static Future<dynamic> showSuccess(
    String? text, {
    int seconds = 3,
    String title = 'Thành công!',
    bool isShowCancelBtn = false,
    bool isAutoClose = true,
    String confirmText = 'Đồng ý!',
    String cancelBtnText = 'Không!',
    Function()? onConfirmBtnTap,
    Function()? onCancelBtnTap,
  }) async {
    BuildContext? buildContext = Get.context;
    if (buildContext != null) {
      return await QuickAlert.show(
          autoCloseDuration: isAutoClose ? Duration(seconds: seconds) : null,
          context: buildContext,
          type: QuickAlertType.success,
          text: text,
          confirmBtnText: confirmText,
          cancelBtnText: cancelBtnText,
          barrierDismissible: true,
          barrierColor: Colors.black12,
          showCancelBtn: isShowCancelBtn,
          onConfirmBtnTap: onConfirmBtnTap ?? () {},
          onCancelBtnTap: onCancelBtnTap ?? () {});
    }
  }

  static Future<dynamic> showWarning(String text, {int time = 3}) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        autoCloseDuration: Duration(seconds: time),
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Cảnh báo!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
      );
    }
  }

  static Future<dynamic> showError(String text, {int time = 3}) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        autoCloseDuration: Duration(seconds: time),
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Lỗi!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        showCancelBtn: false,
      );
    }
  }

  static Future<dynamic> showInfo(String text, {int time = 3}) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        autoCloseDuration: Duration(seconds: time),
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Thông tin!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
      );
    }
  }

  static Future<dynamic> showConfirm(String text, {int time = 3}) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        autoCloseDuration: Duration(seconds: time),
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Xác nhận!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
      );
    }
  }

  static Future<dynamic> showLoading(String text, {int time = 3}) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        autoCloseDuration: Duration(seconds: time),
        context: buildContext!,
        type: QuickAlertType.warning,
        text: 'Đang tải...!',
        confirmBtnText: 'Đồng ý!',
        cancelBtnText: 'Không!',
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.black,
        showCancelBtn: false,
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
      );
    }
  }
}
