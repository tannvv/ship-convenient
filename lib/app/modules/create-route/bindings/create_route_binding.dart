import 'package:get/get.dart';

import '../controllers/create_route_controller.dart';

class CreateRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRouteController>(
      () => CreateRouteController(),
    );
  }
}
