import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart  ';

class SuggestItem extends StatelessWidget {
  const SuggestItem({Key? key, required this.package}) : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    int price = 0;
    for (var p in package.products!) {
      price += p.price!;
    }
    return Container(
      decoration: BoxDecorations.primary(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Địa chỉ giao: ${package.destinationAddress}',
            style: subtitle2,
          ),
          Text(
            'Khoảng cách ${package.distance!.toInt()}m',
            style: subtitle2,
          ),
          Text(
            'Tên các sản phẩm : ${package.getProductNames()}',
            style: subtitle2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí ship: ${package.priceShip!.toInt()}',
                style: subtitle2,
              ),
              Text(
                'Tiền ứng: ${price.toVND()}',
                style: subtitle1.copyWith(
                    color: AppColors.softRed, fontWeight: FontWeights.medium),
              )
            ],
          )
        ],
      ),
    );
  }
}
