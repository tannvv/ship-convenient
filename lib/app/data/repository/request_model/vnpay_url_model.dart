class VnpayUrlModel {
  String? ip;
  String? accountId;
  int? amount;

  VnpayUrlModel({this.ip, this.accountId, this.amount});

  VnpayUrlModel.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    accountId = json['accountId'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ip'] = ip;
    data['accountId'] = accountId;
    data['amount'] = amount;
    return data;
  }
}
