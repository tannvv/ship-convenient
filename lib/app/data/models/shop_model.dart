class Shop {
  String? id;
  String? userName;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  String? status;
  String? address;
  double? longitude;
  double? latitude;
  String? createdAt;
  String? modifiedAt;

  Shop(
      {this.id,
      this.userName,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.photoUrl,
      this.status,
      this.address,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.modifiedAt});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['displayName'] = displayName;
    data['phoneNumber'] = phoneNumber;
    data['photoUrl'] = photoUrl;
    data['status'] = status;
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['createdAt'] = createdAt;
    data['modifiedAt'] = modifiedAt;
    return data;
  }
}
