import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/modules/package/tabs/failed_tab/failed_package_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FailedView extends GetView<FailedPackageController> {
  const FailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Điểm đến: .',
          style: subtitle2,
        ),
        Text(
          'Người nhận: .',
          style: subtitle2,
        ),
        Text(
          'Số điện thoại: .',
          style: subtitle2,
        )
      ],
    );
  }
}
