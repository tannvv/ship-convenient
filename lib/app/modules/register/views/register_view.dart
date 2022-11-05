import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            color: AppColors.primary400,
          ),
          CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: SafeArea(
                        child: Stack(
                          children: [
                            Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: ButtonStyles.textCircle(),
                                    onPressed: () {
                                      controller.back();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Text('Đăng kí',
                                  style: h6.copyWith(color: AppColors.white)),
                            ),
                            Positioned(
                                right: 0,
                                top: 10.h,
                                child: ElevatedButton(
                                    style: ButtonStyles.primaryBlue(),
                                    onPressed: () {
                                      controller.gotoSignIn();
                                    },
                                    child: const Text('Sign in')))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 85,
                      child: Container(
                        width: 1.sw,
                        decoration: BoxDecorations.top(),
                        padding:
                            EdgeInsets.only(left: 30.w, top: 20.h, right: 30.w),
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
                                      'Nhập thông tin',
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
                                    _userNameTextField(),
                                    Gap(12.h),
                                    _passwordTextField(),
                                    Gap(12.h),
                                    _addressTextField(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: ElevatedButton.icon(
                                              onPressed: () async {
                                                await controller
                                                    .showMapPickUpHome();
                                              },
                                              icon:
                                                  const Icon(Icons.location_on),
                                              label: const Text(
                                                  'Chọn vị trí nhà')),
                                        ),
                                        Obx(
                                          () => controller.homeLocation.value !=
                                                  null
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.sp),
                                                  child: const Icon(
                                                    Icons.check_circle_outline,
                                                    color: AppColors.softGreen,
                                                  ))
                                              : Container(),
                                        )
                                      ],
                                    ),
                                    Gap(12.h),
                                    _addressDestinationTextField(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: ElevatedButton.icon(
                                              onPressed: () async {
                                                await controller
                                                    .showMapPickUpDes();
                                              },
                                              icon:
                                                  const Icon(Icons.location_on),
                                              label: const Text(
                                                  'Chọn vị trí thường lui tới')),
                                        ),
                                        Obx(
                                          () => controller.destinationLocation
                                                      .value !=
                                                  null
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.sp),
                                                  child: const Icon(
                                                    Icons.check_circle_outline,
                                                    color: AppColors.softGreen,
                                                  ))
                                              : Container(),
                                        )
                                      ],
                                    ),
                                    Gap(20.h),
                                    SizedBox(
                                      width: 220.w,
                                      child: ElevatedButton(
                                        style: ButtonStyles.primaryBlue(),
                                        onPressed: () async {
                                          await controller.registerShipper();
                                        },
                                        child: Obx(() =>
                                            HyperButton.childWhite(
                                              status:
                                                  controller.isLoading.value,
                                              child: Text(
                                                'Đăng kí',
                                                style: buttonBold.copyWith(
                                                    color: AppColors.white),
                                              ),
                                            ) ??
                                            Container()),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextFormField _addressDestinationTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setAddress = newValue ?? '',
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Địa chỉ thường lui tới',
        radius: 14,
        prefixIcon: const Icon(Icons.location_pin),
      ),
      maxLength: 50,
      validator: (value) {
        if (value.toString().isEmpty) {
          return 'Vui lòng nhập vị trí';
        }
        return null;
      },
    );
  }

  TextFormField _addressTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setAddress = newValue ?? '',
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Địa chỉ nhà',
        radius: 14,
        prefixIcon: const Icon(
          Icons.home_outlined,
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

  TextFormField _passwordTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setPassword = newValue ?? '',
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
    );
  }

  TextFormField _userNameTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setUserName = newValue ?? '',
      enableSuggestions: false,
      autocorrect: false,
      style: subtitle1.copyWith(color: AppColors.lightBlack),
      decoration: InputStyles.boldBorder(
          labelText: 'Tên đăng nhập',
          radius: 14,
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
