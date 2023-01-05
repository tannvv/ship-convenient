class ResponseGoong {
  String? name;
  String? placeId;
  double? longitude;
  double? latitude;

  ResponseGoong({this.name, this.placeId, this.longitude, this.latitude});

  ResponseGoong.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    placeId = json['placeId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['placeId'] = placeId;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}
