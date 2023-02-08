import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class ExplainNote extends StatelessWidget {
  const ExplainNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 40.w,
        top: 120.h,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.primary400.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 0,
                  color: AppColors.black.withOpacity(0.2),
                ),
              ],
              color: AppColors.white),
          child: ExpandableNotifier(
            child: Expandable(
              collapsed: ExpandableButton(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                  child: Row(
                    children: [
                      Text('Chú thích',
                          style:
                              subtitle2.copyWith(color: AppColors.primary900)),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: const Icon(
                          FontAwesomeIcons.caretDown,
                          color: AppColors.primary900,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              expanded: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                width: 190.w,
                height: 120.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.locationIcon,
                          height: 22.h,
                          width: 18.h,
                        ),
                        Gap(6.w),
                        Text('Địa điểm lấy hàng', style: subtitle2.copyWith()),
                      ],
                    ),
                    Gap(4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.locationGreenIcon,
                          height: 22.h,
                          width: 18.h,
                        ),
                        Gap(6.w),
                        Text('Địa điểm giao hàng', style: subtitle2.copyWith()),
                      ],
                    ),
                    Gap(4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.locationBlueIcon2,
                          height: 22.h,
                          width: 18.h,
                        ),
                        Gap(6.w),
                        Text('Địa điểm hoàn trả', style: subtitle2.copyWith()),
                      ],
                    ),
                    ExpandableButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Thu nhỏ',
                              style: subtitle2.copyWith(
                                  color: AppColors.primary900)),
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: const Icon(
                              FontAwesomeIcons.caretUp,
                              color: AppColors.primary900,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
