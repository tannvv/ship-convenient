import 'package:convenient_way/app/modules/message_page/controllers/message_page_controller.dart';
import 'package:convenient_way/app/modules/message_page/views/message_page_view.dart';
import 'package:convenient_way/app/modules/notify_page/controllers/notify_page_controller.dart';
import 'package:convenient_way/app/modules/notify_page/views/notify_page_view.dart';
import 'package:convenient_way/app/modules/package/controllers/package_controller.dart';
import 'package:convenient_way/app/modules/package/views/package_view.dart';
import 'package:convenient_way/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:convenient_way/app/modules/profile_page/views/profile_page_view.dart';
import 'package:convenient_way/app/modules/suggest_package/controllers/suggest_package_controller.dart';
import 'package:convenient_way/app/modules/suggest_package/views/suggest_package_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late MessagePageController _messageController;
  late PackageController _packageController;
  late NotifyPageController _notifyController;
  late SuggestPackageController _suggestPackageController;
  late ProfilePageController _profileController;

  final _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  final count = 0.obs;

  final List<Widget> _widgetOptions = <Widget>[
    SuggestPackageView(),
    const PackageView(),
    const MessagePageView(),
    const NotifyPageView(),
    const ProfilePageView(),
  ];

  PageStorageBucket bucket = PageStorageBucket();
  Widget get currentScreen => _widgetOptions[_selectedIndex.value];

  void onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  void onInit() {
    initController();
    super.onInit();
  }



  void initController() {
    Get.put(MessagePageController(), permanent: true);
    _messageController = Get.find<MessagePageController>();
    Get.put(NotifyPageController(), permanent: true);
    _notifyController = Get.find<NotifyPageController>();
    Get.put(SuggestPackageController(), permanent: true);
    _suggestPackageController = Get.find<SuggestPackageController>();
    Get.put(ProfilePageController(), permanent: true);
    _profileController = Get.find<ProfilePageController>();
    Get.put(PackageController(), permanent: true);
    _packageController = Get.find<PackageController>();
  }
}
