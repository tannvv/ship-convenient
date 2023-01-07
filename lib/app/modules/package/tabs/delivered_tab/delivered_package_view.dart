import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/modules/package/tabs/delivered_tab/delivered_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/delivery_tab/delivery_package_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DeliveredView extends GetView<DeliveredPackageController> {
  const DeliveredView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () => controller.onRefresh(),
          onLoading: () => controller.onLoading(),
          footer: CustomFooterSmartRefresh.defaultCustom(),
          child: ListView.separated(
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    DeliveryPackageItem(package: controller.dataApis[index]),
                  ],
                );
              },
              separatorBuilder: (_, index) => Gap(12.h),
              itemCount: controller.dataApis.length),
        ));
  }
}
