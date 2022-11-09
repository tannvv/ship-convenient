import 'package:convenient_way/app/data/models/shipper_model.dart';
import 'package:convenient_way/app/data/repository/request_model/register_route_model.dart';
import 'package:convenient_way/app/data/repository/request_model/register_shipper_model.dart';
import 'package:convenient_way/app/data/repository/response_model/authorize_response_model.dart';

abstract class ShipperRep {
  Future<AuthorizeResponseModel> login(String userName, String password);
  Future<Shipper?> getShipperId(String id);
  Future<Shipper?> register(RegisterShipper registerModel);
  Future<Shipper?> registerRoute(RegisterRoute registerRoute);
}
