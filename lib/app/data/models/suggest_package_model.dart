import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:convenient_way/app/data/models/product_model.dart';

class SuggestPackage {
  Account? sender;
  double? time;
  double? distance;
  int? compoPrice;
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

  String getProductsName() {
    String products = '';
    for (int i = 0; i < packages!.length; i++) {
      for (var j = 0; j < packages![i].products!.length; j++) {
        List<Product> productApi = packages![i].products!;
        products += '${productApi[j].name!}, ';
      }
    }
    products = products.substring(0, products.length - 2);
    return products;
  }
}
