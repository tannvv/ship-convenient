import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/button_styles.dart';
import 'package:convenient_way/config/build_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/pick_up_location_controller.dart';

class PickUpLocationView extends GetView<PickUpLocationController> {
  const PickUpLocationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                interactiveFlags:
                    InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                center: controller.centerLocation.value,
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
              Obx(
                () => MarkerLayerWidget(
                    options: MarkerLayerOptions(markers: [
                  Marker(
                      height: 40.sp,
                      width: 40.sp,
                      point: controller.centerLocation.value,
                      builder: (_) => SvgPicture.asset(AppAssets.locationIcon))
                ])),
              )
            ],
          ),
          Positioned(
            top: 50.h,
            left: 20.w,
            child: ElevatedButton(
              style: ButtonStyles.textCircle(),
              onPressed: () {
                controller.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18.sp,
                color: AppColors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 50.h,
            right: 20.w,
            child: ElevatedButton(
              style: ButtonStyles.primary(),
              onPressed: () {
                controller.back();
              },
              child: const Text('Chọn vị trí này'),
            ),
          )
        ],
      ),
    );
  }
}
