import 'package:convenient_way/app/modules/suggest_package/views/widgets/suggest_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/suggest_package_controller.dart';

class SuggestPackageView extends GetView<SuggestPackageController> {
  const SuggestPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Đơn hàng đề xuất'),
          centerTitle: true,
        ),
        body: Container(
          child: Obx(
            () => ListView.separated(
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
