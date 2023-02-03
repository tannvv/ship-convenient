import 'package:convenient_way/app/core/base/base_repository.dart';
import 'package:convenient_way/app/data/models/transaction_model.dart';
import 'package:convenient_way/app/data/repository/request_model/transaction_list_model.dart';
import 'package:convenient_way/app/data/repository/transaction_req.dart';
import 'package:convenient_way/app/network/dio_provider.dart';

class TransactionReqImp extends BaseRepository implements TransactionReq {
  @override
  Future<List<Transaction>> getList(TransactionListModel model) {
    String endpoint = '${DioProvider.baseUrl}/transactions';
    Map<String, dynamic> params = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: params);
    try {
      return callApi(dioCall).then((response) {
        List<Transaction> transactions = (response.data['data'] as List)
            .map((e) => Transaction.fromJson(e))
            .toList();
        return transactions;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Transaction> getId(String id) {
    String endpoint = '${DioProvider.baseUrl}/transactions/$id';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        Transaction transaction = Transaction.fromJson(response.data['data']);
        return transaction;
      });
    } catch (e) {
      rethrow;
    }
  }
}
