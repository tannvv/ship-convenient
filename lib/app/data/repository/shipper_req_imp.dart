import 'package:convenient_way/app/core/base/base_repository.dart';
import 'package:convenient_way/app/data/models/shipper_model.dart';
import 'package:convenient_way/app/data/repository/request_model/register_route_model.dart';
import 'package:convenient_way/app/data/repository/request_model/register_shipper_model.dart';
import 'package:convenient_way/app/data/repository/response_model/authorize_response_model.dart';
import 'package:convenient_way/app/data/repository/shipper_req.dart';
import 'package:convenient_way/app/network/dio_provider.dart';

class ShipperReqImp extends BaseRepository implements ShipperRep {
  @override
  Future<AuthorizeResponseModel> login(String userName, String password) {
    String endpoint = '${DioProvider.baseUrl}/authorizes';
    Map<String, dynamic> data = {'userName': userName, 'password': password};
    Map<String, dynamic> queryParams = {'isShipper': true};
    var dioCall =
        dioClient.post(endpoint, data: data, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        Shipper? shipper = Shipper.fromJson(response.data['data']['shipper']);
        String? token = response.data['data']['token'];
        AuthorizeResponseModel model =
            AuthorizeResponseModel(shipper: shipper, token: token);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Shipper?> getShipperId(String id) {
    String endpoint = '${DioProvider.baseUrl}/shippers/$id';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall)
          .then((response) => Shipper.fromJson(response.data['data']));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Shipper?> register(RegisterShipper registerModel) {
    String endpoint = '${DioProvider.baseUrl}/shippers/register';
    var dioCall = dioClient.post(endpoint, data: registerModel.toJson());
    try {
      return callApi(dioCall).then((response) {
        Shipper? shipper = Shipper.fromJson(response.data['data']);
        return shipper;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Shipper?> registerRoute(RegisterRoute registerRoute) {
    String endpoint = '${DioProvider.baseUrl}/shipperroutes/register';
    var dioCall = dioClient.post(endpoint, data: registerRoute.toJson());
    try {
      return callApi(dioCall).then((response) {
        Shipper? shipper = Shipper.fromJson(response.data['data']);
        return shipper;
      });
    } catch (e) {
      rethrow;
    }
  }
}
