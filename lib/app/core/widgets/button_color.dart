import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorButton extends StatelessWidget {
  const ColorButton(this.text,
      {Key? key,
      required this.icon,
      required this.onPressed,
      this.radius = 30,
      this.backgroundColor = AppColors.primary500,
      this.opacityBg = 0.2,
      this.height = 30,
      this.textColor = AppColors.primary500,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5)})
      : super(key: key);

  final String text;
  final IconData icon;
  final Function()? onPressed;
  final double radius;
  final Color backgroundColor;
  final double opacityBg;
  final Color textColor;
  final EdgeInsets padding;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: padding,
              backgroundColor: backgroundColor.withOpacity(opacityBg),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 16.r,
                  color: textColor,
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  text,
                  style: caption.copyWith(
                      color: textColor,
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
