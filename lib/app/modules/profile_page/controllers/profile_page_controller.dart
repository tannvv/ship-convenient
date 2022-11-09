import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {



  void gotoTransactions() {
    Get.toNamed(Routes.TRANSACTION);
  }
}
