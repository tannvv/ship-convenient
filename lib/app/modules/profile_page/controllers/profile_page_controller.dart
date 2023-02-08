import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/controllers/pickup_file_controller.dart';
import 'package:convenient_way/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePageController extends BaseController {
  Account account = AuthController.instance.account!;
  final photoUrl = ''.obs;
  final PickUpFileController _pickup = Get.find<PickUpFileController>();

  String get accountBalanceVND => account.balance.toVND();
  String get initName =>
      '${account.infoUser!.firstName ?? ''} ${account.infoUser!.lastName ?? ''}';
  String get initPhone => '+84 ${account.infoUser!.phone!}';
  String get initGender => account.infoUser!.gender ?? 'OTHER';
  String get initEmail => account.infoUser!.email ?? '-';
  @override
  void onInit() {
    photoUrl.value = account.infoUser!.photoUrl!;
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

  Future<void> uploadImage() async {
    XFile? image = await _pickup.pickImage();
    if (image != null) {
      photoUrl.value = await _pickup.uploadImageToFirebase(
              image, 'user/avatar/${account.id}') ??
          'https://thuvienplus.com/themes/cynoebook/public/images/default-user-image.png';
    }
  }
}
