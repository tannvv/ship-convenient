import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/data/repository/request_model/shipper_pickup_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';

abstract class PackageReq {
  Future<List<SuggestPackage>> getSuggestPackage(String shipperId);
  Future<List<Package>> getList(PackageListModel model);
  Future<SimpleResponseModel> pickUpPackage(ShipperPickUpModel model);
  Future<SimpleResponseModel> shipperConfirmPackage(ShipperPickUpModel model);
  Future<SimpleResponseModel> deliverySuccess(String packageId);
  Future<SimpleResponseModel> deliveryFailed(String packageId);
}
