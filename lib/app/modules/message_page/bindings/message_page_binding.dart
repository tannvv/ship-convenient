import 'package:get/get.dart';

import '../controllers/message_page_controller.dart';

class MessagePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessagePageController>(
      () => MessagePageController(),
    );
  }
}
