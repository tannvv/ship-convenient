import 'package:cached_network_image/cached_network_image.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/header_scaffold.dart';
import 'package:convenient_way/app/data/options/gender_option.dart';
import 'package:convenient_way/app/modules/profile_page/widgets/button_color.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.white,
      body: ListView(
        children: [
          const HeaderScaffold(title: 'Thông tin cá nhân'),
          Padding(
            padding: const EdgeInsets.all(12),
            child: _avatarName(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _wallet(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Column(
              children: [
                _separateContent(),
                _phoneNumber(),
                _separateContent(),
                _gender(),
                _separateContent(),
                _email(),
                _separateContent(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconsOutlineButton(
              onPressed: controller.signOut,
              text: 'Đăng xuất',
              iconData: Icons.offline_share,
              textStyle: subtitle2.copyWith(
                color: AppColors.primary400,
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              color: Colors.black12.withOpacity(0.06),
            ),
          )
        ],
      ),
    );
  }

  Divider _separateContent() {
    return Divider(
      endIndent: 0,
      thickness: 2,
      color: Colors.black.withOpacity(0.08),
    );
  }

  Container _wallet() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: ShadowStyles.surface,
      ),
      width: 324.w,
      height: 112.h,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 14.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Số dư', style: body2.copyWith(color: AppColors.floatLabel)),
          SizedBox(
            height: 5.h,
          ),
          GetBuilder<AuthController>(
            builder: (_) {
              Widget result = Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    '-',
                    style: subtitle1.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.softBlack,
                      fontWeight: FontWeights.medium,
                    ),
                  ),
                ),
              );
              if (!controller.isLoading) {
                result = Text(
                  controller.accountBalanceVND,
                  style: subtitle1.copyWith(
                    fontSize: 18.sp,
                    color: AppColors.softBlack,
                    fontWeight: FontWeights.medium,
                  ),
                );
              }
              return result;
            },
          ),
          SizedBox(
            height: 10.h,
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
                onPressed: () => {Get.toNamed(Routes.TRANSACTION)},
                icon: Icons.summarize_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Địa chỉ email',
          style: body2.copyWith(color: AppColors.floatLabel),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 44.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 3,
                  child: Text(
                    controller.initEmail,
                    style: subtitle1.copyWith(
                      fontSize: 15.sp,
                      color: AppColors.softBlack,
                      fontWeight: FontWeights.medium,
                    ),
                  )),
              Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 6),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.yellow)),
                        onPressed: null,
                        child: Text(
                          'Đã kết nối',
                          style: subtitle2,
                        )),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Column _gender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Giới tính',
          style: body2.copyWith(color: AppColors.floatLabel),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Flexible(
                flex: 30,
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24))),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      child: DropdownButton(
                        style: subtitle2,
                        icon: const Icon(Icons.arrow_downward_outlined),
                        menuMaxHeight: Get.height * 0.4,
                        iconSize: 24,
                        isExpanded: true,
                        underline: const SizedBox(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        items: GenderOption.getOptionDropdown(),
                        value: controller.initGender,
                        onChanged: (selectedValue) async {},
                      ),
                    ),
                  ),
                )),
            const Flexible(
                child: SizedBox(
              width: 40,
            )),
          ],
        ),
      ],
    );
  }

  Row _phoneNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Số điện thoại',
              style: body2.copyWith(color: AppColors.floatLabel),
            ),
            SizedBox(
              width: Get.width * 0.6,
              height: 44.h,
              child: _inputPhone(),
            )
          ],
        ),
        SizedBox(
          height: 40,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 20),
            child: Visibility(
              child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green)),
                  onPressed: () async {},
                  child: const Text('Lưu')),
            ),
          ),
        )
      ],
    );
  }

  Row _avatarName() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Stack(
            children: [
              Obx(
                () => CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      CachedNetworkImageProvider(controller.photoUrl.value),
                ),
              ),
              Positioned(
                  right: -16,
                  bottom: -2,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor:
                              const Color.fromARGB(255, 85, 88, 87),
                          side:
                              const BorderSide(width: 2, color: Colors.white)),
                      onPressed: () async {
                        controller.uploadImage();
                      },
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                      )))
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          flex: 4,
          child: Container(
            height: Get.height * 0.11,
            width: Get.width * 0.74,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                    width: 2, color: Colors.black.withOpacity(0.16))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Họ và tên',
                    style: subtitle2.copyWith(
                        color: Colors.black.withOpacity(0.6)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(flex: 3, child: _inputName()),
                      Flexible(
                          flex: 2,
                          child: SizedBox(
                            height: 32,
                            child: Visibility(
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(EdgeInsets.zero),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green)),
                                  onPressed: () async {},
                                  child: const Text('Lưu')),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  TextFormField _inputName() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            )),
      ),
      initialValue: controller.initName,
      onChanged: (String value) {},
    );
  }

  TextFormField _inputPhone() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintStyle: subtitle2,
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2.0,
            )),
      ),
      style: subtitle1.copyWith(
        fontSize: 15.sp,
        color: AppColors.softBlack,
        fontWeight: FontWeights.medium,
      ),
      initialValue: controller.initPhone,
      onChanged: (String value) {},
    );
  }
}
