import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/modules/package/tabs/received_tab/received_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/received_tab/received_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReceivedView extends GetView<ReceivedPackageController> {
  const ReceivedView({Key? key}) : super(key: key);

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
                    ReceivedPackageItem(package: controller.dataApis[index]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ButtonStyles.primaryBlueSmall().copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red[400])),
                            onPressed: () {
                              controller.reportPackage(
                                  controller.dataApis[index].id!);
                            },
                            child: const Text('Hủy đơn')),
                        Gap(6.w),
                        ElevatedButton(
                            style: ButtonStyles.primaryBlueSmall(),
                            onPressed: () {
                              controller.accountConfirmPackage(
                                  controller.dataApis[index].id!);
                            },
                            child: const Text('Xác nhận lo được'))
                      ],
                    )
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
