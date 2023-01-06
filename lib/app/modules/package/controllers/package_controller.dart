import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/core/utils/toast_service.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/account_cancel_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/delivered_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/delivery_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/failed_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/received_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/sender_cancel_package_view.dart';
import 'package:convenient_way/app/modules/package/views/tab_views/success_package_view.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
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
      text: 'Sender hủy',
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
    SenderCancelView(),
    DeliveredView(),
    FailedView(),
    SuccessView()
  ];

  final receivedPackages = <Package>[].obs;
  final deliveredPackages = <Package>[].obs;
  final deliveryPackages = <Package>[].obs;
  final failedPackages = <Package>[].obs;
  final accountCancelPackages = <Package>[].obs;
  final senderCancelPackages = <Package>[].obs;
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
    fetchSenderCancelPackages();
    fetchSuccessPackages();
  }

  Future<void> accountConfirmPackage(String packageId) async {
    AccountPickUpModel model = AccountPickUpModel(
        deliverId: AuthService.instance.account!.id!, packageIds: [packageId]);
    Future<SimpleResponseModel> future =
        _packageRepo.accountConfirmPackage(model);
    await callDataService<SimpleResponseModel>(future, onSuccess: (response) {
      MotionToastService.showSuccess(
          response.message ?? 'Đã lấy hàng để đi giao');
    }, onError: (exception) {
      MotionToastService.showError(
          (exception as dynamic).messages[0] ?? 'Đã có lỗi xảy ra');
    });

    // _packageRepo.accountConfirmPackage(model).then((response) {
    //   MotionToastService.showSuccess('Đã lấy hàng để đi giao');
    // }).catchError((error) {
    //   MotionToastService.showError(error.messages[0]);
    // });
  }

  Future<void> accountDeliveredPackage(String packageId) async {
    Future<SimpleResponseModel> future =
        _packageRepo.deliverySuccess(packageId);
    await callDataService<SimpleResponseModel>(
      future,
      onSuccess: ((response) {
        MotionToastService.showSuccess(response.message ?? 'Thành công');
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> fetchReceivedPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVER_PICKUP);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(
      future,
      onSuccess: ((response) {
        receivedPackages.value = response;
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> fetchDeliveredPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVERED);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(
      future,
      onSuccess: ((response) {
        deliveredPackages.value = response;
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> fetchDeliveryPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVERY);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(
      future,
      onSuccess: ((response) {
        deliveryPackages.value = response;
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> fetchFailedPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVERY_FAILED);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(
      future,
      onSuccess: ((response) {
        failedPackages.value = response;
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> fetchAccountCancelPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.DELIVER_CANCEL);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(
      future,
      onSuccess: ((response) {
        accountCancelPackages.value = response;
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> fetchSenderCancelPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.SENDER_CANCEL);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(
      future,
      onSuccess: ((response) {
        senderCancelPackages.value = response;
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  Future<void> fetchSuccessPackages() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthService.instance.account!.id,
        status: PackageStatus.SENDER_CONFIRM_DELIVERED);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(
      future,
      onSuccess: ((response) {
        successPackages.value = response;
      }),
      onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      },
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
