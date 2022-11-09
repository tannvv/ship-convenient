import 'package:convenient_way/app/modules/package/controllers/package_controller.dart';
import 'package:convenient_way/app/modules/package/views/widgets/received_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ReceivedView extends GetView<PackageController> {
  const ReceivedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
          itemBuilder: (_, index) {
            return Column(
              children: [
                ReceivedPackageItem(
                    package: controller.receivedPackages.value[index]),
                ElevatedButton(
                    onPressed: () {
                      controller.shipperConfirmPackage(
                          controller.receivedPackages.value[index].id!);
                    },
                    child: const Text('Xác nhận lo được'))
              ],
            );
          },
          separatorBuilder: (_, index) => Gap(12.h),
          itemCount: controller.receivedPackages.value.length),
    );
  }
}
