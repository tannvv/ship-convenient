import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/modules/suggest_package/views/widgets/suggest_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/suggest_package_controller.dart';

class SuggestPackageView extends GetView<SuggestPackageController> {
  SuggestPackageView({Key? key}) : super(key: key);
  final GlobalKey _refresherKey = GlobalKey();

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    await controller.fetchPackages();
    controller.refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    controller.refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Combo đề xuất'),
          centerTitle: true,
        ),
        body: Obx(
          () => SmartRefresher(
            enablePullUp: true,
            header: WaterDropMaterialHeader(
              distance: 50.h,
              backgroundColor: AppColors.softRed,
            ),
            key: _refresherKey,
            controller: controller.refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: CustomFooterSmartRefresh.defaultCustom(),
            child: ListView.separated(
                itemBuilder: (_, index) => GestureDetector(
                      onTap: () => controller
                          .gotoDetail(controller.packages.value[index]),
                      child: SuggestPackageItem(
                          suggestPackage: controller.packages.value[index]),
                    ),
                padding: const EdgeInsets.all(20),
                separatorBuilder: (_, index) => Gap(15.h),
                itemCount: controller.packages.value.length),
          ),
        ));
  }
}
