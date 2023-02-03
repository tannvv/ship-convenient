import 'package:convenient_way/app/modules/package/tabs/delivered_tab/delivered_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/delivery_tab/delivery_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/received_tab/received_package_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
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
