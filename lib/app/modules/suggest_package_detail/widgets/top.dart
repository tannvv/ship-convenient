import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/controllers/suggest_package_detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Top extends GetWidget<SuggestPackageDetailController> {
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
          children: [
            ElevatedButton(
              onPressed: () async {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: AppColors.white,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: const EdgeInsets.all(0),
                minimumSize: Size(40.r, 40.r),
              ),
              child: SizedBox(
                height: 40.r,
                width: 40.r,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18.r,
                  color: AppColors.primary400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
