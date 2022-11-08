class Transaction {
  String? status;
  String? description;
  String? transactionType;
  double? coinExchange;
  double? balanceWallet;
  String? createdAt;
  String? walletId;
  String? packageId;

  Transaction(
      {this.status,
      this.description,
      this.transactionType,
      this.coinExchange,
      this.balanceWallet,
      this.createdAt,
      this.walletId,
      this.packageId});

  Transaction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    description = json['description'];
    transactionType = json['transactionType'];
    coinExchange = json['coinExchange'];
    balanceWallet = json['balanceWallet'];
    createdAt = json['createdAt'];
    walletId = json['walletId'];
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['description'] = description;
    data['transactionType'] = transactionType;
    data['coinExchange'] = coinExchange;
    data['balanceWallet'] = balanceWallet;
    data['createdAt'] = createdAt;
    data['walletId'] = walletId;
    data['packageId'] = packageId;
    return data;
  }
}
