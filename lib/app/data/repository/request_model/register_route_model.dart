class RegisterRoute {
  String? fromAddress;
  double? fromLongitude;
  double? fromLatitude;
  String? toAddress;
  double? toLongitude;
  double? toLatitude;
  String? shipperId;

  RegisterRoute(
      {required this.fromAddress,
      required this.fromLongitude,
      required this.fromLatitude,
      required this.toAddress,
      required this.toLongitude,
      required this.toLatitude,
      required this.shipperId});

  RegisterRoute.fromJson(Map<String, dynamic> json) {
    fromAddress = json['fromAddress'];
    fromLongitude = json['fromLongitude'];
    fromLatitude = json['fromLatitude'];
    toAddress = json['toAddress'];
    toLongitude = json['toLongitude'];
    toLatitude = json['toLatitude'];
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
    data['shipperId'] = shipperId;
    return data;
  }
}
