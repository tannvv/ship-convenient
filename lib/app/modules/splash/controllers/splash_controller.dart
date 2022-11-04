import 'package:get/get.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  @override
  void onInit() {
    print('on init');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    initializeLocationAndSave();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> initializeLocationAndSave() async {
    Future.delayed(const Duration(seconds: 3), () => Get.offAllNamed('/home'));
  }
}
