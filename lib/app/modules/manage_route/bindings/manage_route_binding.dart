import 'package:get/get.dart';

import '../controllers/manage_route_controller.dart';

class ManageRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageRouteController>(
      () => ManageRouteController(),
    );
  }
}
