import 'package:get/get.dart';

import '../modules/cancel_package/bindings/cancel_package_binding.dart';
import '../modules/cancel_package/views/cancel_package_view.dart';
import '../modules/chat_message/bindings/chat_message_binding.dart';
import '../modules/chat_message/views/chat_message_view.dart';
import '../modules/create-route/bindings/create_route_binding.dart';
import '../modules/create-route/views/create_route_view.dart';
import '../modules/feedback_for_deliver/bindings/feedback_for_deliver_binding.dart';
import '../modules/feedback_for_deliver/views/feedback_for_deliver_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/location_package/bindings/location_package_binding.dart';
import '../modules/location_package/views/location_package_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/manage_route/bindings/manage_route_binding.dart';
import '../modules/manage_route/views/manage_route_view.dart';
import '../modules/package/bindings/package_binding.dart';
import '../modules/package/views/package_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/payment_status/bindings/payment_status_binding.dart';
import '../modules/payment_status/views/payment_status_view.dart';
import '../modules/pick_up_location/bindings/pick_up_location_binding.dart';
import '../modules/pick_up_location/views/pick_up_location_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/suggest_package_detail/bindings/suggest_package_detail_binding.dart';
import '../modules/suggest_package_detail/views/suggest_package_detail_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/transaction/views/transaction_view.dart';
import '../modules/verify-otp/bindings/verify_otp_binding.dart';
import '../modules/verify-otp/views/verify_otp_view.dart';
import '../modules/vnpay/bindings/vnpay_binding.dart';
import '../modules/vnpay/views/vnpay_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

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
    GetPage(
      name: _Paths.CHAT_MESSAGE,
      page: () => const ChatMessageView(),
      binding: ChatMessageBinding(),
    ),
    GetPage(
      name: _Paths.CANCEL_PACKAGE,
      page: () => const CancelPackageView(),
      binding: CancelPackageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.VNPAY,
      page: () => const VnpayView(),
      binding: VnpayBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_STATUS,
      page: () => const PaymentStatusView(),
      binding: PaymentStatusBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK_FOR_DELIVER,
      page: () => const FeedbackForDeliverView(),
      binding: FeedbackForDeliverBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION_PACKAGE,
      page: () => const LocationPackageView(),
      binding: LocationPackageBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_ROUTE,
      page: () => const ManageRouteView(),
      binding: ManageRouteBinding(),
    ),
  ];
}
