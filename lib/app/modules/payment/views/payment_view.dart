import 'package:convenient_way/app/core/enum/payment_method.dart';
import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/box_decorations.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_button.dart';
import 'package:convenient_way/app/modules/payment/widgets/payment_radio_item.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 400.h,
            color: AppColors.primary400,
          ),
          Column(
            children: [
              Expanded(
                flex: 20,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                primary: AppColors.softBlack,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 18,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Text('Nạp tiền vào ví',
                            style: h6.copyWith(color: AppColors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 80,
                child: Container(
                  width: 1.sw,
                  decoration: BoxDecorations.top(),
                  padding: EdgeInsets.only(left: 30.w, top: 20.h, right: 30.w),
                  child: Form(
                    key: controller.formKey,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        _balance(),
                        SizedBox(
                          height: 20.h,
                        ),
                        _deposit(),
                        SizedBox(
                          height: 20.h,
                        ),
                        _source(),
                        SizedBox(
                          height: 20.h,
                        ),
                        _action(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Obx _action() {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyles.primary(),
          onPressed: controller.submitIsLoading.value
              ? (() {})
              : () {
                  controller.submit();
                },
          child: HyperButton.childWhite(
            status: controller.submitIsLoading.value,
            loadingText: 'Đang tải...',
            child: Text(
              'Nạp tiền',
              style: buttonBold.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _source() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nguồn tiền',
            style: subtitle1.copyWith(
              fontWeight: FontWeights.medium,
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          GetBuilder<PaymentController>(
            builder: (_) {
              return Column(
                children: [
                  PaymentRadioItem(
                    onPressed: () {
                      controller.changePaymentMethod(PaymentMethod.vnpay);
                    },
                    state:
                        controller.selectedPaymentMethod == PaymentMethod.vnpay,
                    svgAsset: AppAssets.vnpay,
                    title: 'VnPay',
                    description: 'Thanh toán trong nước',
                  ),
                  PaymentRadioItem(
                    onPressed: () {
                      controller.changePaymentMethod(PaymentMethod.momo);
                    },
                    state:
                        controller.selectedPaymentMethod == PaymentMethod.momo,
                    svgAsset: AppAssets.momo,
                    title: 'MoMo',
                    description: 'Thanh toán đa dạng',
                  ),
                  PaymentRadioItem(
                    onPressed: () {
                      controller.changePaymentMethod(PaymentMethod.paypal);
                    },
                    state: controller.selectedPaymentMethod ==
                        PaymentMethod.paypal,
                    svgAsset: AppAssets.paypal,
                    title: 'PayPal',
                    description: 'Thanh toán quốc tế',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Column _deposit() {
    return Column(
      children: [
        GetBuilder<PaymentController>(
          builder: (_) {
            return TextFormField(
              validator: (text) {
                if (text.toString().isEmpty) {
                  return 'Vui lòng nhập số tiền để tiếp tục';
                }
                int value = controller.getInt(text!);
                if (value < 5000) {
                  return 'Số tiền tối thiểu là 5.000 VNĐ';
                }
                if (value > 50000000) {
                  return 'Số tiền tối đa là 50.000.000 VNĐ';
                }
                return null;
              },
              maxLength: 10,
              onSaved: (value) => controller.depositText = value,
              focusNode: controller.depositFocusNode,
              controller: controller.depositController,
              decoration: InputStyles.softBorder(
                labelText: "Số tiền cần nạp",
                state: controller.isShowClear,
                suffixAction: () {
                  controller.changeDeposit('');
                },
              ),
              style: subtitle1.copyWith(
                color: AppColors.softBlack,
                fontWeight: FontWeights.medium,
                fontSize: 18.sp,
              ),
              inputFormatters: [
                CurrencyTextInputFormatter(
                  decimalDigits: 0,
                  locale: 'vi',
                  symbol: '',
                )
              ],
              keyboardType: TextInputType.number,
            );
          },
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _paymentChip(
                '100.000',
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: _paymentChip(
                '200.000',
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: _paymentChip(
                '500.000',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _paymentChip(String text) {
    return TextButton(
      onPressed: () {
        controller.changeDeposit(text);
      },
      style: ButtonStyles.paymentChip(),
      child: Center(
        child: Text(
          '$text đ',
          style: body2.copyWith(
            color: AppColors.lightBlack,
          ),
        ),
      ),
    );
  }

  Row _balance() {
    return Row(
      children: [
        Image.asset(
          AppAssets.logo,
          width: 36.w,
          height: 36.w,
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Số dư ví',
              style: body2.copyWith(color: AppColors.floatLabel),
            ),
            GetBuilder<PaymentController>(
              builder: (_) {
                Widget result = Shimmer.fromColors(
                  baseColor: AppColors.shimmerBaseColor,
                  highlightColor: AppColors.shimmerHighlightColor,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      '1.000.000 VNĐ',
                      style: subtitle2.copyWith(
                        color: AppColors.softBlack,
                      ),
                    ),
                  ),
                );
                if (controller.hasAccountBalance) {
                  result = Text(
                    controller.accountBalanceVND,
                    style: subtitle2.copyWith(
                      color: AppColors.softBlack,
                    ),
                  );
                }
                return result;
              },
            ),
          ],
        ),
      ],
    );
  }
}
