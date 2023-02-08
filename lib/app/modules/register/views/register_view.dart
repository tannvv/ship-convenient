import 'package:convenient_way/app/core/values/app_animation_assets.dart';
import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:convenient_way/app/core/widgets/hyper_stack.dart';
import 'package:convenient_way/app/modules/register/controllers/register_controller.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
              padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 60.h),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.logo, width: 80.w, height: 80.h),
                    Gap(12.h),
                    Text(
                      'Tiện đường',
                      style: h5.copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeights.bold,
                          color: AppColors.primary900,
                          letterSpacing: 2.sp),
                    ),
                  ],
                ),
                Gap(16.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  width: 280.w,
                  height: 550.h,
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
                      _rePasswordTextField(),
                      _firstNameTextField(),
                      _phoneNumberTextField(),
                      _verifyOtpButton(),
                      _registerButton(),
                      Gap(12.h),
                      _loginRow(),
                    ],
                  ),
                ),
              ],
            )),
          ),
          Positioned(
            right: 10.w,
            top: 100.h,
            child: Lottie.asset(AppAnimationAssets.register,
                height: 100.h, width: 100.w),
          ),
        ],
      ),
    );
  }

  Row _loginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Bạn đã có tài khoản?',
            style: subtitle2.copyWith(
              color: AppColors.gray,
              fontWeight: FontWeight.w500,
            )),
        TextButton(
          onPressed: () {
            Get.offAndToNamed(Routes.LOGIN);
          },
          child: Text('Đăng nhập',
              style: subtitle2.copyWith(
                  color: AppColors.primary700,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline)),
        ),
      ],
    );
  }

  Widget _registerButton() {
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
          if (controller.formKey.currentState!.validate()) {
            controller.registerAccount();
          }
        },
        child: Obx(() => HyperButton.childWhite(
            status: controller.isLoading,
            child: Text(
              'Đăng kí',
              style: buttonBold.copyWith(color: AppColors.white),
            ),
            loadingText: 'Đăng đăng kí...')),
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

  TextFormField _rePasswordTextField() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Nhập lại mật khẩu',
        radius: 20.r,
        prefixIcon: const Icon(
          Icons.password_outlined,
        ),
      ),
      maxLength: 20,
      validator: (value) {
        if (controller.password != value) {
          return 'Nhập lại mật khẩu bị sai';
        }
        return null;
      },
    );
  }

  Widget _verifyOtpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() => controller.isConfirmPhone.value
            ? const Icon(
                Icons.check_circle_outline,
                color: AppColors.softGreen,
              )
            : const Icon(
                Icons.sms_failed,
                color: Color.fromARGB(255, 228, 79, 116),
              )),
        Gap(10.w),
        ElevatedButton(
            onPressed: controller.isConfirmPhone.value
                ? null
                : () {
                    controller.formKey.currentState!.save();
                    controller.verifyPhone();
                  },
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(AppColors.blue),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)))),
            child: Obx(() => HyperButton.childWhite(
                  status: controller.isLoadingVerify.value,
                  loadingText: 'Đang gửi OTP',
                  child: Text(
                    'Xác thực sđt',
                    style: buttonBold.copyWith(color: AppColors.white),
                  ),
                )))
      ],
    );
  }

  TextFormField _phoneNumberTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setPhone = newValue ?? '',
      enableSuggestions: false,
      autocorrect: false,
      enabled: !controller.isConfirmPhone.value,
      keyboardType: TextInputType.number,
      decoration: InputStyles.boldBorder(
              labelText: 'Số điện thoại',
              radius: 20.r,
              prefixIcon: const Icon(Icons.phone_iphone_outlined))
          .copyWith(prefix: const Text('+84 ')),
      maxLength: 11,
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Vui lòng nhập số điện thoại';
        }
        return null;
      },
    );
  }

  TextFormField _firstNameTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setFirstName = newValue ?? '',
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Tên',
        radius: 20.r,
        prefixIcon: const Icon(
          Icons.account_box_outlined,
        ),
      ),
      maxLength: 50,
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Vui lòng nhập địa chỉ nhà';
        }
        return null;
      },
    );
  }
}
