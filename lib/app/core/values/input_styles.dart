import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

abstract class InputStyles {
  static InputDecoration roundBorder(
      {Widget? prefixIcon, String labelText = "", String hintText = ""}) {
    return InputDecoration(
      errorStyle: caption,
      errorMaxLines: 2,
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      labelText: labelText,
      hintText: hintText,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: EdgeInsets.only(left: 11.w),
              child: prefixIcon,
            )
          : null,
      counterStyle: const TextStyle(
        height: double.minPositive,
      ),
      counterText: "",
    );
  }

  static InputDecoration boldBorder({
    String labelText = "",
    double radius = 12,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
        errorStyle: caption.copyWith(color: AppColors.softRed),
        errorMaxLines: 2,
        contentPadding: EdgeInsets.only(left: 20.sp, top: 26.sp),
        fillColor: AppColors.white,
        filled: true,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius.sp),
          borderSide: BorderSide(color: AppColors.error, width: 2.sp),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius.sp),
          borderSide: const BorderSide(
            color: AppColors.softGray,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius.sp),
          borderSide: const BorderSide(
            color: AppColors.softGray,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius.sp),
          borderSide: BorderSide(color: Colors.blue, width: 2.sp),
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: EdgeInsets.only(left: 11.w),
                child: prefixIcon,
              )
            : null,
        labelText: labelText,
        labelStyle: subtitle1.copyWith(color: AppColors.gray));
  }

  static InputDecoration softBorder({
    String labelText = "",
    String hintText = "",
    bool state = false,
    Function()? suffixAction,
  }) {
    return InputDecoration(
      errorStyle: caption,
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 15.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      labelText: labelText,
      hintText: hintText,
      suffixIcon: state
          ? TextButton(
              onPressed: suffixAction,
              child: const Icon(
                Icons.cancel,
                color: AppColors.softBlack,
              ),
            )
          : null,
      suffixText: 'VNĐ',
      floatingLabelStyle:
          MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        final Color color = states.contains(MaterialState.error)
            ? Get.theme.errorColor
            : AppColors.softBlack;
        return TextStyle(color: color);
      }),
    );
  }

  static InputDecoration mapSearch(
      {Widget? prefixIcon, String labelText = "", String hintText = ""}) {
    return InputDecoration(
      errorStyle: caption,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      labelText: labelText,
      hintText: hintText,
      labelStyle: subtitle1.copyWith(
        color: AppColors.description,
      ),
      hintStyle: subtitle1.copyWith(
        color: AppColors.description,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: prefixIcon,
            )
          : null,
    );
  }

  static InputDecoration mapSearchOutlined({
    Widget? prefixIcon,
    String labelText = "",
    String hintText = "",
    bool state = false,
    Function()? suffixAction,
  }) {
    return InputDecoration(
      errorStyle: caption,
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50.r),
      ),
      labelText: labelText,
      hintText: hintText,
      labelStyle: subtitle1.copyWith(
        color: AppColors.description,
      ),
      hintStyle: subtitle1.copyWith(
        color: AppColors.description,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: prefixIcon,
            )
          : null,
      suffixIcon: state
          ? TextButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(0),
                minimumSize: Size(40.r, 40.r),
              ),
              onPressed: suffixAction,
              child: const Icon(
                Icons.cancel_outlined,
                color: AppColors.softBlack,
              ),
            )
          : null,
    );
  }

  static InputDecoration map(
      {Widget? prefixIcon, String labelText = "", String hintText = ""}) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon != null
          ? Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: prefixIcon,
            )
          : null,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.blue,
          width: 2,
        ),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: subtitle1.copyWith(
        color: AppColors.description,
        fontWeight: FontWeights.medium,
      ),
      hintStyle: subtitle1.copyWith(
        color: AppColors.description,
      ),
    );
  }
}
