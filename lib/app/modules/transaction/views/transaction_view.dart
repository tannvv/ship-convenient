import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/data/models/transaction_model.dart';
import 'package:convenient_way/app/modules/transaction/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
        () => SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          header: const WaterDropMaterialHeader(),
          onRefresh: () => controller.onRefresh(),
          onLoading: () => controller.onLoading(),
          footer: CustomFooterSmartRefresh.defaultCustom(),
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 12.h),
              itemBuilder: (_, index) {
                Transaction? item = controller.dataApis[index];
                if (item.filter == 0) {
                  return Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 18.w, right: 18.w, top: 10.h),
                        child: Row(
                          children: [
                            Text(
                              'Hôm nay',
                              style: h6.copyWith(
                                  color: AppColors.softBlack, fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                      TransactionItem(
                        model: item,
                      ),
                    ],
                  );
                } else if (item.filter == 1) {
                  return Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 18.w, right: 18.w, top: 10.h),
                        child: Row(
                          children: [
                            Text(
                              'Trước đó',
                              style: h6.copyWith(
                                  color: AppColors.softBlack, fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                      TransactionItem(
                        model: item,
                      ),
                    ],
                  );
                }
                return TransactionItem(
                  model: controller.dataApis[index],
                );
              },
              itemCount: controller.dataApis.length),
        ),
      ),
    );
  }
}
