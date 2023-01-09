import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cancel_package_controller.dart';

class CancelPackageView extends GetView<CancelPackageController> {
  const CancelPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điền lí do hủy gói hàng!!'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            TextFormField(
              controller: controller.textCtrl,
              decoration: const InputDecoration(
                hintText: 'Nhập lí do',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Vui lòng nhập lí do';
                }
                return null;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  controller.cancelPackage();
                },
                child: Obx(() => HyperButton.childWhite(
                    status: controller.isLoading,
                    child: const Text('Đồng ý'),
                    loadingText: 'Đang tải')))
          ],
        ),
      ),
    );
  }
}
