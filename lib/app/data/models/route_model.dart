class Route {
  String? fromAddress;
  double? fromLongitude;
  double? fromLatitude;
  String? toAddress;
  double? toLongitude;
  double? toLatitude;
  bool? isActive;
  String? shipperId;

  Route(
      {this.fromAddress,
      this.fromLongitude,
      this.fromLatitude,
      this.toAddress,
      this.toLongitude,
      this.toLatitude,
      this.isActive,
      this.shipperId});

  Route.fromJson(Map<String, dynamic> json) {
    fromAddress = json['fromAddress'];
    fromLongitude = json['fromLongitude'];
    fromLatitude = json['fromLatitude'];
    toAddress = json['toAddress'];
    toLongitude = json['toLongitude'];
    toLatitude = json['toLatitude'];
    isActive = json['isActive'];
    shipperId = json['shipperId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromAddress'] = fromAddress;
    data['fromLongitude'] = fromLongitude;
    data['fromLatitude'] = fromLatitude;
    data['toAddress'] = toAddress;
    data['toLongitude'] = toLongitude;
    data['toLatitude'] = toLatitude;
    data['isActive'] = isActive;
    data['shipperId'] = shipperId;
    return data;
  }
}
