import 'package:convenient_way/app/core/values/app_values.dart';

class PackageListModel {
  String? deliverId;
  String? senderId;
  String? status;
  int? pageIndex;
  int? pageSize;

  PackageListModel(
      {this.deliverId,
      this.senderId,
      this.status,
      this.pageIndex = AppValues.defaultPageIndex,
      this.pageSize = AppValues.defaultPageSize});

  Map<String, dynamic> toJson() => {
        'deliverId': deliverId,
        'senderId': senderId,
        'status': status,
        'pageIndex': pageIndex,
        'pageSize': pageSize
      };
}
