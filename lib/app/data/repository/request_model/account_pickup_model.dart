class AccountPickUpModel {
  String accountId;
  List<String> packageIds;

  AccountPickUpModel({
    required this.accountId,
    required this.packageIds,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['packageIds'] = packageIds;
    return data;
  }
}
