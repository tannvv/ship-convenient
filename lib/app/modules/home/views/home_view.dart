import 'dart:io';

import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/modules/home/widgets/nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    File? imageFile;

    void _getFromCamera() async {
      XFile? pickedFile = (await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1080,
        maxWidth: 1080,
      )) as XFile?;
      imageFile = File(pickedFile!.path);
      Navigator.pop(context);
    }

    return Scaffold(
      body: Obx(() => PageStorage(
          bucket: controller.bucket, child: controller.currentScreen)),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.h,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          height: 70.h,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NavButton(
                      title: 'Trang chủ',
                      icon: Icons.explore,
                      iconOutlined: Icons.explore_outlined,
                      onPressed: () {
                        controller.changeTab(0);
                      },
                      state: controller.selectedIndex == 0,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    NavButton(
                      title: 'Gói hàng',
                      icon: Octicons.package,
                      iconOutlined: Octicons.package,
                      onPressed: () {
                        controller.changeTab(1);
                      },
                      state: controller.selectedIndex == 1,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    NavButton(
                      title: 'Hoạt động',
                      icon: Icons.receipt_long,
                      iconOutlined: Icons.receipt_long_outlined,
                      onPressed: () {
                        controller.changeTab(2);
                      },
                      state: controller.selectedIndex == 2,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    NavButton(
                      title: 'Tài khoản',
                      icon: Icons.person,
                      iconOutlined: Icons.person_outlined,
                      onPressed: () {
                        controller.changeTab(3);
                      },
                      state: controller.selectedIndex == 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 50.w,
        height: 50.w,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: AppColors.primary400,
            child: Icon(
              Icons.qr_code_scanner,
              size: 30.r,
            ),
            onPressed: () {
              _getFromCamera();
              // Get.toNamed(Routes.SCAN);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
