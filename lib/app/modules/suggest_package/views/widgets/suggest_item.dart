import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/data/models/suggest_package_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SuggestPackageItem extends StatelessWidget {
  const SuggestPackageItem({Key? key, required this.suggestPackage})
      : super(key: key);
  final SuggestPackage suggestPackage;
  @override
  Widget build(BuildContext context) {
    int countPackage = suggestPackage.packages?.length ?? 0;
    return Container(
      decoration: const BoxDecoration(color: AppColors.softGray),
      child: Column(
        children: [
          Text('Shop name : ${suggestPackage.shop!.userName}'),
          Text('Số sản phẩm trong combo: $countPackage'),
          Text('Giá của toàn bộ combo ${suggestPackage.compoPrice}')
        ],
      ),
    );
  }
}
