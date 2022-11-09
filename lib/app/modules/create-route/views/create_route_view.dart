import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/create_route_controller.dart';

class CreateRouteView extends GetView<CreateRouteController> {
  const CreateRouteView({Key? key}) : super(key: key);
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
                              child: Text('Đăng kí tuyến đường',
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
                                    _addressTextField(),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: ElevatedButton.icon(
                                              onPressed: () async {
                                                await controller
                                                    .showMapPickUpFrom();
                                              },
                                              icon:
                                                  const Icon(Icons.location_on),
                                              label: const Text(
                                                  'Chọn vị trí nhà')),
                                        ),
                                        Obx(
                                          () => controller.fromCoord != null
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
                                                    .showMapPickUpTo();
                                              },
                                              icon:
                                                  const Icon(Icons.location_on),
                                              label: const Text(
                                                  'Chọn vị trí thường lui tới')),
                                        ),
                                        Obx(
                                          () => controller.toCoord != null
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
                                      width: 200.w,
                                      child: ElevatedButton(
                                        style: ButtonStyles.primaryBlue(),
                                        onPressed: () async {
                                          controller.formKey.currentState!
                                              .save();
                                          bool validateForm = controller
                                              .formKey.currentState!
                                              .validate();
                                          if (controller.fromCoord == null ||
                                              controller.toCoord == null) {
                                            ToastService.showError(
                                                'Vui lòng chọn địa điểm của bạn trên bản đồ');
                                            return;
                                          }
                                          if (validateForm) {
                                            await controller.registerRoute();
                                          }
                                        },
                                        child: Obx(
                                          () => HyperButton.childWhite(
                                              status:
                                                  controller.isLoading.value,
                                              loadingText: 'Đang đăng kí',
                                              child: Text(
                                                'Đăng kí',
                                                style: buttonBold.copyWith(
                                                    color: AppColors.white),
                                              )),
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
      onSaved: (newValue) => controller.setToAddress = newValue ?? '',
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
      onSaved: (newValue) => controller.setFromAddress = newValue ?? '',
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
}
