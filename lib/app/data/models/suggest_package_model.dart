import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/package_model.dart';

class SuggestPackage {
  Account? sender;
  double? time;
  double? distance;
  double? compoPrice;
  List<Package>? packages;

  SuggestPackage(
      {this.sender, this.time, this.distance, this.compoPrice, this.packages});

  SuggestPackage.fromJson(Map<String, dynamic> json) {
    sender = json['sender'] != null ? Account.fromJson(json['sender']) : null;
    time = json['time'];
    distance = json['distance'];
    compoPrice = json['comboPrice'];
    if (json['packages'] != null) {
      packages = <Package>[];
      json['packages'].forEach((v) {
        packages?.add(Package.fromJson(v));
      });
    }
  }
}
