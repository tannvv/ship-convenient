import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/route_model.dart';
import 'package:convenient_way/app/data/repository/request_model/create_account_model.dart';
import 'package:convenient_way/app/data/repository/request_model/create_route_model.dart';
import 'package:convenient_way/app/data/repository/response_model/authorize_response_model.dart';

abstract class AccountRep {
  Future<AuthorizeResponseModel> login(String userName, String password);
  Future<Account?> getAccountId(String id);
  Future<Account?> create(CreateAccountModel model);
  Future<RouteAcc?> createRoute(CreateRoute createRoute);
}
