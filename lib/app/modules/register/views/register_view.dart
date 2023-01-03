import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
            color: AppColors.pinky,
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
                        child: Stack(children: [
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 80),
                                  child: TextButton(
                                    style: ButtonStyles.textCircle(),
                                    onPressed: () {
                                      controller.gotoSignIn();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 18,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Đăng kí',
                                  style: h6.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Positioned(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red)),
                                        onPressed: () {
                                          controller.gotoSignIn();
                                        },
                                        child: const Text(
                                          'Sign in',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
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
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Padding(
                            //             padding: EdgeInsets.only(left: 16.sp, right: 80.r),
                            //             child: Text(
                            //               'Nhập thông tin',
                            //               style: body1.copyWith(
                            //                 color: AppColors.gray,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
                                    _passwordTextField(),
                                    _rePasswordTextField(),
                                    _emailTextField(),
                                    _firstNameTextField(),
                                    _lastNameTextField(),
                                    Obx(() => _phoneNumberTextField()),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Obx(() =>
                                            controller.isConfirmPhone.value
                                                ? const Icon(
                                                    Icons.check_circle_outline,
                                                    color: AppColors.softGreen,
                                                  )
                                                : const Icon(
                                                    Icons.sms_failed,
                                                    color: AppColors.softRed,
                                                  )),
                                        Gap(10.w),
                                        _verifyOtpButton()
                                      ],
                                    ),
                                    Gap(20.h),
                                    SizedBox(
                                      width: 220.w,
                                      child: ElevatedButton(
                                        style: ButtonStyles.primaryBlue(),
                                        onPressed: () async {
                                          controller.formKey.currentState!
                                              .save();
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            await controller.registerDeliver();
                                          }
                                        },
                                        child: Obx(() => HyperButton.childWhite(
                                              status:
                                                  controller.isLoading.value,
                                              child: Text(
                                                'Đăng kí',
                                                style: buttonBold.copyWith(
                                                    color: AppColors.white),
                                              ),
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40.h,
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

  TextFormField _firstNameTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setFirstName = newValue ?? '',
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Họ',
        radius: 14,
        prefixIcon: const Icon(
          Icons.account_box_outlined,
        ),
      ),
      maxLength: 50,
      // validator: (value) {
      //   if (value.toString().isEmpty) {
      //     return 'Vui lòng nhập địa chỉ nhà';
      //   }
      //   return null;
      // },
    );
  }

  TextFormField _lastNameTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setLastName = newValue ?? '',
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Tên',
        radius: 14,
        prefixIcon: const Icon(
          Icons.account_box_outlined,
        ),
      ),
      maxLength: 50,
      // validator: (value) {
      //   if (value.toString().isEmpty) {
      //     return 'Vui lòng nhập địa chỉ nhà';
      //   }
      //   return null;
      // },
    );
  }

  TextFormField _emailTextField() {
    return TextFormField(
      onSaved: (newValue) => controller.setEmail = newValue ?? '',
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Email',
        radius: 14,
        prefixIcon: const Icon(
          Icons.email_outlined,
        ),
      ),
      maxLength: 50,
      // validator: (value) {
      //   if (value.toString().isEmpty) {
      //     return 'Vui lòng nhập địa chỉ nhà';
      //   }
      //   return null;
      // },
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
              radius: 14,
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

  ElevatedButton _verifyOtpButton() {
    return ElevatedButton(
        onPressed: controller.isConfirmPhone.value
            ? null
            : () {
                controller.formKey.currentState!.save();
                controller.verifyPhone();
              },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.softGreen),
        ),
        child: Obx(() => HyperButton.childWhite(
              status: controller.isLoadingVerify.value,
              loadingText: 'Đang gửi OTP',
              child: Text(
                'Xác thực số điện thoại',
                style: buttonBold.copyWith(color: AppColors.white),
              ),
            )));
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

  TextFormField _rePasswordTextField() {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputStyles.boldBorder(
        labelText: 'Nhập lại mật khẩu',
        radius: 14,
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
