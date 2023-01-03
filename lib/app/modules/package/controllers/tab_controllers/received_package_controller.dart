import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:convenient_way/app/core/widgets/hyper_dialog.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReceivedPackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  final receivedPackages = <Package>[].obs;
  int _pageSize = AppValues.defaultPageSize;
  int _pageIndex = AppValues.defaultPageIndex;
  bool _hasMore = true;
  RefreshController get refreshController => _refreshController;

  @override
  void onInit() {
    super.onInit();
  }

  void init() {
    fetchReceivedPackages();
  }

  void resetPaging() {
    _pageSize = AppValues.defaultPageSize;
    _pageIndex = AppValues.defaultPageIndex;
    _hasMore = true;
    receivedPackages.value = [];
    _refreshController.resetNoData();
  }

  Future<void> fetchReceivedPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVER_PICKUP,
        pageSize: _pageSize,
        pageIndex: _pageIndex);
    _packageRepo.getList(requestModel).then((response) {
      receivedPackages.addAll(response);
      if (response.length < _pageSize) {
        _hasMore = false;
      }
    }).catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  Future<void> onRefresh() async {
    resetPaging();
    await fetchReceivedPackages();
    _refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    if (!_hasMore) {
      _refreshController.loadNoData();
      return;
    }
    _pageIndex++;
    await fetchReceivedPackages();
    _refreshController.loadComplete();
  }

  void accountConfirmPackage(String packageId) async {
    await HyperDialog.show(
        title: 'Nhận đơn hàng để đi giao',
        content: 'Bạn chắc chắn muốn nhận gói hàng này để đi giao?',
        primaryButtonText: 'Xác nhận',
        secondaryButtonText: 'Hủy',
        primaryOnPressed: () {
          AccountPickUpModel model = AccountPickUpModel(
              deliverId: AuthService.instance.account!.id!,
              packageIds: [packageId]);
          _packageRepo.accountConfirmPackage(model).then((response) {
            ToastService.showSuccess('Đã lấy hàng để đi giao');
            _refreshController.requestRefresh();
          }).catchError((error) {
            ToastService.showError(error.messages[0]);
          });
          Get.back();
        });
  }
}
