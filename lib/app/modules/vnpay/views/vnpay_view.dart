import 'package:convenient_way/app/core/values/app_animation_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/vnpay_controller.dart';

class VnpayView extends GetView<VnpayController> {
  const VnpayView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller.webViewController,
            ),
            Obx(
              () => Container(
                child: controller.firstLoad.value
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              AppAnimationAssets.cuteDancingChickenCrop,
                              width: 140.w,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'Đang tải...',
                              style: subtitle1.copyWith(
                                  color: AppColors.lightBlack),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
