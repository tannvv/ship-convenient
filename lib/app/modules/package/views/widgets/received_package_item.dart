import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';

class ReceivedPackageItem extends StatelessWidget {
  const ReceivedPackageItem({Key? key, required this.package})
      : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Điểm đến: ${package.destinationAddress}'),
        Text('Tên người nhận: ${package.receiverName}'),
        Text('Số điện thoại người nhận: ${package.receiverPhone}')
      ],
    );
  }
}
