import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:convenient_way/app/core/widgets/hyper_shape.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/controllers/suggest_package_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchRoute extends GetWidget<SuggestPackageDetailController> {
  const SearchRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(9.r),
          bottomRight: Radius.circular(9.r),
        ),
        boxShadow: ShadowStyles.map,
      ),
      padding: EdgeInsets.only(
        left: 18.w,
        right: 18.w,
        bottom: 18.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _searchInput(),
          SizedBox(
            height: 15.h,
          ),
          _action(),
        ],
      ),
    );
  }

  Widget _action() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyles.primaryMedium(),
        onPressed: null,
        child: HyperButton.child(
          status: false,
          loadingText: 'Tìm tài xế',
          child: Text(
            'Tiếp tục',
            style: buttonBold,
          ),
        ),
      ),
    );
  }

  Widget _searchInput() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 11.5.h),
                height: 85.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HyperShape.startCircle(),
                    HyperShape.dot(),
                    HyperShape.dot(),
                    HyperShape.dot(),
                    HyperShape.endCircle(),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 3.5.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _textField(
                              onPressed: () {},
                              labelText: 'Điểm đi',
                              hintText: 'Chọn điểm đi',
                              textController: TextEditingController(),
                            ),
                            _textField(
                              onPressed: () {},
                              labelText: 'Điểm đến',
                              hintText: 'Chọn điểm đến',
                              textController: TextEditingController(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5.w),
                      ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: AppColors.blue,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.all(0),
                          minimumSize: Size(40.r, 40.r),
                        ),
                        child: SizedBox(
                          height: 40.r,
                          width: 40.r,
                          child: Icon(
                            Icons.swap_vert,
                            size: 23.r,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required Function() onPressed,
    required String hintText,
    required String labelText,
    required TextEditingController textController,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: TextFormField(
          controller: textController,
          enabled: false,
          cursorColor: AppColors.blue,
          style: subtitle1.copyWith(
            color: AppColors.lightBlack,
          ),
          decoration: InputStyles.map(
            hintText: hintText,
            labelText: labelText,
          ),
        ),
      ),
    );
  }
}
