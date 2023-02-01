import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:uuid/uuid.dart';

class TransactionListModel {
  String? accountId;
  String? from;
  String? to;
  int? pageIndex;
  int? pageSize;

  TransactionListModel(
      {this.accountId = Uuid.NAMESPACE_NIL,
      this.from,
      this.to,
      this.pageIndex = AppValues.defaultPageIndex,
      this.pageSize = AppValues.defaultPageSize});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['accountId'] = accountId;
    data['from'] = from;
    data['to'] = to;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}
