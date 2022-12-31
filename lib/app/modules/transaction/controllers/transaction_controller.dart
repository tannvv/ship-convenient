import 'package:convenient_way/app/core/utils/auth_service.dart';
import 'package:convenient_way/app/data/models/transaction_model.dart';
import 'package:convenient_way/app/data/repository/request_model/transaction_list_model.dart';
import 'package:convenient_way/app/data/repository/transaction_req.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
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

  void fetchTransactions() {
    String accountId = AuthService.instance.account!.id!;
    TransactionListModel model = TransactionListModel(accountId: accountId);
    _transactionRepo
        .getList(model)
        .then((response) => transactions.value = response);
  }
}
