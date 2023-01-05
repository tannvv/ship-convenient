class AccountPickUpModel {
  String deliverId;
  List<String> packageIds;

  AccountPickUpModel({
    required this.deliverId,
    required this.packageIds,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['deliverId'] = deliverId;
    data['packageIds'] = packageIds;
    return data;
  }
}
