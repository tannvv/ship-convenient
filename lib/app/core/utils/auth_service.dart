import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/response_model/authorize_response_model.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService extends BaseController {
  static final AuthService _instance = AuthService._internal();
  static AuthService get instance => _instance;
  AuthService._internal();

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());

  String? _token;
  Account? _account;

  Account? get account => _account;
  set setAccount(Account value) {
    _account = value;
  }

  String? get token {
    if (_token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(_token.toString());

      DateTime? exp =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      if (exp.compareTo(DateTime.now()) <= 0) {
        _token = null;
      }
    }
    return _token;
  }

  static String? getKeyToken(String key) {
    String? result;
    String? token = AuthService._instance._token;
    if (token != null) {
      Map<String, dynamic> payload = Jwt.parseJwt(token.toString());
      result = payload[key];
    }
    return result;
  }

  static Future<bool> login(userName, password) async {
    bool result = false;
    try {
      String? token;
      var loginService = _instance._accountRepo.login(userName, password);
      await _instance.callDataService(loginService,
          onSuccess: (AuthorizeResponseModel response) {
        token = response.token;
        instance._account = response.account;
      }, onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError((exception).message);
        }
      });

      if (token != null) {
        _instance._token = token;
        result = true;
        if (_instance._account?.status == "NO_ROUTE") {
          Get.toNamed(Routes.CREATE_ROUTE);
        } else {
          Get.toNamed(Routes.HOME);
        }
      }
    } catch (e) {
      debugPrint('Unable to connect');
    }
    return result;
  }

  static Future<void> logout() async {
    AuthService.clearToken();
    Get.offAndToNamed(Routes.LOGIN);
  }

  static void clearToken() {
    _instance._token = null;
  }
}
