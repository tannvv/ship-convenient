import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/controllers/suggest_package_detail_controller.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/widgets/suggest_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Bottom extends GetWidget<SuggestPackageDetailController> {
  const Bottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w),
        child: Container(
          height: controller.bottomHeight,
          decoration: BoxDecorations.map(),
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _header()),
              Expanded(flex: 12, child: _packageSelector()),
              Expanded(
                flex: 3,
                child: _pickupButton(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Obx _packageSelector() {
    return Obx(
      () => MultiSelectCheckList(
        controller: controller.multiSelectController,
        maxSelectableCount: controller.maxSelectedPackages,
        itemPadding: EdgeInsets.symmetric(vertical: 4.h),
        textStyles: const MultiSelectTextStyles(
            selectedTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        listViewSettings: ListViewSettings(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const Divider(
                  height: 2,
                )),
        items:
            List.generate(controller.suggest.value!.packages!.length, (index) {
          return CheckListCard(
              contentPadding: EdgeInsets.zero,
              value: controller.suggest.value!.packages![index].id!,
              title: Obx(
                () => SuggestItem(
                  isSelected: controller.selectedPackages
                      .contains(controller.suggest.value!.packages![index].id!),
                  package: controller.suggest.value!.packages![index],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)));
        }),
        onChange: (List<String> selectedItems, selectedItem) {
          controller.selectedPackages.value = selectedItems;
          debugPrint('Selected packages : $selectedItems');
        },
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: Text(
        'Các gói hàng',
        style: subtitle1.copyWith(
            fontWeight: FontWeight.bold, color: AppColors.softBlack),
      ),
    );
  }

  Widget _pickupButton() {
    return Container(
      padding: EdgeInsets.only(bottom: 14.h, left: 60.w, right: 60.w),
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyles.primaryMedium().copyWith(
            backgroundColor: MaterialStateProperty.all(AppColors.primary300),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r)))),
        onPressed: () {
          controller.pickUpPackages();
        },
        child: HyperButton.childWhite(
          loadingText: 'Đang thực hiện...',
          status: false,
          child: Text(
            'Lấy gói hàng',
            style: buttonBold.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
