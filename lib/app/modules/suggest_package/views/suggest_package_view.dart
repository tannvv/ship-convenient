import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/modules/suggest_package/views/widgets/suggest_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/suggest_package_controller.dart';

class SuggestPackageView extends GetView<SuggestPackageController> {
  SuggestPackageView({Key? key}) : super(key: key);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  final GlobalKey _refresherKey = GlobalKey();

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    await controller.fetchPackages();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Combo đề xuất'),
          centerTitle: true,
        ),
        body: Obx(
          () => SmartRefresher(
            enablePullUp: true,
            header: WaterDropMaterialHeader(
              distance: 50.h,
              backgroundColor: AppColors.softRed,
            ),
            key: _refresherKey,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: CustomFooter(builder: ((context, mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("Kéo để tải");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("Có lỗi khi tải trang");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("Tải thêm");
              } else {
                body = const Text("Cuối trang");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            })),
            child: ListView.separated(
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
