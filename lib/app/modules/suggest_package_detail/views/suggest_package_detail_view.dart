import 'package:convenient_way/app/modules/suggest_package_detail/widgets/bottom.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/widgets/center_right.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/widgets/pickup_map.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/widgets/top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/suggest_package_detail_controller.dart';

class SuggestPackageDetailView extends GetView<SuggestPackageDetailController> {
  const SuggestPackageDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: const [
        PickupMap(),
        Top(),
        CenterRight(),
        Bottom(),
      ]),
    );
  }
}
