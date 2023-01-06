import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class QuickAlertService {
  static Future<dynamic> showSuccess(
    String text, {
      String content = 'Thành công!',
      String btntext = 'Đồng ý!',
    }
  ) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.success,
        text: content,
        confirmBtnText: btntext,
        //cancelBtnText: 'Không!',
        // confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        showCancelBtn: false,
        // confirmBtnTextStyle: const TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        // //barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showWarning(
    String text, {
      String content = 'Cảnh báo!',
      String btntext = 'Đồng ý!',
    }
  ) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.warning,
        text: content,
        confirmBtnText: btntext,
        //cancelBtnText: 'Không!',
        // confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        showCancelBtn: false,
        // confirmBtnTextStyle: const TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        // //barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showError(
    String text, {
      String content = 'Lỗi!',
      String btntext = 'Đồng ý!',
    }
  ) async{
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.error,
        text: content,
        confirmBtnText: btntext,
        //cancelBtnText: 'Không!',
        showCancelBtn: false,
        // confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        // confirmBtnTextStyle: const TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        // //barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showInfo(
    String text, {
      String content = 'Thông tin!',
      String btntext = 'Đồng ý!',
    }
  ) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.info,
        text: content,
        confirmBtnText: btntext,
        //cancelBtnText: 'Không!',
        // confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        showCancelBtn: false,
        // confirmBtnTextStyle: const TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        // //barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showConfirm(
    String text, {
      String content = 'Xác nhận!',
      String btnaccepttext = 'Đồng ý!',
      String btndenytext = 'Không!',
    }
  ) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.confirm,
        text: content,
        confirmBtnText: btnaccepttext,
        cancelBtnText: btndenytext,
        //confirmBtnColor: Colors.white,
        //backgroundColor: Colors.black,
        showCancelBtn: true,
        // confirmBtnTextStyle: const TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        //barrierColor: Colors.white,
        //titleColor: Colors.white,
        //textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showLoading(
    String text, {
      String content = 'Đang tải...!',
      String btntext = 'Đồng ý!',
    }
  ) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.loading,
        text: content,
        confirmBtnText: btntext,
        //cancelBtnText: 'Không!',
        // confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        showCancelBtn: false,
        // confirmBtnTextStyle: const TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        // //barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        );
    }
  }

  static Future<dynamic> showAlert(
    String text, {
    Function()? onCancelBtnTap,
    Function()? onConfirmBtnTap,
    String content = 'Alert!',
    String btntext = 'Đồng ý!',
  }) async {
    BuildContext? buildContext = Get.context;
    if (Get.context != null) {
      return await QuickAlert.show(
        context: buildContext!,
        type: QuickAlertType.values.first,
        text: content,
        confirmBtnText: btntext,
        //cancelBtnText: 'Không!',
        showCancelBtn: false,
        // confirmBtnColor: Colors.white,
        // backgroundColor: Colors.black,
        // onCancelBtnTap: onCancelBtnTap,
        // onConfirmBtnTap: onCancelBtnTap,
        // confirmBtnTextStyle: const TextStyle(
        //   color: Colors.black,
        //   fontWeight: FontWeight.bold,
        // ),
        // //barrierColor: Colors.white,
        // titleColor: Colors.white,
        // textColor: Colors.white,
        );
    }
  }
}
