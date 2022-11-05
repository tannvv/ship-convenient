import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/package_req_imp.dart';
import 'package:convenient_way/app/data/repository/shipper_req.dart';
import 'package:convenient_way/app/data/repository/shipper_req_imp.dart';
import 'package:get/get.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShipperRep>(() => ShipperReqImp(),
        tag: (ShipperRep).toString(), fenix: true);
    Get.lazyPut<PackageReq>(() => PackageReqImp(),
        tag: (PackageReq).toString(), fenix: true);
  }
}
