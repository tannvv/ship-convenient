import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessPackageItem extends StatelessWidget {
  const SuccessPackageItem({Key? key, required this.package})
      : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.w),
          boxShadow: ShadowStyles.primary),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Tên người nhận: '),
                Text(
                  '${package.receiverName}.',
                  style: subtitle2,
                ),
              ],
            ),
            Row(
              children: [
                const Text('Điểm đến: ',),
                Expanded(
                  child: Text(
                    '${package.destinationAddress}.',
                    style: subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Số điện thoại: ',),
                Text('${package.receiverPhone}.',
                  style: subtitle2,
                ),
              ],
            ),
          ]
      ),
    );
  }
}
