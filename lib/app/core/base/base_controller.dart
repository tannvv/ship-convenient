// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_local_variable

import 'dart:async';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '/app/network/exceptions/api_exception.dart';
import '/app/network/exceptions/app_exception.dart';
import '/app/network/exceptions/json_format_exception.dart';
import '/app/network/exceptions/network_exception.dart';
import '/app/network/exceptions/not_found_exception.dart';
import '/app/network/exceptions/service_unavailable_exception.dart';
import '/app/network/exceptions/unauthorize_exception.dart';
import '../../../config/build_config.dart';

abstract class BaseController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  final logoutController = false.obs;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  showLoading() => _isLoading.value = true;

  hideLoading() => _isLoading.value = false;

  dynamic callDataService<T>(
    Future<T> future, {
    Function(Exception exception)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
  }) async {
    Exception? _exception;

    onStart == null ? showLoading() : onStart();

    try {
      final T response = await future;

      if (onSuccess != null) onSuccess(response);

      onComplete == null ? hideLoading() : onComplete();

      return response;
    } on ServiceUnavailableException catch (exception) {
      _exception = exception;
    } on UnauthorizedException catch (exception) {
      _exception = exception;
    } on TimeoutException catch (exception) {
      _exception = exception;
    } on NetworkException catch (exception) {
      _exception = exception;
    } on JsonFormatException catch (exception) {
      _exception = exception;
    } on NotFoundException catch (exception) {
      _exception = exception;
    } on ApiException catch (exception) {
      _exception = exception;
    } on AppException catch (exception) {
      _exception = exception;
    } catch (error) {
      _exception = AppException(message: "$error");
      logger.e("Controller>>>>>> error $error");
    }
    if (onError != null) onError(_exception);

    onComplete == null ? hideLoading() : onComplete();
  }
}
