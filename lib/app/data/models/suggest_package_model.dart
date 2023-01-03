import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/package_model.dart';

class SuggestPackage {
  List<Package>? packages;
  Account? sender;
  double? time;
  double? distance;
  int? comboPrice;

  SuggestPackage(
      {this.packages, this.sender, this.time, this.distance, this.comboPrice});

  SuggestPackage.fromJson(Map<String, dynamic> json) {
    if (json['packages'] != null) {
      packages = <Package>[];
      json['packages'].forEach((v) {
        packages?.add(Package.fromJson(v));
      });
    }
    sender = json['sender'] != null ? Account?.fromJson(json['sender']) : null;
    time = json['time'];
    distance = json['distance'];
    comboPrice = json['comboPrice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (packages != null) {
      data['packages'] = packages?.map((v) => v.toJson()).toList();
    }
    if (sender != null) {
      data['sender'] = sender?.toJson();
    }
    data['time'] = time;
    data['distance'] = distance;
    data['comboPrice'] = comboPrice;
    return data;
  }
}