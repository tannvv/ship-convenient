import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestPackageItem extends StatelessWidget {
  const SuggestPackageItem({Key? key, required this.suggestPackage})
      : super(key: key);
  final SuggestPackage suggestPackage;
  @override
  Widget build(BuildContext context) {
    int countPackage = suggestPackage.packages?.length ?? 0;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.softGray,
          borderRadius: BorderRadius.circular(12.w),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 2, spreadRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tên người gửi: ${suggestPackage.sender?.infoUser?.firstName}',
            style: subtitle2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Số gói hàng trong combo: $countPackage',
                style: subtitle2,
              ),
              Text(
                '${suggestPackage.compoPrice?.toInt()}vnđ',
                style: subtitle1.copyWith(
                    color: AppColors.softRed, fontWeight: FontWeights.medium),
              )
            ],
          ),
        ],
      ),
    );
  }
}
