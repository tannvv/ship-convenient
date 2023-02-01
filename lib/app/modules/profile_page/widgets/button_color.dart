import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorButton extends StatelessWidget {
  const ColorButton(
    this.text, {
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: 6.h,
                horizontal: 10.w,
              ),
              backgroundColor: AppColors.primary500.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 16.r,
                  color: AppColors.primary500,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  text,
                  style: caption.copyWith(
                      color: AppColors.primary500,
                      fontWeight: FontWeights.medium,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
