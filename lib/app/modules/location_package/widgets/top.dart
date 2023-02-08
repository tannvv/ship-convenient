import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/modules/location_package/controllers/location_package_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Top extends GetWidget<LocationPackageController> {
  const Top({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: 10.h,
          left: 20.w,
          right: 10.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50.r),
                border:
                    Border.all(color: AppColors.primary400.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 0,
                    color: AppColors.black.withOpacity(0.2),
                  ),
                ],
              ),
              child: _active(),
            ),
          ],
        ),
      ),
    );
  }

  Row _active() {
    return Row(
      children: [
        Text(
          'Các gói hàng đang nhận',
          style: subtitle2.copyWith(color: AppColors.softBlack),
        ),
        SizedBox(
          width: 7.w,
        ),
        Container(
          height: 7.h,
          width: 7.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.primary400),
        ),
      ],
    );
  }

  Row _disable() {
    return Row(
      children: [
        Text(
          'Không hoạt động',
          style: subtitle2.copyWith(color: AppColors.description),
        ),
        SizedBox(
          width: 7.w,
        ),
        Container(
          height: 7.h,
          width: 7.h,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.description),
        ),
      ],
    );
  }
}
