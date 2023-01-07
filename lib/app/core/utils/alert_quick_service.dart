import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class QuickAlertService {
  static Future<dynamic> showSuccess(
    String text, {
    String title = 'Thành công',
    String confirmText = 'Đồng ý',
    int? duration,
  }) async {
    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Get.back();
      });
    }
    BuildContext? buildContext = Get.context;
    if (buildContext != null) {
      return await QuickAlert.show(
          context: buildContext,
          title: title,
          type: QuickAlertType.success,
          text: text,
          confirmBtnText: confirmText,
          onConfirmBtnTap: () {
            if (timer != null && timer.isActive) {
              timer.cancel();
            }
            Get.back();
          });
    }
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  static Future<dynamic> showWarning(
    String text, {
    String title = 'Cảnh báo!',
    String confirmText = 'Đồng ý',
    int? duration,
  }) async {
    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Get.back();
      });
    }
    BuildContext? buildContext = Get.context;
    if (buildContext != null) {
      return await QuickAlert.show(
          context: buildContext,
          title: title,
          type: QuickAlertType.warning,
          text: text,
          confirmBtnText: confirmText,
          onConfirmBtnTap: () {
            if (timer != null && timer.isActive) {
              timer.cancel();
            }
            Get.back();
          });
    }
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  static Future<dynamic> showError(
    String text, {
    String title = 'Lỗi!',
    String confirmText = 'Đồng ý',
    int? duration,
  }) async {
    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Get.back();
      });
    }
    BuildContext? buildContext = Get.context;
    if (buildContext != null) {
      return await QuickAlert.show(
          context: buildContext,
          title: title,
          type: QuickAlertType.error,
          text: text,
          confirmBtnText: confirmText,
          onConfirmBtnTap: () {
            if (timer != null && timer.isActive) {
              timer.cancel();
            }
            Get.back();
          });
    }
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  static Future<dynamic> showInfo(
    String text, {
    String title = 'Thông báo!',
    String confirmText = 'Đồng ý',
    int? duration,
  }) async {
    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Get.back();
      });
    }
    BuildContext? buildContext = Get.context;
    if (buildContext != null) {
      return await QuickAlert.show(
          context: buildContext,
          title: title,
          type: QuickAlertType.info,
          text: text,
          confirmBtnText: confirmText,
          onConfirmBtnTap: () {
            if (timer != null && timer.isActive) {
              timer.cancel();
            }
            Get.back();
          });
    }
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  static Future<dynamic> showConfirm(
    String text, {
    String title = 'Xác nhận',
    String confirmText = 'Đồng ý',
    int? duration,
  }) async {
    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Get.back();
      });
    }
    BuildContext? buildContext = Get.context;
    if (buildContext != null) {
      return await QuickAlert.show(
          context: buildContext,
          title: title,
          type: QuickAlertType.confirm,
          text: text,
          confirmBtnText: confirmText,
          onConfirmBtnTap: () {
            if (timer != null && timer.isActive) {
              timer.cancel();
            }
            Get.back();
          });
    }
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  static Future<dynamic> showLoading(
    String text, {
    String title = 'Đang tải',
    String confirmText = 'Đồng ý',
    int? duration,
  }) async {
    Timer? timer;
    if (duration != null) {
      timer = Timer(Duration(seconds: duration), () {
        Get.back();
      });
    }
    BuildContext? buildContext = Get.context;
    if (buildContext != null) {
      return await QuickAlert.show(
          context: buildContext,
          title: title,
          type: QuickAlertType.loading,
          text: text,
          confirmBtnText: confirmText,
          onConfirmBtnTap: () {
            if (timer != null && timer.isActive) {
              timer.cancel();
            }
            Get.back();
          });
    }
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }
}
