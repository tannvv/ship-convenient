import 'package:convenient_way/app/modules/package/tabs/deliver_cancel_tab/deliver_cancel_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/delivery_tab/delivery_package_item.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class DeliverCancelView extends GetView<DeliverCancelPackageController> {
  const DeliverCancelView({Key? key}) : super(key: key);

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
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                  decoration: BoxDecorations.primary(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeliveryPackageItem(package: controller.dataApis[index]),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, index) => Gap(12.h),
              itemCount: controller.dataApis.length),
        )
        )
    );
  }
}
