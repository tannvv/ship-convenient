import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderScaffold extends StatelessWidget {
  const HeaderScaffold({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
}
