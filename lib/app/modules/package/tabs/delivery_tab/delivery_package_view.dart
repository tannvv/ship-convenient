import 'dart:io';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/modules/package/tabs/delivery_tab/delivery_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/delivery_tab/delivery_package_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DeliveryView extends GetView<DeliveryPackageController> {
  const DeliveryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    File? imageFile;

    void _getFromCamera() async {
      XFile? pickedFile = (await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 1080,
        maxWidth: 1080,
      )) as XFile?;
      imageFile = File(pickedFile!.path);
      Navigator.pop(context);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Obx(() => SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.onRefresh(),
        onLoading: () => controller.onLoading(),
        footer: CustomFooterSmartRefresh.defaultCustom(),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemBuilder: (_, index) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                decoration: BoxDecorations.primary(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeliveryPackageItem(package: controller.dataApis[index]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: ElevatedButton(
                            style: ButtonStyles.primaryBlueSmall(),
                            onPressed: () async {
                              // _getFromCamera();
                              controller.accountDeliveredPackage(
                              controller.dataApis[index].id!);
                            },
                            child: const Text('Đã giao thành công cho khách')),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (_, index) => Gap(12.h),
            itemCount: controller.dataApis.length),
        )
      )
    );
  }
}
