import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/custom_body_scaffold.dart';
import 'package:convenient_way/app/core/widgets/custom_footer_smart_refresh.dart';
import 'package:convenient_way/app/core/widgets/header_scaffold.dart';
import 'package:convenient_way/app/data/models/transaction_model.dart';
import 'package:convenient_way/app/modules/transaction/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomBodyScaffold(
      header: _header(),
      body: Obx(
        () => SmartRefresher(
          controller: controller.refreshController,
          enablePullUp: true,
          onRefresh: () => controller.onRefresh(),
          onLoading: () => controller.onLoading(),
          footer: CustomFooterSmartRefresh.defaultCustom(),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (_, index) {
              Transaction? item = controller.dataApis[index];
              if (item.filter == 0) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 18.w, right: 18.w, top: 10.h, bottom: 6.h),
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
                      index: index,
                      model: item,
                    ),
                  ],
                );
              } else if (item.filter == 1) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 18.w, right: 18.w, top: 10.h, bottom: 6.h),
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
                      index: index,
                      model: item,
                    ),
                  ],
                );
              }
              return TransactionItem(
                index: index,
                model: controller.dataApis[index],
              );
            },
            itemCount: controller.dataApis.length,
            separatorBuilder: (BuildContext context, int index) => Gap(10.h),
          ),
        ),
      ),
    ));
  }

  Widget _header() {
    return const HeaderScaffold(
      title: 'Lịch sử giao dịch',
      isBack: true,
    );
  }
}
