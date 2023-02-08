import 'package:get/get.dart';

import '../controllers/location_package_controller.dart';

class LocationPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationPackageController>(
      () => LocationPackageController(),
    );
  }
}
