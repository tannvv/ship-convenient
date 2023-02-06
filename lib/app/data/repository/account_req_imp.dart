import 'package:convenient_way/app/core/base/base_repository.dart';
import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/notification_model.dart';
import 'package:convenient_way/app/data/models/route_model.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/request_model/create_account_model.dart';
import 'package:convenient_way/app/data/repository/request_model/create_route_model.dart';
import 'package:convenient_way/app/data/repository/request_model/login_model.dart';
import 'package:convenient_way/app/data/repository/request_model/notification_list_model.dart';
import 'package:convenient_way/app/data/repository/response_model/authorize_response_model.dart';
import 'package:convenient_way/app/data/repository/response_model/simple_response_model.dart';
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
  Future<AuthorizeResponseModel> login(LoginModel model) {
    String endpoint = '${DioProvider.baseUrl}/authorizes';
    Map<String, dynamic> data = model.toJson();
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

  @override
  Future<List<RouteAcc>> getRoutes(String accountId) {
    String endpoint = '${DioProvider.baseUrl}/routes/$accountId';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        List<RouteAcc> routes = [];
        for (var item in response.data['data']) {
          routes.add(RouteAcc.fromJson(item));
        }
        return routes;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deleteRoute(String id) {
    String endpoint = '${DioProvider.baseUrl}/routes/$id';
    var dioCall = dioClient.delete(endpoint);
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> setActiveRoute(String id) {
    String endpoint = '${DioProvider.baseUrl}/routes/active-route';
    var dioCall = dioClient.put(endpoint, queryParameters: {'id': id});
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> getNotifications(
      NotificationListModel model) {
    String endpoint = '${DioProvider.baseUrl}/notifications';
    var dioCall = dioClient.get(endpoint, queryParameters: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        List<NotificationModel> notifications = [];
        for (var item in response.data['data']) {
          notifications.add(NotificationModel.fromJson(item));
        }
        return notifications;
      });
    } catch (e) {
      rethrow;
    }
  }
}
