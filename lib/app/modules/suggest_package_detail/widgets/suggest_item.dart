import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestItem extends StatelessWidget {
  const SuggestItem({Key? key, required this.isSelected, required this.package})
      : super(key: key);

  final bool isSelected;
  final Package package;
  @override
  Widget build(BuildContext context) {
    int price = 0;
    for (var p in package.products!) {
      price += p.price!;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.r),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Ink(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 14.h,
            ),
            decoration: isSelected
                ? BoxDecoration(
                    color: AppColors.primary300.withOpacity(0.08),
                    border: Border.all(color: AppColors.primary300),
                    borderRadius: BorderRadius.circular(9.r),
                  )
                : BoxDecoration(
                    color: AppColors.black.withOpacity(0.02),
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(9.r),
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ giao: ',
                      style: caption.copyWith(fontSize: 14),
                    ),
                    Expanded(
                      child: Text(
                        package.destinationAddress ?? '',
                        style: subtitle2.copyWith(
                            fontWeight: FontWeights.medium,
                            color: AppColors.softBlack,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Khoảng cách ',
                      style: caption.copyWith(fontSize: 14),
                    ),
                    Expanded(
                      child: Text(
                        '${package.distance!.toInt()}m',
                        style: subtitle2.copyWith(
                            fontWeight: FontWeights.medium,
                            color: AppColors.softBlack,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Sản phẩm: ',
                      style: caption.copyWith(fontSize: 14),
                    ),
                    Expanded(
                      child: Text(
                        package.getProductNames(),
                        style: subtitle2.copyWith(
                            fontWeight: FontWeights.medium,
                            color: AppColors.softBlack,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Phí vận chuyển:  ',
                            style: caption.copyWith(fontSize: 14),
                          ),
                          Expanded(
                            child: Text(
                              package.priceShip!.toVND(),
                              style: subtitle2.copyWith(
                                  fontWeight: FontWeights.medium,
                                  color: AppColors.softBlack,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        price.toVND(),
                        style: subtitle2.copyWith(
                            color: AppColors.primary900,
                            fontWeight: FontWeights.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
