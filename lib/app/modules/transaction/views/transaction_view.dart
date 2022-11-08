import 'package:convenient_way/app/modules/transaction/views/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử giao dịch'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
            itemBuilder: (_, index) =>
                TransactionItem(item: controller.transactions.value[index]),
            separatorBuilder: (_, index) => const Gap(20),
            itemCount: controller.transactions.value.length),
      ),
    );
  }
}
