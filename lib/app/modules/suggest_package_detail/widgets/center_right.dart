import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/controllers/suggest_package_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CenterRight extends GetWidget<SuggestPackageDetailController> {
  const CenterRight({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(bottom: AppValues.bottomAppBarHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _goToCurrentLocation(),
        ],
      ),
    );
  }

  Container _goToCurrentLocation() {
    return Container(
      padding: EdgeInsets.only(top: 80.w, right: 20.w, left: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              controller.gotoCurrentBound();
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
                Icons.gps_fixed,
                size: 18.r,
                color: AppColors.primary400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
