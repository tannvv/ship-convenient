import 'package:get/get.dart';

import '../controllers/suggest_package_controller.dart';

class SuggestPackageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuggestPackageController>(() => SuggestPackageController(),
        fenix: true);
  }
}
