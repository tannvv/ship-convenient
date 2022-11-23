import 'package:convenient_way/app/modules/package/controllers/tab_controllers/delivered_package_controller.dart';
import 'package:convenient_way/app/modules/package/controllers/tab_controllers/delivery_package_controller.dart';
import 'package:convenient_way/app/modules/package/controllers/tab_controllers/received_package_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ReceivedPackageController>(
      () => ReceivedPackageController(),
    );
    Get.lazyPut<DeliveryPackageController>(
      () => DeliveryPackageController(),
    );
    Get.lazyPut<DeliveredPackageController>(
      () => DeliveredPackageController(),
    );
  }
}
