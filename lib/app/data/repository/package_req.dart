import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';

abstract class PackageReq {
  Future<List<SuggestPackage>> getSuggestPackage(
      SuggestPackageRequestModel model);
  Future<List<Package>> getList(PackageListModel model);
  Future<SimpleResponseModel> pickUpPackage(AccountPickUpModel model);
  Future<SimpleResponseModel> accountConfirmPackage(AccountPickUpModel model);
  Future<SimpleResponseModel> deliverySuccess(String packageId);
  Future<SimpleResponseModel> deliveryFailed(String packageId);
}
