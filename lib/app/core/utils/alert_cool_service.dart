import 'package:cool_alert/cool_alert.dart';
import 'package:get/get.dart';

class CoolAlertService {
  static Future<dynamic> showSuccess(String text,
      {String title = 'Thành công',
      String confirmText = 'Đồng ý!',
      int time = 3}) async {
    if (Get.context != null) {
      return await CoolAlert.show(
          context: Get.context!,
          type: CoolAlertType.success,
          text: text,
          confirmBtnText: confirmText,
          autoCloseDuration: Duration(seconds: time),
          title: title);
    }
  }

  static Future<dynamic> showWarning(String text,
      {String title = 'Cảnh báo',
      String confirmText = 'Đồng ý!',
      int time = 3}) async {
    if (Get.context != null) {
      return await CoolAlert.show(
          context: Get.context!,
          type: CoolAlertType.warning,
          text: text,
          confirmBtnText: confirmText,
          autoCloseDuration: Duration(seconds: time),
          title: title);
    }
  }

  static Future<dynamic> showError(String text,
      {String title = 'Lỗi',
      String confirmText = 'Đồng ý!',
      int time = 3}) async {
    if (Get.context != null) {
      return await CoolAlert.show(
          context: Get.context!,
          type: CoolAlertType.error,
          text: text,
          confirmBtnText: confirmText,
          autoCloseDuration: Duration(seconds: time),
          title: title);
    }
  }

  static Future<dynamic> showInfo(String text,
      {String title = 'Thông tin',
      String confirmText = 'Đồng ý!',
      int time = 3}) async {
    if (Get.context != null) {
      await CoolAlert.show(
          context: Get.context!,
          type: CoolAlertType.info,
          text: text,
          confirmBtnText: confirmText,
          autoCloseDuration: Duration(seconds: time),
          title: title);
    }
  }

  static Future<dynamic> showConfirm(String text,
      {String title = 'Xác nhận',
      String confirmText = 'Đồng ý!',
      int time = 3}) async {
    if (Get.context != null) {
      return await CoolAlert.show(
          context: Get.context!,
          type: CoolAlertType.confirm,
          text: text,
          confirmBtnText: confirmText,
          autoCloseDuration: Duration(seconds: time),
          title: title);
    }
  }

  static Future<dynamic> showLoading(String text,
      {String title = 'Đang tải',
      String confirmText = 'Đồng ý!',
      int time = 3}) async {
    if (Get.context != null) {
      await CoolAlert.show(
          context: Get.context!,
          type: CoolAlertType.loading,
          text: text,
          confirmBtnText: confirmText,
          autoCloseDuration: Duration(seconds: time),
          title: title);
    }
  }

  static Future<dynamic> showAlert(
    String text, {
    String title = 'Thông tin',
    String confirmText = 'Đồng ý!',
    CoolAlertType type = CoolAlertType.info,
    bool isShowBtnCancel = false,
    int time = 3,
    Function()? onCancelBtnTap,
    Function()? onConfirmBtnTap,
  }) async {
    if (Get.context != null) {
      return await CoolAlert.show(
          context: Get.context!,
          type: CoolAlertType.loading,
          text: text,
          confirmBtnText: confirmText,
          showCancelBtn: isShowBtnCancel,
          onCancelBtnTap: onCancelBtnTap,
          onConfirmBtnTap: onCancelBtnTap,
          autoCloseDuration: Duration(seconds: time),
          title: title);
    }
  }
}
