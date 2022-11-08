import 'package:convenient_way/app/data/models/transaction_model.dart';
import 'package:convenient_way/app/data/repository/request_model/transaction_list_model.dart';

abstract class TransactionReq {
  Future<List<Transaction>> getList(TransactionListModel model);
}
