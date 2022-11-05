import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/data/models/shipper_model.dart';
import 'package:convenient_way/app/data/repository/shipper_req.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthService extends BaseController {
  static final AuthService _instance = AuthService._internal();
  static AuthService get instance => _instance;
  AuthService._internal();

  final ShipperRep _shipperRepo = Get.find(tag: (ShipperRep).toString());

  String? _token;
  Shipper? _shipper;

  Shipper? get shipper => _shipper;

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
      var loginService = _instance._shipperRepo.login(userName, password);
      await _instance.callDataService(loginService,
          onSuccess: (String response) {
        token = response;
      });

      if (token != null) {
        _instance._token = token;
        result = true;
        String? shipperId = AuthService.getKeyToken('id');
        debugPrint('Shipper id: $shipperId');
        if (shipperId != null) {
          _instance._shipper =
              await _instance._shipperRepo.getShipperId(shipperId);
        }
        Get.toNamed(Routes.HOME);
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
