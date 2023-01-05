import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';

class ReceivedPackageItem extends StatelessWidget {
  const ReceivedPackageItem({Key? key, required this.package})
      : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Điểm đến: ${package.destinationAddress}',
          style: subtitle2,
        ),
        Text(
          'Tên người nhận: ${package.receiverName}',
          style: subtitle2,
        ),
        Text(
          'Số điện thoại người nhận: ${package.receiverPhone}',
          style: subtitle2,
        )
      ],
    );
  }
}
