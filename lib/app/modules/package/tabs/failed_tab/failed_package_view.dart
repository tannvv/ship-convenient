import 'package:convenient_way/app/modules/package/tabs/failed_tab/failed_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/failed_tab/failed_package_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FailedView extends GetView<FailedPackageController> {
  const FailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Obx(() => SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.onRefresh(),
        onLoading: () => controller.onLoading(),
        footer: CustomFooterSmartRefresh.defaultCustom(),
        child: ListView.separated(
          itemBuilder: (_, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FailedPackageItem(package: controller.dataApis[index]),
              ],
            );
          },
          separatorBuilder: (_, index) => Gap(12.h),
          itemCount: controller.dataApis.length),
        )
      )
    );
  }
}

