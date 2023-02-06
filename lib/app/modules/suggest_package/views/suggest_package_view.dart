import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/button_color.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/modules/suggest_package/widgets/show_wallet.dart';
import 'package:convenient_way/app/modules/suggest_package/widgets/suggest_item.dart';
import 'package:convenient_way/app/modules/suggest_package/widgets/user_avatar.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/suggest_package_controller.dart';

class SuggestPackageView extends GetView<SuggestPackageController> {
  SuggestPackageView({Key? key}) : super(key: key);
  final GlobalKey _refresherKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Stack(
        children: [
          _headerBackground(),
          AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.only(top: controller.headerState.height),
              child: SmartRefresher(
                enablePullUp: true,
                key: _refresherKey,
                controller: controller.refreshController,
                onRefresh: () => controller.onRefresh(),
                onLoading: () => controller.onLoading(),
                footer: CustomFooterSmartRefresh.defaultCustom(),
                child: ListView.separated(
                    itemBuilder: (_, index) => GestureDetector(
                          onTap: () =>
                              controller.gotoDetail(controller.dataApis[index]),
                          child: SuggestPackageItem(
                              suggestPackage: controller.dataApis[index]),
                        ),
                    padding: const EdgeInsets.all(20),
                    separatorBuilder: (_, index) => Gap(15.h),
                    itemCount: controller.dataApis.length),
              ))
        ],
      ),
    ));
  }

  Container _wallet() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: ShadowStyles.surface,
      ),
      width: 324.w,
      height: 100.h,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 14.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Số dư', style: body2.copyWith(color: AppColors.floatLabel)),
          SizedBox(
            height: 5.h,
          ),
          Text(controller.balanceAccountVND,
              style: subtitle1.copyWith(
                fontSize: 18.sp,
                color: AppColors.softBlack,
                fontWeight: FontWeights.medium,
              )),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              ColorButton(
                'Nạp tiền',
                onPressed: () {
                  Get.toNamed(Routes.PAYMENT);
                },
                icon: Icons.payments_outlined,
              ),
              SizedBox(
                width: 10.w,
              ),
              ColorButton(
                'Giao dịch',
                onPressed: () => {},
                icon: Icons.summarize_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _appBar() {
    return Row(
      children: [
        const Expanded(
          child: UserAvatar(),
        ),
        ShowWallet(
          onPressed: () {
            controller.toggleHeader();
          },
          state: controller.headerState.walletUiState,
        ),
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            height: 36.r,
            width: 36.r,
            child: Icon(
              Icons.notifications_outlined,
              color: AppColors.white,
              size: 24.r,
            ),
          ),
        ),
      ],
    );
  }

  AnimatedContainer _headerBackground() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecorations.header(),
      height: controller.headerState.height,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(5.r),
          ),
          child: Stack(
            children: [
              SvgPicture.asset(
                AppAssets.homeBg,
                fit: BoxFit.cover,
              ),
              SafeArea(child: _header())
            ],
          )),
    );
  }

  // TweenAnimationBuilder<double> _header() {
  //   return TweenAnimationBuilder<double>(
  //     tween: Tween<double>(
  //       begin: controller.headerState.height,
  //       end: controller.headerState.height,
  //     ),
  //     duration: const Duration(milliseconds: 250),
  //     builder: (
  //       BuildContext context,
  //       double height,
  //       Widget? child,
  //     ) {
  //       return Container(
  //         padding: EdgeInsets.only(left: 18.w, top: 2.h, right: 18.w),
  //         height: height,
  //         child: Column(
  //           children: [
  //             _appBar(),
  //             !controller.headerState.walletUiState
  //                 ? Column(
  //                     children: [
  //                       SizedBox(
  //                         height: 18.h,
  //                       ),
  //                       Obx(
  //                         () => controller.headerState.isLoadingToShow
  //                             ? const SizedBox()
  //                             : _wallet(),
  //                       ),
  //                       SizedBox(
  //                         height: 18.h,
  //                       ),
  //                     ],
  //                   )
  //                 : Container(),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Container _header() {
    return Container(
      padding: EdgeInsets.only(left: 18.w, top: 2.h, right: 18.w),
      height: controller.headerState.height,
      child: Obx(
        () => Column(
          children: [
            _appBar(),
            !controller.headerState.walletUiState
                ? Column(
                    children: [
                      SizedBox(
                        height: 18.h,
                      ),
                      _wallet(),
                      SizedBox(
                        height: 18.h,
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
