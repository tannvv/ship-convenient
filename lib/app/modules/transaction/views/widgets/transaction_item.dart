import 'package:convenient_way/app/data/models/transaction_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({Key? key, required this.item}) : super(key: key);
  final Transaction item;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Nội dung : ${item.description}'),
        Text('Loại: ${item.transactionType}'),
        Text('Số tiền: ${item.coinExchange}'),
        Text('Số dư còn lại: ${item.balanceWallet}'),
        Text('Tạo vào lúc: ${item.createdAt}')
      ],
    );
  }
}
