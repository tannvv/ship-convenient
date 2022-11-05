import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SuggestPackageController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    fetchPackages();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  Rx<List<SuggestPackage>> packages = Rx<List<SuggestPackage>>([]);

  Future<void> fetchPackages() async {
    String? shipperId = AuthService.getKeyToken('id');
    if (shipperId != null) {
      final packageService = _packageRepo.getSuggestPackage(shipperId);
      await callDataService(packageService,
          onSuccess: (List<SuggestPackage> response) {
        packages(response);
      }, onError: (dioError) {});
    }
  }

  void gotoDetail(SuggestPackage suggest) {
    Get.toNamed(Routes.SUGGEST_PACKAGE_DETAIL, arguments: suggest);
  }
}
