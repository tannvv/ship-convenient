import 'package:convenient_way/app/core/base/base_paging_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SuggestPackageController extends BasePagingController<SuggestPackage> {
  @override
  void onInit() {
    super.onInit();
  }

  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  void gotoDetail(SuggestPackage suggest) async {
    dynamic result =
        await Get.toNamed(Routes.SUGGEST_PACKAGE_DETAIL, arguments: suggest);
    if (result == true) {
      refreshController.requestRefresh();
    }
  }

  @override
  Future<void> fetchDataApi() async {
    String? accountId = AuthService.getKeyToken('id');
    if (accountId != null) {
      SuggestPackageRequestModel model = SuggestPackageRequestModel(
        deliverId: accountId,
        pageSize: pageSize,
        pageIndex: pageIndex,
      );
      Future<List<SuggestPackage>> future =
          _packageRepo.getSuggestPackage(model);
      await callDataService<List<SuggestPackage>>(future,
          onSuccess: onSuccess, onError: onError);
    }
  }
}
