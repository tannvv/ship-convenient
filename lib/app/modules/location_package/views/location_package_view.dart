import 'package:convenient_way/app/modules/location_package/widgets/bottom.dart';
import 'package:convenient_way/app/modules/location_package/widgets/convenient_map.dart';
import 'package:convenient_way/app/modules/location_package/widgets/top.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_package_controller.dart';

class LocationPackageView extends GetView<LocationPackageController> {
  const LocationPackageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: const [
        ConvenientMap(),
        Top(),
        Bottom(),
      ]),
    );
  }
}
