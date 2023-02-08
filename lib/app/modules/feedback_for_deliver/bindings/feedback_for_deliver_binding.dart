import 'package:get/get.dart';

import '../controllers/feedback_for_deliver_controller.dart';

class FeedbackForDeliverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackForDeliverController>(
      () => FeedbackForDeliverController(),
    );
  }
}
