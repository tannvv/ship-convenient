import 'package:convenient_way/app/data/models/account_model.dart';

class AuthorizeResponseModel {
  String? token;
  Account? account;

  AuthorizeResponseModel({this.account, this.token});
}
