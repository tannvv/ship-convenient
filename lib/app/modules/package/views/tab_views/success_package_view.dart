import 'package:convenient_way/app/modules/package/controllers/package_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessView extends GetView<PackageController> {
  const SuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('SuccessView');
  }
}
