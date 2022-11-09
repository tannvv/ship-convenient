import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:get/get.dart';

class ReceivedPackageController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final PackageReq _packageRepo = Get.find(tag: (PackageReq).toString());
}
