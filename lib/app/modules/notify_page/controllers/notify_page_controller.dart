import 'package:convenient_way/app/core/base/base_paging_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/utils/datetime_utils.dart';
import 'package:convenient_way/app/data/models/notification_model.dart';
import 'package:convenient_way/app/data/repository/account_req.dart';
import 'package:convenient_way/app/data/repository/request_model/notification_list_model.dart';
import 'package:get/get.dart';

class NotifyPageController extends BasePagingController<NotificationModel> {
  final AccountRep _accountRep = Get.find(tag: (AccountRep).toString());
  @override
  Future<void> fetchDataApi() async {
    NotificationListModel model = NotificationListModel();
    model.accountId = AuthController.instance.account!.id;
    model.pageIndex = pageIndex;
    model.pageSize = pageSize;
    var future = _accountRep.getNotifications(model);
    callDataService<List<NotificationModel>>(future, onSuccess: (response) {
      super.onSuccess(response);
      bool flag = false;
      for (NotificationModel item in dataApis) {
        if (DateTimeUtils.compare(item.createdAt, DateTime.now()) &&
            flag == false) {
          item.filter = 0;
          flag = true;
        } else if (!DateTimeUtils.compare(item.createdAt, DateTime.now()) &&
            flag == true) {
          item.filter = 1;
          break;
        }
      }
    }, onError: onError);
  }
}
