import 'package:get/get.dart';

import '../modules/create-route/bindings/create_route_binding.dart';
import '../modules/create-route/views/create_route_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/package/bindings/package_binding.dart';
import '../modules/package/views/package_view.dart';
import '../modules/pick_up_location/bindings/pick_up_location_binding.dart';
import '../modules/pick_up_location/views/pick_up_location_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/suggest_package_detail/bindings/suggest_package_detail_binding.dart';
import '../modules/suggest_package_detail/views/suggest_package_detail_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/verify-otp/bindings/verify_otp_binding.dart';
import '../modules/verify-otp/views/verify_otp_view.dart';

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
        binding: SuggestPackageDetailBinding()),
    GetPage(
      name: _Paths.PACKAGE,
      page: () => const PackageView(),
      binding: PackageBinding(),
    ),
    GetPage(
        name: _Paths.TRANSACTION,
        page: () => const TransactionView(),
        binding: TransactionBinding(),
        transition: Transition.rightToLeft),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_ROUTE,
      page: () => const CreateRouteView(),
      binding: CreateRouteBinding(),
    ),
  ];
}
