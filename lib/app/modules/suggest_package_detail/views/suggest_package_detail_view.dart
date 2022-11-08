import 'package:convenient_way/app/modules/suggest_package_detail/views/widgets/suggest_item.dart';
import 'package:convenient_way/config/build_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
              flex: 2,
              child: FlutterMap(
                options: MapOptions(
                    interactiveFlags:
                        InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                    zoom: 14,
                    minZoom: 8,
                    maxZoom: 18.4,
                    slideOnBoundaries: true,
                    onMapCreated: controller.onMapCreated),
                children: [
                  TileLayerWidget(
                      options: TileLayerOptions(
                          urlTemplate:
                              BuildConfig.instance.mapConfig.mapboxUrlTemplate,
                          additionalOptions: {
                        'accessToken':
                            BuildConfig.instance.mapConfig.mapboxAccessToken,
                        'id': BuildConfig.instance.mapConfig.mapboxId
                      })),
                  PolylineLayerWidget(
                      options: PolylineLayerOptions(
                    polylineCulling: true,
                    saveLayers: true,
                  )),
                  MarkerLayerWidget(
                      options: MarkerLayerOptions(markers: [
                    Marker(
                        point: controller.coordShop,
                        builder: (_) => const Icon(Icons.shop)),
                    Marker(
                        point: controller.coordShipper[0],
                        builder: (_) => const Icon(Icons.account_box)),
                    Marker(
                        point: controller.coordShipper[1],
                        builder: (_) => const Icon(Icons.account_box)),
                    for (int i = 0; i < controller.coordPackage.length; i++)
                      Marker(
                          point: controller.coordPackage[i],
                          builder: (_) => const Icon(Icons.gamepad))
                  ]))
                ],
              )),
          Expanded(
              child: ListView.separated(
            itemCount: controller.suggest.value!.packages!.length,
            itemBuilder: (_, index) {
              return SuggestItem(
                  package: controller.suggest.value!.packages![index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Gap(10.h);
            },
          ))
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            controller.pickUpPackages();
          },
          child: const Text('Chọn combo này')),
    );
  }
}
