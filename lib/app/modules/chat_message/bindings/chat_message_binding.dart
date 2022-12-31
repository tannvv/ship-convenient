import 'package:get/get.dart';

import '../controllers/chat_message_controller.dart';

class ChatMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatMessageController>(
      () => ChatMessageController(),
    );
  }
}
