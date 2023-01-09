import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfilePageController extends BaseController {
  Account? account;

  @override
  void onInit() {
    account = AuthController.instance.account;
    super.onInit();
  }

  void gotoTransactions() {
    Get.toNamed(Routes.TRANSACTION);
  }

  Future<void> signOut() async {
    MaterialDialogService.showConfirmDialog(
      title: 'Đăng xuất',
      msg: 'Bạn có muốn đăng xuất không?',
      onConfirmTap: () => AuthController.logout(),
    );
  }
}
