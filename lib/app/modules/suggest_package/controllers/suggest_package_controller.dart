import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SuggestPackageController extends BaseController {
  final RefreshController _refreshController = RefreshController();

  RefreshController get refreshController => _refreshController;

  @override
  void onInit() {
    super.onInit();
    fetchPackages();
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

  void gotoDetail(SuggestPackage suggest) async {
    dynamic result =
        await Get.toNamed(Routes.SUGGEST_PACKAGE_DETAIL, arguments: suggest);
    if (result == true) {
      _refreshController.requestRefresh();
    }
  }
}
