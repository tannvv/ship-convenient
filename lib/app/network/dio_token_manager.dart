import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class TokenManager extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? token = AuthController.instance.token;
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    var response = err.response;
    if (response?.statusCode == 401) {
      AuthController.clearToken();
      Get.offAllNamed(Routes.LOGIN);
    }
    super.onError(err, handler);
  }
}
