import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/shop_model.dart';

class SuggestPackage {
  Shop? shop;
  double? time;
  double? distance;
  double? compoPrice;
  List<Package>? packages;

  SuggestPackage(
      {this.shop, this.time, this.distance, this.compoPrice, this.packages});

  SuggestPackage.fromJson(Map<String, dynamic> json) {
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
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
