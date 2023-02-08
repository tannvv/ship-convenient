import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/modules/manage_route/controllers/manage_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateRouteButton extends GetWidget<ManageRouteController> {
  const CreateRouteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 2.w),
      child: SizedBox(
        width: 160.w,
        child: ElevatedButton.icon(
          style: ButtonStyles.primaryMedium().copyWith(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(AppColors.white),
          ),
          onPressed: () {
            controller.createRouteToList();
          },
          icon: const Icon(
            Icons.add_box,
            color: AppColors.primary700,
          ),
          label: Text(
            'Tạo lộ trình',
            style: buttonBold.copyWith(color: AppColors.primary700),
          ),
        ),
      ),
    );
  }
}
