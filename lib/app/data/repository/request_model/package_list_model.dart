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
      this.pageIndex = 0,
      this.pageSize = 20});

  Map<String, dynamic> toJson() => {
        'shipperId': shipperId,
        'shopId': shopId,
        'status': status,
        'pageIndex': pageIndex,
        'pageSize': pageSize
      };
}
