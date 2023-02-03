import 'package:convenient_way/app/core/base/base_paging_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:convenient_way/app/modules/suggest_package/model/header_state.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';
import 'package:get/get.dart';

class SuggestPackageController extends BasePagingController<SuggestPackage> {
  final HeaderState headerState = HeaderState();
  final Account? _account = AuthController.instance.account;

  Account? get account => _account;
  String get balanceAccountVND => account!.balance.toVND();
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

  void toggleHeader() {
    headerState.toggle();
  }

  @override
  Future<void> fetchDataApi() async {
    String? accountId = AuthController.getKeyToken('id');
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
