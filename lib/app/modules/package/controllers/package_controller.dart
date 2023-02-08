import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/modules/package/tabs/deliver_cancel_tab/deliver_cancel_view.dart';
import 'package:convenient_way/app/modules/package/tabs/delivered_tab/delivered_package_view.dart';
import 'package:convenient_way/app/modules/package/tabs/delivery_tab/delivery_package_view.dart';
import 'package:convenient_way/app/modules/package/tabs/failed_tab/failed_package_view.dart';
import 'package:convenient_way/app/modules/package/tabs/received_tab/received_package_view.dart';
import 'package:convenient_way/app/modules/package/tabs/sender_cancel_tab/sender_cancel_package_view.dart';
import 'package:convenient_way/app/modules/package/tabs/success_tab/success_package_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  List<String> tabsTitle = const [
    'Đã nhận',
    'Đang giao',
    'Đã hủy',
    'Sender hủy',
    'Đã giao hàng',
    'Thất bại',
    'Thành công',
  ];

  final List<Widget> _screens = const [
    ReceivedView(),
    DeliveryView(),
    DeliverCancelView(),
    SenderCancelView(),
    DeliveredView(),
    FailedView(),
    SuccessView()
  ];

  List<Widget> get screens => _screens;

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
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
