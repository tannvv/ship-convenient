import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400.h,
            color: AppColors.primary400,
          ),
          Column(
            children: [
              Expanded(
                flex: 25,
                child: SafeArea(
                  child: Stack(
                    children: [
                      // Center(
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       TextButton(
                      //         style: ButtonStyles.textCircle(),
                      //         onPressed: () {
                      //           controller.back();
                      //         },
                      //         child: const Icon(
                      //           Icons.arrow_back_ios_new,
                      //           size: 18,
                      //           color: AppColors.white,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Center(
                        child: Text('Đăng nhập',
                            style: h6.copyWith(color: AppColors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 85,
                child: Container(
                  width: 1.sw,
                  decoration: BoxDecorations.top(),
                  padding: EdgeInsets.only(left: 30.w, top: 20.h, right: 30.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16.sp),
                              child: Text(
                                'Chào bạn quay lại',
                                style: body1.copyWith(
                                  color: AppColors.gray,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 280.w,
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                onSaved: (newValue) =>
                                    controller.setUserName = newValue ?? '',
                                enableSuggestions: false,
                                autocorrect: false,
                                style: subtitle1.copyWith(
                                    color: AppColors.lightBlack),
                                decoration: InputStyles.boldBorder(
                                    labelText: 'Tên đăng nhập',
                                    radius: 14,
                                    prefixIcon: const Icon(
                                        Icons.account_circle_outlined)),
                                maxLength: 20,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Vui lòng nhập tên đăng nhập';
                                  }
                                  return null;
                                },
                              ),
                              Gap(12.h),
                              TextFormField(
                                onSaved: (newValue) =>
                                    controller.setPassword = newValue ?? '',
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputStyles.boldBorder(
                                  labelText: 'Mật khẩu',
                                  radius: 14,
                                  prefixIcon: const Icon(
                                    Icons.lock_clock_outlined,
                                  ),
                                ),
                                maxLength: 20,
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return 'Vui lòng nhập mật khẩu';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              SizedBox(
                                width: 220.w,
                                child: ElevatedButton(
                                  style: ButtonStyles.primary(),
                                  onPressed: () {
                                    controller.formKey.currentState!.save();
                                    controller.login();
                                  },
                                  child: Obx(() => HyperButton.childWhite(
                                      status: controller.isLoading.value,
                                      child: Text(
                                        'Đăng nhập',
                                        style: buttonBold.copyWith(
                                            color: AppColors.white),
                                      ),
                                      loadingText: 'Đang đăng nhập')),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (controller.formKey.currentState!
                                      .validate()) {}
                                },
                                child: Text(
                                  'Quên mật khẩu',
                                  style: body2.copyWith(
                                    color: AppColors.primary600,
                                    fontWeight: FontWeights.medium,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              ElevatedButton(
                                  style: ButtonStyles.paymentChip().copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.secondary600)),
                                  onPressed: () {
                                    controller.gotoSignUp();
                                  },
                                  child: const Text('Đăng kí'))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
