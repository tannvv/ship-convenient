import 'package:get/get.dart';

import '../controllers/pick_up_location_controller.dart';

class PickUpLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickUpLocationController>(
      () => PickUpLocationController(),
    );
  }
}
