import 'package:convenient_way/app/modules/package/controllers/package_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ShipperCancelView extends GetView<PackageController> {
  const ShipperCancelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Shipper cancel view');
  }
}
