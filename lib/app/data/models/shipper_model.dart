import 'package:convenient_way/app/data/models/wallet_model.dart';

class Shipper {
  String? id;
  String? userName;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  String? status;
  String? address;
  double? homeLongitude;
  double? homeLatitude;
  double? destinationLongitude;
  double? destinationLatitude;
  String? createdAt;
  String? modifiedAt;
  List<Wallet>? wallets;

  Shipper(
      {this.id,
      this.userName,
      this.email,
      this.displayName,
      this.phoneNumber,
      this.photoUrl,
      this.status,
      this.address,
      this.homeLongitude,
      this.homeLatitude,
      this.destinationLongitude,
      this.destinationLatitude,
      this.createdAt,
      this.modifiedAt,
      this.wallets});

  Shipper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    displayName = json['displayName'];
    phoneNumber = json['phoneNumber'];
    photoUrl = json['photoUrl'];
    status = json['status'];
    address = json['address'];
    homeLongitude = json['homeLongitude'];
    homeLatitude = json['homeLatitude'];
    destinationLongitude = json['destinationLongitude'];
    destinationLatitude = json['destinationLatitude'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    if (json['wallets'] != null) {
      wallets = <Wallet>[];
      json['wallets'].forEach((v) {
        wallets?.add(Wallet.fromJson(v));
      });
    }
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
    data['homeLongitude'] = homeLongitude;
    data['homeLatitude'] = homeLatitude;
    data['destinationLongitude'] = destinationLongitude;
    data['destinationLatitude'] = destinationLatitude;
    data['createdAt'] = createdAt;
    data['modifiedAt'] = modifiedAt;
    if (wallets != null) {
      data['wallets'] = wallets?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
