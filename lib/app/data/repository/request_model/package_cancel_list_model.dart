import 'package:convenient_way/app/core/values/app_values.dart';

class PackageCancelListModel {
  String? deliverId;
  int? pageIndex;
  int? pageSize;

  PackageCancelListModel(
      {this.deliverId,
        this.pageIndex = AppValues.defaultPageIndex,
        this.pageSize = AppValues.defaultPageSize});

  Map<String, dynamic> toJson() => {
    'deliverId': deliverId,
    'pageIndex': pageIndex,
    'pageSize': pageSize
  };
}
