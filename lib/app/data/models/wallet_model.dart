class Wallet {
  String? id;
  double? balance;
  String? walletType;
  String? status;
  String? description;
  String? modifiedAt;

  Wallet(
      {this.id,
      this.balance,
      this.walletType,
      this.status,
      this.description,
      this.modifiedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    balance = json['balance'];
    walletType = json['walletType'];
    status = json['status'];
    description = json['description'];
    modifiedAt = json['modifiedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['balance'] = balance;
    data['walletType'] = walletType;
    data['status'] = status;
    data['description'] = description;
    data['modifiedAt'] = modifiedAt;
    return data;
  }
}
