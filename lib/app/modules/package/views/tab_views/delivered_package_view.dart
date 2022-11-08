import 'package:convenient_way/app/modules/package/controllers/package_controller.dart';
import 'package:convenient_way/app/modules/package/views/widgets/delivery_package_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DeliveredView extends GetView<PackageController> {
  const DeliveredView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
          itemBuilder: (_, index) {
            return Column(
              children: [
                DeliveryPackageItem(
                    package: controller.deliveredPackages.value[index]),
              ],
            );
          },
          separatorBuilder: (_, index) => Gap(12.h),
          itemCount: controller.deliveredPackages.value.length),
    );
  }
}
