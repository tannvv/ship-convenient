import 'package:convenient_way/app/data/models/package_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart  ';

class SuggestItem extends StatelessWidget {
  const SuggestItem({Key? key, required this.package}) : super(key: key);
  final Package package;
  @override
  Widget build(BuildContext context) {
    double price = 0;
    package.products!.forEach((p) {
      price += p.price!;
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Địa chỉ giao ${package.destinationAddress}'),
          Text('Khoảng cách ${package.distance}'),
          Text('Số sản phẩm : ${package.products!.length}'),
          Text('Phí ship: ${package.priceShip}'),
          Text('Số tiền ứng trước: $price')
        ],
      ),
    );
  }
}
