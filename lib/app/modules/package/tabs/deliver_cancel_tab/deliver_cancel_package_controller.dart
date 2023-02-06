import 'package:convenient_way/app/core/base/base_paging_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/data/constants/package_status.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:get/get.dart';

class DeliverCancelPackageController extends BasePagingController<Package>
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());

  @override
  Future<void> fetchDataApi() async {
    PackageListModel requestModel = PackageListModel(
        deliverId: AuthController.instance.account!.id,
        status: PackageStatus.DELIVER_CANCEL,
        pageIndex: pageIndex,
        pageSize: pageSize);
    Future<List<Package>> future = _packageRepo.getList(requestModel);
    await callDataService<List<Package>>(future,
        onSuccess: onSuccess, onError: onError);
  }
}
