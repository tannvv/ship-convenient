import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:convenient_way/app/core/widgets/hyper_stack.dart';
import 'package:convenient_way/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HyperStack(
        children: [
          Container(
            decoration: const BoxDecoration(color: AppColors.primaryLight),
          ),
          Form(
            key: controller.formKey,
            child: Center(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 70.h),
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(AppAssets.logo, width: 120.w, height: 120.h),
                    Gap(12.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Text(
                        'Tiện đường',
                        style: h5.copyWith(
                            fontSize: 28.sp,
                            fontWeight: FontWeights.bold,
                            color: AppColors.primary900,
                            letterSpacing: 2.sp),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  width: 280.w,
                  height: 320.h,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 4),
                          blurRadius: 10.r,
                          color: AppColors.gray.withOpacity(0.6),
                        )
                      ]),
                  child: Column(
                    children: [
                      const Gap(30),
                      _userName(),
                      _password(),
                      _loginButton(),
                      const Gap(20),
                      _registerColumn(),
                    ],
                  ),
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  Column _registerColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Bạn chưa có tài khoản?',
            style: subtitle2.copyWith(
              color: AppColors.gray,
              fontWeight: FontWeight.w500,
            )),
        TextButton(
          onPressed: () {
            controller.gotoSignUp();
          },
          child: Text('Đăng ký',
              style: subtitle2.copyWith(
                  color: AppColors.primary700,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline)),
        ),
      ],
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: 240.w,
      child: ElevatedButton(
        style: ButtonStyles.paymentChip().copyWith(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.primary600),
            padding: MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 44.w, vertical: 14.h)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r)))),
        onPressed: () {
          controller.formKey.currentState!.save();
          controller.login();
        },
        child: Obx(() => HyperButton.childWhite(
            status: controller.isLoading,
            child: Text(
              'Đăng nhập',
              style: buttonBold.copyWith(color: AppColors.white),
            ),
            loadingText: 'Đang đăng nhập')),
      ),
    );
  }

  TextFormField _password() {
    return TextFormField(
      onSaved: (newValue) => controller.setPassword = newValue ?? '',
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Mật khẩu',
        radius: 20.r,
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
    );
  }

  TextFormField _userName() {
    return TextFormField(
      onSaved: (newValue) => controller.setUserName = newValue ?? '',
      enableSuggestions: false,
      autocorrect: false,
      style: subtitle1.copyWith(color: AppColors.lightBlack),
      decoration: InputStyles.boldBorder(
          labelText: 'Tên đăng nhập',
          radius: 20.r,
          prefixIcon: const Icon(Icons.account_circle_outlined)),
      maxLength: 20,
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Vui lòng nhập tên đăng nhập';
        }
        return null;
      },
    );
  }
}
