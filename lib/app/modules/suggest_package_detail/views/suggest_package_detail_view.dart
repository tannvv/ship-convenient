import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/views/widgets/suggest_item.dart';
import 'package:convenient_way/config/build_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../controllers/suggest_package_detail_controller.dart';

class SuggestPackageDetailView extends GetView<SuggestPackageDetailController> {
  const SuggestPackageDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final markerSize = 30.w;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết combo'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.w),
                    bottomRight: Radius.circular(12.w),
                  )),
                  child: Stack(
                    children: [
                      FlutterMap(
                        options: MapOptions(
                            interactiveFlags: InteractiveFlag.pinchZoom |
                                InteractiveFlag.drag,
                            zoom: 14,
                            minZoom: 8,
                            maxZoom: 18.4,
                            slideOnBoundaries: true,
                            onMapCreated: controller.onMapCreated),
                        children: [
                          TileLayerWidget(
                              options: TileLayerOptions(
                                  urlTemplate: BuildConfig
                                      .instance.mapConfig.mapboxUrlTemplate,
                                  additionalOptions: {
                                'accessToken': BuildConfig
                                    .instance.mapConfig.mapboxAccessToken,
                                'id': BuildConfig.instance.mapConfig.mapboxId
                              })),
                          PolylineLayerWidget(
                              options: PolylineLayerOptions(
                            polylineCulling: true,
                            saveLayers: true,
                          )),
                          Obx(
                            () => MarkerLayerWidget(
                                options: MarkerLayerOptions(markers: [
                              Marker(
                                  height: markerSize,
                                  width: markerSize,
                                  point: controller.coordSender,
                                  builder: (_) =>
                                      SvgPicture.asset(AppAssets.storeIcon)),
                              Marker(
                                  height: markerSize,
                                  width: markerSize,
                                  point: controller.coordAccount[0],
                                  builder: (_) =>
                                      SvgPicture.asset(AppAssets.locationIcon)),
                              Marker(
                                  height: markerSize,
                                  width: markerSize,
                                  point: controller.coordAccount[1],
                                  builder: (_) =>
                                      SvgPicture.asset(AppAssets.locationIcon)),
                              for (int i = 0;
                                  i < controller.coordPackage.length;
                                  i++)
                                if (controller.selectedPackages
                                    .contains(controller.packageIds[i]))
                                  Marker(
                                      height: markerSize,
                                      width: markerSize,
                                      point: controller.coordPackage[i],
                                      builder: (_) => SvgPicture.asset(
                                          AppAssets.locationBlueIcon))
                            ])),
                          )
                        ],
                      ),
                      Positioned(
                          right: 20.w,
                          bottom: 40.h,
                          child: Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    controller.selectedAllPackages();
                                  },
                                  child: Text(
                                    'Chọn tất',
                                    style: subtitle2.copyWith(
                                        color: AppColors.white),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    controller.clearAllPackages();
                                  },
                                  child: Text(
                                    'Bỏ chọn, về ngủ',
                                    style: subtitle2.copyWith(
                                        color: AppColors.white),
                                  ))
                            ],
                          ))
                    ],
                  ))),
          Expanded(
            flex: 2,
            child: Obx(
              () => MultiSelectCheckList(
                controller: controller.multiSelectController,
                maxSelectableCount: controller.maxSelectedPackages,
                textStyles: const MultiSelectTextStyles(
                    selectedTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                itemsDecoration: MultiSelectDecorations(
                    selectedDecoration: BoxDecoration(
                  color: AppColors.darkBlue.withOpacity(0.6),
                )),
                listViewSettings: ListViewSettings(
                    separatorBuilder: (context, index) => const Divider(
                          height: 2,
                        )),
                items: List.generate(
                    controller.suggest.value!.packages!.length,
                    (index) => CheckListCard(
                        value: controller.suggest.value!.packages![index].id ??
                            Uuid.NAMESPACE_NIL,
                        title: SuggestItem(
                          package: controller.suggest.value!.packages![index],
                        ),
                        selectedColor: Colors.white,
                        checkColor: Colors.indigo,
                        checkBoxBorderSide:
                            const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                onChange: (List<String> selectedItems, selectedItem) {
                  controller.selectedPackages.value = selectedItems;
                  debugPrint('Selected packages : $selectedItems');
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: ElevatedButton(
          style: ButtonStyles.primaryBlue(),
          onPressed: () {
            controller.pickUpPackages();
          },
          child: const Text('Chọn combo này')),
    );
  }
}
