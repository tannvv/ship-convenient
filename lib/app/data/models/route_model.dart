class RouteAcc {
  String? id;
  String? fromName;
  double? fromLongitude;
  double? fromLatitude;
  String? toName;
  double? toLongitude;
  double? toLatitude;
  bool? isActive;
  String? infoUserId;

  RouteAcc(
      {this.id,
      this.fromName,
      this.fromLongitude,
      this.fromLatitude,
      this.toName,
      this.toLongitude,
      this.toLatitude,
      this.isActive,
      this.infoUserId});

  RouteAcc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromName = json['fromName'];
    fromLongitude = json['fromLongitude'];
    fromLatitude = json['fromLatitude'];
    toName = json['toName'];
    toLongitude = json['toLongitude'];
    toLatitude = json['toLatitude'];
    isActive = json['isActive'];
    infoUserId = json['infoUserId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['fromName'] = fromName;
    data['fromLongitude'] = fromLongitude;
    data['fromLatitude'] = fromLatitude;
    data['toName'] = toName;
    data['toLongitude'] = toLongitude;
    data['toLatitude'] = toLatitude;
    data['isActive'] = isActive;
    data['infoUserId'] = infoUserId;
    return data;
  }
}
