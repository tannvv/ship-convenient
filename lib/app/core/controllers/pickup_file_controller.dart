import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickUpFileController extends GetxController {
  late PermissionStatus permission;
  final ImagePicker _picker = ImagePicker();

  Future<void> requestPermission() async {
    PermissionStatus permission = await Permission.mediaLibrary.status;
    if (permission.isDenied) {
      permission = await Permission.mediaLibrary.request();
      if (permission.isDenied) {
        await _deniedDialog();
      }
    }

    if (permission.isPermanentlyDenied) {
      await _deniedForeverDialog();
    }
  }

  Future<void> _deniedDialog() async {
    await HyperDialog.show(
      barrierDismissible: false,
      title: 'Thông báo',
      content:
          'Vui lòng bật quyền truy cập ảnh của bạn để tiếp tục sử dụng dịch vụ',
      primaryButtonText: 'Bật định vị',
      secondaryButtonText: 'Trở về trang chủ',
      primaryOnPressed: () async {
        permission = await Permission.mediaLibrary.request();
        Get.back();
      },
      secondaryOnPressed: () {
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  Future<void> _deniedForeverDialog() async {
    await HyperDialog.show(
      barrierDismissible: false,
      title: 'Thông báo',
      content:
          'Bạn đã từ chối cho ứng dụng sử dụng ảnh của bạn. Vui lòng bật lại trong cài đặt.',
      primaryButtonText: 'Mở cài đặt',
      secondaryButtonText: 'Trở về trang chủ',
      primaryOnPressed: () async {
        await Geolocator.openAppSettings();
        try {
          var result = await Geolocator.getCurrentPosition();
          Get.back();
          return result;
        } catch (e) {
          return Future.error(e);
        }
      },
      secondaryOnPressed: () {
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  Future<void> uploadImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
  }
}
