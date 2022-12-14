import 'package:convenient_way/app/core/base/base_repository.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/route_model.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/request_model/create_account_model.dart';
import 'package:convenient_way/app/data/repository/request_model/create_route_model.dart';
import 'package:convenient_way/app/data/repository/response_model/authorize_response_model.dart';
import 'package:convenient_way/app/network/dio_provider.dart';

class AccountReqImp extends BaseRepository implements AccountRep {
  @override
  Future<Account?> create(CreateAccountModel model) {
    String endpoint = '${DioProvider.baseUrl}/accounts';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        Account? account = Account.fromJson(response.data['data']);
        return account;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Account?> getAccountId(String id) {
    String endpoint = '${DioProvider.baseUrl}/accounts/$id';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        Account? account = Account.fromJson(response.data['data']);
        return account;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthorizeResponseModel> login(String userName, String password) {
    String endpoint = '${DioProvider.baseUrl}/authorizes';
    Map<String, dynamic> data = {'userName': userName, 'password': password};
    var dioCall = dioClient.post(endpoint, data: data);
    try {
      return callApi(dioCall).then((response) {
        Account? account = Account.fromJson(response.data['data']['account']);
        String? token = response.data['data']['token'];
        AuthorizeResponseModel model =
            AuthorizeResponseModel(account: account, token: token);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RouteAcc?> createRoute(CreateRoute createRouteModel) {
    String endpoint = '${DioProvider.baseUrl}/routes';
    var dioCall = dioClient.post(endpoint, data: createRouteModel.toJson());
    try {
      return callApi(dioCall).then((response) {
        RouteAcc? route = RouteAcc.fromJson(response.data['data']);
        return route;
      });
    } catch (e) {
      rethrow;
    }
  }
}
