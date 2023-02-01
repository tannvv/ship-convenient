import 'package:get/get.dart';

import '../controllers/vnpay_controller.dart';

class VnpayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VnpayController>(
      () => VnpayController(),
    );
  }
}
