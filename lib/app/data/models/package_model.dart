import 'package:convenient_way/app/data/models/account_model.dart';
import 'package:convenient_way/app/data/models/product_model.dart';

class Package {
  String? id;
  String? startAddress;
  double? startLongitude;
  double? startLatitude;
  String? destinationAddress;
  double? destinationLongitude;
  double? destinationLatitude;
  String? receiverName;
  String? receiverPhone;
  double? distance;
  double? volume;
  double? weight;
  String? status;
  int? priceShip;
  String? photoUrl;
  String? note;
  String? createdAt;
  String? modifiedAt;
  String? senderId;
  Account? sender;
  String? deliverId;
  Account? deliver;
  List<Product>? products;

  Package(
      {this.id,
      this.startAddress,
      this.startLongitude,
      this.startLatitude,
      this.destinationAddress,
      this.destinationLongitude,
      this.destinationLatitude,
      this.receiverName,
      this.receiverPhone,
      this.distance,
      this.volume,
      this.weight,
      this.status,
      this.priceShip,
      this.photoUrl,
      this.note,
      this.createdAt,
      this.modifiedAt,
      this.senderId,
      this.sender,
      this.deliverId,
      this.deliver});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAddress = json['startAddress'];
    startLongitude = json['startLongitude'];
    startLatitude = json['startLatitude'];
    destinationAddress = json['destinationAddress'];
    destinationLongitude = json['destinationLongitude'];
    destinationLatitude = json['destinationLatitude'];
    receiverName = json['receiverName'];
    receiverPhone = json['receiverPhone'];
    distance = json['distance'];
    volume = json['volume'];
    weight = json['weight'];
    status = json['status'];
    priceShip = json['priceShip'];
    photoUrl = json['photoUrl'];
    note = json['note'];
    createdAt = json['createdAt'];
    modifiedAt = json['modifiedAt'];
    senderId = json['senderId'];
    sender = json['sender'] == null ? null : Account.fromJson(json['sender']);
    deliverId = json['deliverId'];
    deliver =
        json['deliver'] == null ? null : Account.fromJson(json['deliver']);
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['startAddress'] = startAddress;
    data['startLongitude'] = startLongitude;
    data['startLatitude'] = startLatitude;
    data['destinationAddress'] = destinationAddress;
    data['destinationLongitude'] = destinationLongitude;
    data['destinationLatitude'] = destinationLatitude;
    data['receiverName'] = receiverName;
    data['receiverPhone'] = receiverPhone;
    data['distance'] = distance;
    data['volume'] = volume;
    data['weight'] = weight;
    data['status'] = status;
    data['priceShip'] = priceShip;
    data['photoUrl'] = photoUrl;
    data['note'] = note;
    data['createdAt'] = createdAt;
    data['modifiedAt'] = modifiedAt;
    data['senderId'] = senderId;
    data['sender'] = sender;
    data['deliverId'] = deliverId;
    data['deliver'] = deliver;
    if (products != null) {
      data['products'] = products?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
