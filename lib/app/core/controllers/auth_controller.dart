import 'dart:convert';

import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/data/local/preference/preference_manager.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/response_model/authorize_response_model.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends BaseController {
  AuthController();
  static final AuthController _instance = AuthController._internal();
  static AuthController get instance => _instance;
  AuthController._internal();

  final AccountRep _accountRepo = Get.find(tag: (AccountRep).toString());

  String? _token;
  Account? _account;

  Account? get account => _account;
  set setAccount(Account value) {
    _account = value;
  }

  String? get token {
    if (!isTokenValidDateTime(_token)) {
      return null;
    }
    return _token;
  }

  bool isTokenValidDateTime(String? token) {
    if (token == null) return false;
    Map<String, dynamic> payload = Jwt.parseJwt(_token.toString());
    DateTime? exp = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    if (exp.compareTo(DateTime.now()) <= 0) {
      return false;
    }
    return true;
  }

  static String? getKeyToken(String key) {
    String? result;
    String? token = AuthController._instance._token;
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
          onSuccess: (AuthorizeResponseModel response) async {
        token = response.token;
        instance._account = response.account;
        PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
        prefs.setString('token', token!);
        prefs.setString('userJson', jsonEncode(response.account));
      }, onError: (exception) {
        if (exception is BaseException) {
          MotionToastService.showError((exception).message);
        }
      });

      if (token != null) {
        _instance._token = token;
        result = true;
        if (_instance._account?.status == "NO_ROUTE") {
          Get.offAndToNamed(Routes.CREATE_ROUTE);
        } else {
          Get.offAndToNamed(Routes.HOME);
        }
      }
    } catch (e) {
      debugPrint('Unable to connect');
    }
    return result;
  }

  static Future<Account?> isLoginBefore() async {
    PreferenceManager prefs = Get.find(tag: (PreferenceManager).toString());
    String? token = await prefs.getString('token');
    if (token.isNotEmpty) {
      _instance._token = token;
      String? userJson = await prefs.getString('userJson');
      if (userJson.isNotEmpty) {
        _instance._account = Account.fromJson(jsonDecode(userJson));
        return _instance._account;
      }
    }
    return null;
  }

  static Future<void> logout() async {
    await AuthController.clearToken();
    Get.offAllNamed(Routes.LOGIN);
  }

  static Future<void> clearToken() async {
    _instance._token = null;
    _instance._account = null;
    await SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
      prefs.remove('userJson');
    });
  }
}
