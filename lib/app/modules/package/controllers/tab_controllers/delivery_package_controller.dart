import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DeliveryPackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  final RefreshController _refreshController = RefreshController();

  final deliveryPackages = <Package>[].obs;
  RefreshController get refreshController => _refreshController;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    fetchDeliveryPackages();
  }

  void onRefresh() async {
    await fetchDeliveryPackages();
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  Future<void> fetchDeliveryPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVERY);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future, onSuccess: (response) {
      deliveryPackages.value = response;
    }, onError: (exception) {
      if (exception is BaseException) {
        MotionToastService.showError(exception.message);
      }
    });
  }

  Future<void> accountDeliveredPackage(String packageId) async {
    Future<SimpleResponseModel> future =
        _packageRepo.deliverySuccess(packageId);
    await callDataService<SimpleResponseModel>(future, onSuccess: (response) {
      MotionToastService.showSuccess(response.message ?? 'Thành công');
      _refreshController.requestRefresh();
    }, onError: (exception) {
      if (exception is BaseException) {
        MotionToastService.showError(exception.message);
      }
    });
  }
}
