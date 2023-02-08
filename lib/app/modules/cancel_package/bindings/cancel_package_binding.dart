import 'package:get/get.dart';

import '../controllers/cancel_package_controller.dart';

class CancelPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelPackageController>(
      () => CancelPackageController(),
    );
  }
}
