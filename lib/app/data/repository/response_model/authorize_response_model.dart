import 'package:convenient_way/app/data/models/shipper_model.dart';

class AuthorizeResponseModel {
  String? token;
  Shipper? shipper;

  AuthorizeResponseModel({this.shipper, this.token});
}
