import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class MaterialDialogService {
  static Future<void> showDeleteDialog({
    String msg = 'Bạn có chắc chắn muốn xóa?',
    String title = 'Xóa',
    String cancelText = 'Thoát',
    String confirmText = 'Đồng ý',
    required Function() onConfirmTap,
    IconData confirmIconData = Icons.delete,
    int? seconds,
  }) async {
    Timer? timer;
    if (seconds != null) {
      timer = Timer(Duration(seconds: seconds), () {
        Get.back();
      });
    }
    await Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: Get.context!,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Get.back();
            },
            text: cancelText,
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: onConfirmTap,
            text: confirmText,
            iconData: confirmIconData,
            color: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
    if (timer != null && timer.isActive) {
      timer.cancel();
    }
  }

  static Future<void> showConfirmDialog({
    String msg = 'Bạn xác nhận làm điều này?',
    String title = 'Xác nhận',
    String cancelText = 'Thoát',
    String confirmText = 'Đồng ý',
    required Function() onConfirmTap,
  }) async {
    await Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: Get.context!,
        actions: [
          IconsOutlineButton(
            onPressed: () {
              Get.back();
            },
            text: cancelText,
            iconData: Icons.cancel_outlined,
            textStyle: const TextStyle(color: Colors.grey),
            iconColor: Colors.grey,
          ),
          IconsButton(
            onPressed: onConfirmTap,
            text: confirmText,
            iconData: Icons.check,
            color: Colors.blue[500],
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  static Future<void> showCustomDialog({
    String msg = 'Bạn xác nhận làm điều này?',
    String title = 'Xác nhận',
    String cancelText = 'Thoát',
    String confirmText = 'Đồng ý',
    required List<Widget> actions,
    required Function() onConfirmTap,
  }) async {
    await Dialogs.materialDialog(
        msg: msg,
        title: title,
        color: Colors.white,
        context: Get.context!,
        actions: actions);
  }
}
