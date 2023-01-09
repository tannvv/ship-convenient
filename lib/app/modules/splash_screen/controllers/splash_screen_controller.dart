import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/data/constants/account_status.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  Future<String> screenRouteFunction() async {
    Account? account = await AuthController.isLoginBefore();
    if (account != null) {
      return account.status == AccountStatus.noRoute
          ? Routes.CREATE_ROUTE
          : Routes.HOME;
    }
    return Routes.LOGIN;
  }
}
