class CancelPackageModel {
  String packageId;
  String reason;

  CancelPackageModel({required this.packageId, required this.reason});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packageId'] = packageId;
    data['reason'] = reason;
    return data;
  }
}
