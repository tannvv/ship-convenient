import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/cancel_package_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CancelPackageController extends BaseController {
  String packageId = Get.arguments['packageId'];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textCtrl = TextEditingController();

  final PackageReq _packageReq = Get.find(tag: (PackageReq).toString());

  Future<void> cancelPackage() async {
    if (formKey.currentState!.validate()) {
      CancelPackageModel model =
          CancelPackageModel(packageId: packageId, reason: textCtrl.text);
      Future<SimpleResponseModel> future = _packageReq.deliverCancel(model);
      await callDataService(future, onSuccess: (response) {
        Get.back(result: true);
      }, onError: ((exception) {
        if (exception is BaseException) {
          MotionToastService.showError(exception.message);
        }
      }));
    }
  }
}
