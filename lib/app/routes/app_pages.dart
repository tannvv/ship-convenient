import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/modules/suggest_package/bindings/suggest_package_binding.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/bindings/suggest_package_detail_binding.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/views/suggest_package_detail_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/pick_up_location/bindings/pick_up_location_binding.dart';
import '../modules/pick_up_location/views/pick_up_location_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
        name: _Paths.PICK_UP_LOCATION,
        page: () => const PickUpLocationView(),
        binding: PickUpLocationBinding()),
    GetPage(
        name: _Paths.SUGGEST_PACKAGE_DETAIL,
        page: () => const SuggestPackageDetailView(),
        binding: SuggestPackageDetailBinding())
  ];
}
