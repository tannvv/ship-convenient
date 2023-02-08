import 'package:card_loading/card_loading.dart';
import 'package:convenient_way/app/core/values/app_animation_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/button_color.dart';
import 'package:convenient_way/app/core/widgets/custom_body_scaffold.dart';
import 'package:convenient_way/app/core/widgets/header_scaffold.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:convenient_way/app/modules/manage_route/widgets/create_route_button.dart';
import 'package:convenient_way/app/modules/manage_route/widgets/route_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/manage_route_controller.dart';

class ManageRouteView extends GetView<ManageRouteController> {
  const ManageRouteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBodyScaffold(
        header: _header(),
        body: _body(),
      ),
      floatingActionButton: const CreateRouteButton(),
    );
  }

  Widget _header() {
    return const HeaderScaffold(title: 'Lộ trình của bạn', isBack: true);
  }

  Widget _body() {
    return Obx(() => controller.isLoading
        ? _loadingShimmer()
        : ListView.separated(
            itemBuilder: (context, index) {
              return Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: ShadowStyles.map,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  child: Obx(
                    () => Stack(
                      children: [
                        controller.routes[index].isActive == true
                            ? _activeRouteAction()
                            : controller.isEditField(index)
                                ? _editingRouteAction()
                                : _disableRouteAction(index),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RouteInfo(index: index),
                            SizedBox(
                              height: 15.h,
                            ),
                            controller.indexNewRoute.value == index &&
                                    controller.routes[index].isActive != true
                                ? saveRouteButton()
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ));
            },
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            separatorBuilder: (_, __) => Gap(12.h),
            itemCount: controller.routes.length));
  }

  Widget _loadingShimmer() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CardLoading(
                      animationDuration: Duration(seconds: 2),
                      curve: Curves.linear,
                      withChangeDuration: false,
                      height: 140,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      margin: EdgeInsets.only(bottom: 10),
                    ));
              },
              childCount: 4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _disableRouteAction(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ColorButton(
          'Đặt mặc định',
          icon: Icons.get_app,
          onPressed: () {
            controller.setActiveRouteApi(controller.routes[index].id!);
          },
          radius: 6,
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        ),
        Gap(4.w),
        ColorButton(
          'Xóa',
          icon: Icons.delete,
          height: 40.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          onPressed: () {
            controller.deleteRouteApi(controller.routes[index].id!);
          },
          radius: 6,
        ),
      ],
    );
  }

  Widget _activeRouteAction() {
    return Positioned(
      right: 0,
      top: -8.h,
      child: Row(
        children: [
          Lottie.asset(
            AppAnimationAssets.successful,
            repeat: true,
            height: 30.h,
          ),
          Text('Đang hoạt động',
              style: subtitle2.copyWith(
                  color: const Color.fromARGB(255, 8, 184, 13))),
        ],
      ),
    );
  }

  Widget _editingRouteAction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ColorButton(
          'Xóa',
          backgroundColor: AppColors.softRed,
          textColor: Colors.red,
          icon: Icons.delete,
          onPressed: () {
            controller.deleteRouteToList();
          },
          radius: 6,
        ),
      ],
    );
  }

  Widget saveRouteButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyles.primaryMedium().copyWith(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(vertical: 8.h),
            ),
            backgroundColor: MaterialStateProperty.all(AppColors.blue),
          ),
          onPressed: () {
            controller.createRouteApi();
          },
          child: HyperButton.childWhite(
            status: controller.isLoadingCreateRoute.value,
            loadingText: 'Đang lưu...',
            child: Text(
              'Lưu lộ trình',
              style: buttonBold.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
