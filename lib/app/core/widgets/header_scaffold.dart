import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeaderScaffold extends StatelessWidget {
  const HeaderScaffold({super.key, required this.title, this.isBack = false});
  final String title;
  final bool isBack;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isBack ? _buildBackButton() : Container(),
        Container(
          padding: EdgeInsets.only(
            left: 18.w,
            top: 14.h,
            right: 18.w,
          ),
          child: Text(
            title,
            style: h6.copyWith(color: AppColors.softBlack),
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Container(
      padding: EdgeInsets.only(
        top: 10.h,
        left: 20.w,
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
              minimumSize: Size(34.r, 34.r),
            ),
            child: SizedBox(
              height: 30.r,
              width: 30.r,
              child: Icon(
                Icons.arrow_back_ios_new,
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
