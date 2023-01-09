import 'package:convenient_way/app/core/base/base_controller.dart';
import 'package:convenient_way/app/core/controllers/auth_controller.dart';
import 'package:convenient_way/app/core/utils/motion_toast_service.dart';
import 'package:convenient_way/app/data/models/transaction_model.dart';
import 'package:convenient_way/app/data/repository/request_model/transaction_list_model.dart';
import 'package:convenient_way/app/data/repository/transaction_req.dart';
import 'package:convenient_way/app/network/exceptions/base_exception.dart';
import 'package:get/get.dart';

class TransactionController extends BaseController {
  final transactions = <Transaction>[].obs;

  final TransactionReq _transactionRepo =
      Get.find(tag: (TransactionReq).toString());
  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    String accountId = AuthController.instance.account!.id!;
    TransactionListModel model = TransactionListModel(accountId: accountId);
    Future<List<Transaction>> future = _transactionRepo.getList(model);
    await callDataService<List<Transaction>>(future, onSuccess: (response) {
      transactions.value = response;
    }, onError: ((exception) {
      if (exception is BaseException) {
        MotionToastService.showError(exception.message);
      }
    }));
  }
}
