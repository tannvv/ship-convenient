import 'package:convenient_way/app/core/base/base_repository.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:convenient_way/app/data/repository/package_req.dart';
import 'package:convenient_way/app/data/repository/request_model/account_pickup_model.dart';
import 'package:convenient_way/app/data/repository/request_model/cancel_package_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_list_model.dart';
import 'package:convenient_way/app/data/repository/request_model/package_cancel_list_model.dart';
import 'package:convenient_way/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
import 'package:convenient_way/app/network/dio_provider.dart';

class PackageReqImp extends BaseRepository implements PackageReq {
  @override
  Future<List<SuggestPackage>> getSuggestPackage(
      SuggestPackageRequestModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/combos';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<SuggestPackage> data = (response.data['data'] as List)
            .map((e) => SuggestPackage.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Package>> getList(PackageListModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<Package> data = (response.data['data'] as List)
            .map((e) => Package.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }


  @override
  Future<List<Package>> getListCancel(PackageCancelListModel model) {
    String endpoint = '${DioProvider.baseUrl}/transactionpackages/deliver-cancel';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<Package> data = (response.data['data'] as List)
            .map((e) => Package.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> pickUpPackage(AccountPickUpModel model) async {
    String endpoint = '${DioProvider.baseUrl}/packages/deliver-pickup';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliveryFailed(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/delivery-failed';
    var dioCall = dioClient.put(endpoint, data: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliverySuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/delivery-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> accountConfirmPackage(AccountPickUpModel model) {
    String endpoint =
        '${DioProvider.baseUrl}/packages/deliver-confirm-packages';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliverCancel(CancelPackageModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/deliver-cancel';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
