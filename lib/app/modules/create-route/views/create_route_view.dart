import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

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
                                    _homeTextField(),
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
                                                  'Chọn vị trí trên bản đồ')),
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
                                    Gap(24.h),
                                    _destinationTextField(),
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
                                                  'Chọn vị trí trên bản đồ')),
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
                                            MotionToastService.showError(
                                                'Vui lòng chọn địa điểm của bạn trên bản đồ');
                                            return;
                                          }
                                          if (validateForm) {
                                            await controller.registerRoute();
                                          }
                                        },
                                        child: Obx(
                                          () => HyperButton.childWhite(
                                              status: controller.isLoading,
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

  TypeAheadField _homeTextField() {
    return TypeAheadField(
      debounceDuration: const Duration(milliseconds: 500),
      minCharsForSuggestions: 4,
      textFieldConfiguration: TextFieldConfiguration(
          controller: controller.homeController,
          autofocus: true,
          style: subtitle1,
          decoration: InputStyles.boldBorder(
              labelText: 'Địa chỉ nhà',
              radius: 14,
              prefixIcon: const Icon(
                Icons.home_outlined,
              ))),
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return [];
        }
        controller.setFromName = pattern;
        return await controller.queryLocation(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_pin),
          minLeadingWidth: 20,
          title: Text(
            suggestion.name ?? 'Unknown',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.setFromName = suggestion.name ?? '';
        LatLng coord =
            LatLng(suggestion.latitude ?? 0, suggestion.longitude ?? 0);
        controller.setFromCoord = coord;
        controller.homeController.text = suggestion.name ?? '';
      },
      noItemsFoundBuilder: (context) => Padding(
          padding: EdgeInsets.all(10.w),
          child: const Text('Không tìm thấy địa chỉ')),
      errorBuilder: ((context, error) => Padding(
          padding: EdgeInsets.all(10.w), child: Text(error.toString()))),
    );
  }

  TypeAheadField _destinationTextField() {
    return TypeAheadField(
      debounceDuration: const Duration(seconds: 2),
      minCharsForSuggestions: 4,
      textFieldConfiguration: TextFieldConfiguration(
          controller: controller.workController,
          autofocus: true,
          style: subtitle1,
          decoration: InputStyles.boldBorder(
              labelText: 'Địa chỉ thường lui tới',
              radius: 14,
              prefixIcon: const Icon(
                Icons.home_outlined,
              ))),
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return [];
        }
        controller.setToName = pattern;
        return await controller.queryLocation(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_pin),
          minLeadingWidth: 20,
          title: Text(
            suggestion.name ?? 'Unknown',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.setToName = suggestion.name ?? '';
        LatLng coord =
            LatLng(suggestion.latitude ?? 0, suggestion.longitude ?? 0);
        controller.setToCoord = coord;
        controller.workController.text = suggestion.name ?? '';
      },
      noItemsFoundBuilder: (context) => Padding(
          padding: EdgeInsets.all(10.w),
          child: const Text('Không tìm thấy địa chỉ')),
      errorBuilder: ((context, error) => Padding(
          padding: EdgeInsets.all(10.w), child: Text(error.toString()))),
    );
  }
}
