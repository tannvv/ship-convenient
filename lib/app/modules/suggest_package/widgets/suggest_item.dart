import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestPackageItem extends StatelessWidget {
  const SuggestPackageItem({Key? key, required this.suggestPackage})
      : super(key: key);
  final SuggestPackage suggestPackage;
  @override
  Widget build(BuildContext context) {
    int countPackage = suggestPackage.packages?.length ?? 0;
    String products = suggestPackage.getProductsName();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.w),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300, blurRadius: 2, spreadRadius: 1)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Tên người gửi: '),
              Text(
                '${suggestPackage.sender?.infoUser?.firstName}',
                style: subtitle2,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Số gói hàng: ',
                  ),
                  Text(
                    '$countPackage',
                    style: subtitle2,
                  ),
                ],
              ),
              Text(
                '${suggestPackage.compoPrice?.toVND()}',
                style: subtitle2.copyWith(
                  color: AppColors.primary800,
                  fontWeight: FontWeights.medium,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Text('Sản phẩm: '),
              Expanded(
                child: Text(
                  products,
                  style: subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Điểm gửi hàng: '),
              Expanded(
                child: Text(
                  '${suggestPackage.packages![0].startAddress}',
                  style: subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Tổng phí vận chuyển: '),
              Text(
                suggestPackage.getPriceShips().toVND(),
                style: subtitle2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
