class Transaction {
  String? status;
  String? title;
  String? description;
  String? transactionType;
  int? coinExchange;
  int? balanceWallet;
  DateTime? createdAt;
  String? packageId;
  int? filter;

  Transaction(
      {this.status,
      this.title,
      this.description,
      this.transactionType,
      this.coinExchange,
      this.balanceWallet,
      this.createdAt,
      this.packageId});

  Transaction.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    title = json['title'];
    description = json['description'];
    transactionType = json['transactionType'];
    coinExchange = json['coinExchange'];
    balanceWallet = json['balanceWallet'];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    packageId = json['packageId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['title'] = title;
    data['description'] = description;
    data['transactionType'] = transactionType;
    data['coinExchange'] = coinExchange;
    data['balanceWallet'] = balanceWallet;
    data['createdAt'] = createdAt.toString();
    data['packageId'] = packageId;
    return data;
  }
}
