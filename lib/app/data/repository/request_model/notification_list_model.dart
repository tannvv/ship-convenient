import 'package:convenient_way/app/core/values/app_values.dart';

class NotificationListModel {
  String? accountId;
  int pageIndex;
  int pageSize;

  NotificationListModel(
      {this.accountId,
      this.pageIndex = AppValues.defaultPageIndex,
      this.pageSize = AppValues.defaultPageSize});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountId'] = accountId;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}
