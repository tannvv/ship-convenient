import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/controllers/map_location_controller.dart';
import 'package:convenient_way/app/core/controllers/pickup_file_controller.dart';
import 'package:get/get.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<MapLocationController>(() => MapLocationController(),
        fenix: true);
    Get.lazyPut<PickUpFileController>(() => PickUpFileController());
  }
}
