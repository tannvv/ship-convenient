import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/modules/home/widgets/nav_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => PageStorage(
          bucket: controller.bucket, child: controller.currentScreen)),
      // bottomNavigationBar: Obx(
      //   () => BottomNavigationBar(
      //     onTap: controller.changeTab,
      //     currentIndex: controller.selectedIndex,
      //     elevation: 10,
      //     showSelectedLabels: false,
      //     showUnselectedLabels: false,
      //     selectedItemColor: Colors.blueGrey,
      //     unselectedItemColor: const Color(0xFF526480),
      //     type: BottomNavigationBarType.fixed,
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
      //         activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
      //         label: 'Home',
      //       ),
      //       BottomNavigationBarItem(
      //           icon:
      //               Icon(FluentSystemIcons.ic_fluent_clipboard_letter_regular),
      //           activeIcon:
      //               Icon(FluentSystemIcons.ic_fluent_clipboard_letter_filled),
      //           label: 'Received package'),
      //       BottomNavigationBarItem(
      //           icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
      //           activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
      //           label: 'Search'),
      //       BottomNavigationBarItem(
      //           icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
      //           activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
      //           label: 'Ticket'),
      //       BottomNavigationBarItem(
      //           icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
      //           activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
      //           label: 'Profile')
      //     ],
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.h,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          height: 60.h,
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
              // Get.toNamed(Routes.SCAN);
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
