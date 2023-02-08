import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class MotionToastService {
  static Future<dynamic> showSuccess(String description,
      {Widget? title,
      AnimationType animationType = AnimationType.fromTop,
      MotionToastPosition motionToastPosition = MotionToastPosition.top,
      double height = 0.06,
      double width = 0.7,
      int seconds = 3,
      TextStyle? descriptionStyle}) async {
    BuildContext? context = Get.context;
    if (context != null) {
      MotionToast.success(
        toastDuration: Duration(seconds: seconds),
        title: title,
        description: Text(
          description,
          style: descriptionStyle ?? subtitle2.copyWith(color: AppColors.gray),
        ),
        animationType: animationType,
        position: motionToastPosition,
        height: Get.height * height,
        width: Get.width * width,
      ).show(context);
    }
  }

  static Future<dynamic> showError(String description,
      {Widget? title,
      AnimationType animationType = AnimationType.fromTop,
      MotionToastPosition motionToastPosition = MotionToastPosition.top,
      double height = 0.08,
      double width = 0.7,
      int seconds = 3,
      TextStyle? descriptionStyle}) async {
    BuildContext? context = Get.context;
    if (context != null) {
      MotionToast.error(
        toastDuration: Duration(seconds: seconds),
        title: title,
        description: Text(
          description.isEmpty ? 'Lỗi không xác định' : description,
          style: descriptionStyle ?? subtitle2,
        ),
        animationType: animationType,
        position: motionToastPosition,
        height: Get.height * height,
        width: Get.width * width,
      ).show(context);
    }
  }

  static Future<dynamic> showInfo(String description,
      {Widget? title,
      AnimationType animationType = AnimationType.fromTop,
      MotionToastPosition motionToastPosition = MotionToastPosition.top,
      double height = 0.06,
      double width = 0.7,
      TextStyle? descriptionStyle}) async {
    BuildContext? context = Get.context;
    if (context != null) {
      MotionToast.info(
        title: title,
        description: Text(
          description,
          style: descriptionStyle ?? subtitle2.copyWith(color: Colors.black12),
        ),
        animationType: animationType,
        position: motionToastPosition,
        height: Get.height * height,
        width: Get.width * width,
      ).show(context);
    }
  }

  static Future<dynamic> showWarning(String description,
      {Widget? title,
      AnimationType animationType = AnimationType.fromTop,
      MotionToastPosition motionToastPosition = MotionToastPosition.top,
      double height = 0.08,
      double width = 0.7,
      TextStyle? descriptionStyle}) async {
    BuildContext? context = Get.context;
    if (context != null) {
      MotionToast.warning(
        title: Text(
          'Cảnh báo!!',
          style: subtitle2,
        ),
        description: Text(
          description,
        ),
        animationType: animationType,
        position: motionToastPosition,
        height: Get.height * height,
        width: Get.width * width,
      ).show(context);
    }
  }
}
