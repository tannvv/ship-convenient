import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DeliveredPackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  final RefreshController _refreshController = RefreshController();

  final deliveredPackages = <Package>[].obs;
  RefreshController get refreshController => _refreshController;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    fetchDeliveredPackages();
  }

  void onRefresh() async {
    await fetchDeliveredPackages();
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  Future<void> fetchDeliveredPackages() async {
    PackageListModel requestModel = PackageListModel(
        shipperId: AuthService.instance.shipper!.id,
        status: PackageStatus.DELIVERED);
    _packageRepo
        .getList(requestModel)
        .then((response) => deliveredPackages.value = response)
        .catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }
}
