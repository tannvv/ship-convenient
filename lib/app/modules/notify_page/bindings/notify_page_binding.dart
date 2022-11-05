import 'package:get/get.dart';

import '../controllers/notify_page_controller.dart';

class NotifyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifyPageController>(
      () => NotifyPageController(),
    );
  }
}
