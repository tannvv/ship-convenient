import 'package:convenient_way/app/core/values/app_values.dart';
import 'package:uuid/uuid.dart';

class PackageListModel {
  String? shipperId;
  String? shopId;
  String? status;
  int? pageIndex;
  int? pageSize;

  PackageListModel(
      {this.shipperId = Uuid.NAMESPACE_NIL,
      this.shopId = Uuid.NAMESPACE_NIL,
      this.status,
      this.pageIndex = AppValues.defaultPageIndex,
      this.pageSize = AppValues.defaultPageSize});

  Map<String, dynamic> toJson() => {
        'shipperId': shipperId,
        'shopId': shopId,
        'status': status,
        'pageIndex': pageIndex,
        'pageSize': pageSize
      };
}
