import 'package:convenient_way/app/modules/package/tabs/deliver_cancel_tab/deliver_cancel_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/delivered_tab/delivered_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/delivery_tab/delivery_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/failed_tab/failed_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/received_tab/received_package_controller.dart';
import 'package:convenient_way/app/modules/package/tabs/sender_cancel_tab/sender_cancel_package_controller.dart';
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
    Get.lazyPut<DeliverCancelPackageController>(
          () => DeliverCancelPackageController(),
    );
    Get.lazyPut<SenderCancelPackageController>(
          () => SenderCancelPackageController(),
    );
    Get.lazyPut<FailedPackageController>(
          () => FailedPackageController(),
    );
  }
}
