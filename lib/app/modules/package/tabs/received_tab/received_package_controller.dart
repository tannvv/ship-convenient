import 'package:convenient_way/app/core/base/base_paging_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/utils/alert_quick_service.dart';
import 'package:convenient_way/app/core/utils/material_dialog_service.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceivedPackageController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  Future<void> accountConfirmPackage(String packageId) async {
    MaterialDialogService.showConfirmDialog(
        msg: 'Bạn chắc chắn muốn nhận gói hàng này để đi giao?',
        onConfirmTap: () {
          AccountPickUpModel model = AccountPickUpModel(
              deliverId: AuthController.instance.account!.id!,
              packageIds: [packageId]);
          _packageRepo.accountConfirmPackage(model).then((response) {
            MotionToastService.showSuccess('Đã lấy hàng để đi giao');
            onRefresh();
          }).catchError((error) {
            MotionToastService.showError(error.messages[0]);
          });
        });
  }

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthController.instance.account!.id,
        status: PackageStatus.DELIVER_PICKUP,
        pageSize: pageSize,
        pageIndex: pageIndex);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }

  Future<void> reportPackage(String packageId) async {
    await MaterialDialogService.showDeleteDialog(
        title: 'Báo xấu',
        msg: 'Bạn chắc chắn muốn báo xấu và hủy gói hàng này?',
        confirmIconData: Icons.check,
        onConfirmTap: () async {
          Get.back(); // close dialog
          dynamic result = await Get.toNamed(Routes.CANCEL_PACKAGE,
              arguments: {'packageId': packageId});
          if (result != null && result == true) {
            await QuickAlertService.showSuccess('Huỷ gói hàng thành công',
                duration: 3);
            onRefresh();
          }
          // Future<SimpleResponseModel> future =
          //     _packageRepo.deliverCancel(packageId);
          // await callDataService<SimpleResponseModel>(future,
          //     onSuccess: (res) async {
          //   Get.back(); // close dialog
          //   await MotionToastService.showSuccess(
          //       res.message ?? 'Đã hủy gói hàng');
          //   onRefresh();
          // }, onError: (exception) {
          //   if (exception is BaseException) {
          //     MotionToastService.showError(exception.message);
          //   }
          // });
        });
  }
}