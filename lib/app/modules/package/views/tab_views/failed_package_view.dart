import 'package:convenient_way/app/modules/package/controllers/package_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FailedView extends GetView<PackageController> {
  const FailedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Failed view');
  }
}
