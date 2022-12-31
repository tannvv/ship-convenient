import 'package:uuid/uuid.dart';

class TransactionListModel {
  String? accountId;
  String? shopId;
  String? from;
  String? to;
  int? pageIndex;
  int? pageSize;

  TransactionListModel(
      {this.accountId = Uuid.NAMESPACE_NIL,
      this.shopId = Uuid.NAMESPACE_NIL,
      this.from,
      this.to,
      this.pageIndex = 0,
      this.pageSize = 20});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['accountId'] = accountId;
    data['shopId'] = shopId;
    data['from'] = from;
    data['to'] = to;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}
