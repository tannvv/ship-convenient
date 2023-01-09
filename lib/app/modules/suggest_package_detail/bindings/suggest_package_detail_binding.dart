import 'package:get/get.dart';

import '../controllers/suggest_package_detail_controller.dart';

class SuggestPackageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuggestPackageDetailController>(
        () => SuggestPackageDetailController(),
        fenix: true);
  }
}
