import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/package_controller.dart';

class PackageView extends GetView<PackageController> {
  const PackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Expanded(flex: 1, child: _header()),
            Expanded(
              flex: 12,
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Obx(() => controller.currentScreen),
              ),
            )
          ],
        ),
      )),
    );
  }

  Column _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 18.w,
                top: 10.h,
                right: 18.w,
              ),
            ),
          ],
        ),
        Container(
          height: 34.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: TabBar(
            isScrollable: true,
            controller: controller.tabController,
            onTap: (index) {
              controller.changeTab(index);
            },
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: AppColors.primary400,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  color: AppColors.primary500.withOpacity(0.4),
                ),
              ],
            ),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.description,
            tabs: controller.tabs,
          ),
        ),
      ],
    );
  }
}
