import 'package:convenient_way/app/core/base/base_repository.dart';
import 'package:convenient_way/app/data/models/shipper_model.dart';
import 'package:convenient_way/app/data/repository/shipper_req.dart';
import 'package:convenient_way/app/network/dio_provider.dart';

class ShipperReqImp extends BaseRepository implements ShipperRep {
  @override
  Future<String> login(String userName, String password) {
    String endpoint = '${DioProvider.baseUrl}/authorizes';
    Map<String, dynamic> data = {'userName': userName, 'password': password};
    Map<String, dynamic> queryParams = {'isShipper': true};
    var dioCall =
        dioClient.post(endpoint, data: data, queryParameters: queryParams);
    try {
      return callApi(dioCall)
          .then((response) => response.data['data']['token']);
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
}
