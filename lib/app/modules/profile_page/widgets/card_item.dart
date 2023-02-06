import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    this.child,
    this.onPress,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final Widget? child;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress ?? () {},
      highlightColor: color.withOpacity(0.2),
      child: Ink(
        height: 44.h,
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 30.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                icon,
                size: 20.r,
                color: AppColors.white,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          text,
                          style: subtitle1.copyWith(
                              color: AppColors.softBlack,
                              fontWeight: FontWeights.regular),
                        ),
                      ],
                    ),
                  ),
                  child ?? Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
