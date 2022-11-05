import 'package:convenient_way/app/data/models/shipper_model.dart';

abstract class ShipperRep {
  Future<String> login(String userName, String password);
  Future<Shipper?> getShipperId(String id);
}
