import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:get/get.dart';

import '../controllers/suggest_package_detail_controller.dart';

class SuggestPackageDetailView extends GetView<SuggestPackageDetailController> {
  const SuggestPackageDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết combo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FlutterMap(
                  options: MapOptions(
                      interactiveFlags:
                          InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      zoom: 14,
                      minZoom: 8,
                      maxZoom: 18.4,
                      slideOnBoundaries: true,
                      onMapCreated: controller.onMapCreated)))
        ],
      ),
    );
  }
}
