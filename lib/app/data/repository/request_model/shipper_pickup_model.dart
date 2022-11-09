
class ShipperPickUpModel {
  String shipperId;
  List<String> packageIds;
  String walletType;

  ShipperPickUpModel(
      {required this.shipperId,
      required this.packageIds,
      this.walletType = 'DEFAULT'});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['shipperId'] = shipperId;
    data['packageIds'] = packageIds;
    data['walletType'] = walletType;
    return data;
  }
}
