import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/account_req_imp.dart';
import 'package:convenient_way/app/data/repository/goong_req.dart';
import 'package:convenient_way/app/data/repository/goong_req_imp.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/package_req_imp.dart';
import 'package:convenient_way/app/data/repository/transaction_req.dart';
import 'package:convenient_way/app/data/repository/transaction_req_imp.dart';
import 'package:get/get.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountRep>(() => AccountReqImp(),
        tag: (AccountRep).toString(), fenix: true);
    Get.lazyPut<PackageReq>(() => PackageReqImp(),
        tag: (PackageReq).toString(), fenix: true);
    Get.lazyPut<TransactionReq>(() => TransactionReqImp(),
        tag: (TransactionReq).toString(), fenix: true);
    Get.lazyPut<GoongReq>(() => GoongReqImp(),
        tag: (GoongReq).toString(), fenix: true);
  }
}
