import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ButtonStyles {
  static ButtonStyle primary() {
    return ElevatedButton.styleFrom(
      shadowColor: AppColors.primary400,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle primaryBlue() {
    return ElevatedButton.styleFrom(
      primary: AppColors.secondary600,
      shadowColor: Color.fromARGB(255, 84, 166, 253),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle primaryBlueMedium() {
    return ElevatedButton.styleFrom(
      primary: AppColors.secondary600,
      shadowColor: Color.fromARGB(255, 84, 166, 253),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle primaryBlueSmall() {
    return ElevatedButton.styleFrom(
      primary: Colors.blue[500],
      shadowColor: Colors.blue[200],
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle primaryMedium() {
    return ElevatedButton.styleFrom(
      shadowColor: AppColors.primary400,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle primarySmall() {
    return ElevatedButton.styleFrom(
      shadowColor: AppColors.primary400,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle secondary() {
    return TextButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.primary400,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(50.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle textCircle() {
    return TextButton.styleFrom(
      shape: const CircleBorder(),
      padding: EdgeInsets.all(18.r),
    );
  }

  static ButtonStyle fingerPrint() {
    return ElevatedButton.styleFrom(
      shadowColor: AppColors.primary400,
      shape: const CircleBorder(),
    );
  }

  static ButtonStyle paymentChip() {
    return ElevatedButton.styleFrom(
      shadowColor: AppColors.primary400,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.caption,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle paymentRadio() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 14.h,
      ),
      primary: AppColors.primary300.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: AppColors.primary400,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }

  static ButtonStyle paymentRadioNotSelected() {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 14.h,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      textStyle: button.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
