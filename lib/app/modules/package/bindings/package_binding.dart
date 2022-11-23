import 'package:convenient_way/app/modules/package/controllers/tab_controllers/received_package_controller.dart';
import 'package:get/get.dart';

import '../controllers/package_controller.dart';

class PackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PackageController>(
      () => PackageController(),
    );
  }
}
