import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/account_cancel_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/delivered_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/delivery_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/failed_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/received_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/shop_cancel_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/success_package_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  late TabController tabController;
  final tabs = const [
    Tab(
      text: 'Đã nhận',
    ),
    Tab(
      text: 'Đang giao',
    ),
    Tab(
      text: 'Đã hủy',
    ),
    Tab(
      text: 'Shop hủy',
    ),
    Tab(
      text: 'Đã giao hàng',
    ),
    Tab(
      text: 'Thất bại',
    ),
    Tab(
      text: 'Thành công',
    ),
  ];

  final List<Widget> _screens = const [
    ReceivedView(),
    DeliveryView(),
    AccountCancelView(),
    ShopCancelView(),
    DeliveredView(),
    FailedView(),
    SuccessView()
  ];

  final receivedPackages = <Package>[].obs;
  final deliveredPackages = <Package>[].obs;
  final deliveryPackages = <Package>[].obs;
  final failedPackages = <Package>[].obs;
  final accountCancelPackages = <Package>[].obs;
  final shopCancelPackages = <Package>[].obs;
  final successPackages = <Package>[].obs;

  PageStorageBucket bucket = PageStorageBucket();
  final indexScreen = 0.obs;
  Widget get currentScreen => _screens[indexScreen.value];

  void changeTab(int index) {
    indexScreen.value = index;
  }

  @override
  void onInit() {
    tabController = TabController(length: 7, vsync: this);
    init();
    super.onInit();
  }

  void init() {
    fetchAllData();
  }

  void fetchAllData() {
    fetchDeliveredPackages();
    fetchDeliveryPackages();
    fetchFailedPackages();
    fetchReceivedPackages();
    fetchAccountCancelPackages();
    fetchShopCancelPackages();
    fetchSuccessPackages();
  }

  void accountConfirmPackage(String packageId) {
    AccountPickUpModel model = AccountPickUpModel(
        accountId: AuthService.instance.account!.id!, packageIds: [packageId]);
    _packageRepo.accountConfirmPackage(model).then((response) {
      ToastService.showSuccess('Đã lấy hàng để đi giao');
    }).catchError((error) {
      ToastService.showError(error.messages[0]);
    });
  }

  void accountDeliveredPackage(String packageId) {
    _packageRepo.deliverySuccess(packageId).then((response) {
      ToastService.showSuccess(response.message!);
    }).catchError((error) {
      ToastService.showError(error.message);
    });
  }

  Future<void> fetchReceivedPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.SHIPPER_PICKUP);
    _packageRepo
        .getList(requestModel)
        .then((response) => receivedPackages.value = response)
        .catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  Future<void> fetchDeliveredPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVERED);
    _packageRepo
        .getList(requestModel)
        .then((response) => deliveredPackages.value = response)
        .catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  Future<void> fetchDeliveryPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVERY);
    _packageRepo.getList(requestModel).then((response) {
      deliveryPackages.value = response;
    }).catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  Future<void> fetchFailedPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVERY_FAILED);
    _packageRepo
        .getList(requestModel)
        .then((response) => failedPackages.value = response)
        .catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  Future<void> fetchAccountCancelPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.SHIPPER_CANCEL);
    _packageRepo
        .getList(requestModel)
        .then((response) => accountCancelPackages.value = response)
        .catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  Future<void> fetchShopCancelPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.SHOP_CANCEL);
    _packageRepo
        .getList(requestModel)
        .then((response) => shopCancelPackages.value = response)
        .catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  Future<void> fetchSuccessPackages() async {
    PackageListModel requestModel = PackageListModel(
        accountId: AuthService.instance.account!.id,
        status: PackageStatus.SHOP_CONFIRM_DELIVERED);
    _packageRepo
        .getList(requestModel)
        .then((response) => successPackages.value = response)
        .catchError((error, stackTrace) {
      ToastService.showError(error.message);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
