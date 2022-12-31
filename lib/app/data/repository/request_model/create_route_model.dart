class CreateRoute {
  String? fromName;
  double? fromLongitude;
  double? fromLatitude;
  String? toName;
  double? toLongitude;
  double? toLatitude;
  String? accountId;

  CreateRoute(
      {this.fromName,
      this.fromLongitude,
      this.fromLatitude,
      this.toName,
      this.toLongitude,
      this.toLatitude,
      this.accountId});

  CreateRoute.fromJson(Map<String, dynamic> json) {
    fromName = json['fromName'];
    fromLongitude = json['fromLongitude'];
    fromLatitude = json['fromLatitude'];
    toName = json['toName'];
    toLongitude = json['toLongitude'];
    toLatitude = json['toLatitude'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['fromName'] = fromName;
    data['fromLongitude'] = fromLongitude;
    data['fromLatitude'] = fromLatitude;
    data['toName'] = toName;
    data['toLongitude'] = toLongitude;
    data['toLatitude'] = toLatitude;
    data['accountId'] = accountId;
    return data;
  }
}
