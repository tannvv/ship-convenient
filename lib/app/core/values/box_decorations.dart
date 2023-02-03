import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class BoxDecorations {
  static BoxDecoration top() {
    return BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.r),
        topRight: Radius.circular(12.r),
      ),
      boxShadow: ShadowStyles.top,
    );
  }

  static BoxDecoration header() {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(5.r),
        bottomRight: Radius.circular(5.r),
      ),
      boxShadow: ShadowStyles.bottom,
    );
  }

  static BoxDecoration primary() {
    return BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 2, spreadRadius: 1)
        ]);
  }

  static BoxDecoration primaryWarning() {
    return BoxDecoration(
        color: AppColors.softGray,
        borderRadius: BorderRadius.circular(12.w),
        boxShadow: [
          BoxShadow(
              color: Colors.yellow.shade800, blurRadius: 2, spreadRadius: 1)
        ]);
  }

  static BoxDecoration service() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(9.r),
      boxShadow: ShadowStyles.service,
    );
  }

  static BoxDecoration map({Color? color}) {
    return BoxDecoration(
      color: color ?? AppColors.white,
      borderRadius: BorderRadius.circular(9.r),
      boxShadow: ShadowStyles.map,
    );
  }

  static BoxDecoration paymentChip() {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.caption,
        width: 1.r,
      ),
      borderRadius: BorderRadius.circular(8.r),
    );
  }

  static BoxDecoration mapLabel() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8.r),
      boxShadow: ShadowStyles.map,
    );
  }

  static BoxDecoration paymentRadio() {
    return BoxDecoration(
      color: AppColors.primary300.withOpacity(0.05),
      border: Border.all(
        color: AppColors.primary300,
        width: 1.r,
      ),
      borderRadius: BorderRadius.circular(8.r),
    );
  }
}
