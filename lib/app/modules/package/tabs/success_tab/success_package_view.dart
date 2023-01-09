import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/modules/package/tabs/received_tab/received_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/success_tab/success_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SuccessView extends GetView<ReceivedPackageController> {
  const SuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SmartRefresher(
        controller: controller.refreshController,
        enablePullUp: true,
        header: const WaterDropMaterialHeader(),
        onRefresh: () => controller.onRefresh(),
        onLoading: () => controller.onLoading(),
        footer: CustomFooterSmartRefresh.defaultCustom(),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                decoration: BoxDecorations.primary(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SuccessPackageItem(package: controller.dataApis[index]),
                  ],
                ),
              );
            },
            separatorBuilder: (_, index) => Gap(12.h),
            itemCount: controller.dataApis.length),
      ),
    );
  }
}
