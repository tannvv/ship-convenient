import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/header_scaffold.dart';
import 'package:flutter/material.dart';
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
              flex: 11,
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

  Widget _header() {
    return const HeaderScaffold(title: 'Quản lý các gói hàng');
  }
}
