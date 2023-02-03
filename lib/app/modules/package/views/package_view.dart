import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:scroll_navigation/misc/navigation_helpers.dart';
import 'package:scroll_navigation/navigation/title_scroll_navigation.dart';

import '../controllers/package_controller.dart';

class PackageView extends GetView<PackageController> {
  const PackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(flex: 1, child: _header()),
            Expanded(
              flex: 13,
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: TitleScrollNavigation(
                    identiferStyle: const NavigationIdentiferStyle(
                        color: AppColors.primary900),
                    showIdentifier: true,
                    barStyle: TitleNavigationBarStyle(
                        style: subtitle2.copyWith(
                            color: AppColors.primary900,
                            fontWeight: FontWeights.medium),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 12),
                        spaceBetween: 40,
                        background: AppColors.primaryLight,
                        deactiveColor: Colors.red.shade200),
                    titles: controller.tabsTitle,
                    pages: controller.screens,
                  )),
            )
          ],
        ),
      )),
    );
  }

  Column _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 18.w,
                top: 14.h,
                right: 18.w,
              ),
              child: Text(
                'Các đơn hàng bạn đã nhận',
                style: h6.copyWith(color: AppColors.softBlack),
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.only(
        //         left: 18.w,
        //         top: 10.h,
        //         right: 18.w,
        //       ),
        //     ),
        //   ],
        // ),
        // Container(
        //   height: 34.h,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade200,
        //     borderRadius: BorderRadius.circular(20.r),
        //   ),
        //   child: TabBar(
        //     isScrollable: true,
        //     controller: controller.tabController,
        //     onTap: (index) {
        //       controller.changeTab(index);
        //     },
        //     indicator: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20.r),
        //       color: AppColors.primary400,
        //       boxShadow: [
        //         BoxShadow(
        //           offset: const Offset(0, 2),
        //           blurRadius: 4,
        //           color: AppColors.primary500.withOpacity(0.4),
        //         ),
        //       ],
        //     ),
        //     labelColor: Colors.white,
        //     unselectedLabelColor: AppColors.description,
        //     tabs: controller.tabs,
        //   ),
        // ),
      ],
    );
  }
}
