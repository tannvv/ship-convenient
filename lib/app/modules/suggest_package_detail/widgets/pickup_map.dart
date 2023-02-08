import 'package:convenient_way/app/core/values/app_animation_assets.dart';
import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_stack.dart';
import 'package:convenient_way/app/modules/suggest_package_detail/controllers/suggest_package_detail_controller.dart';
import 'package:convenient_way/config/build_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart' as lottie;

class PickupMap extends GetWidget<SuggestPackageDetailController> {
  const PickupMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markerSize = 30.w;
    return HyperStack(
      children: [
        FlutterMap(
          mapController: controller.mapController,
          options: MapOptions(
              interactiveFlags:
                  InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              zoom: 10.5,
              minZoom: 10.5,
              maxZoom: 18.4,
              slideOnBoundaries: true,
              onMapCreated: controller.onMapCreated),
          children: [
            TileLayerWidget(
              options: TileLayerOptions(
                urlTemplate: BuildConfig.instance.mapConfig.mapboxUrlTemplate,
                additionalOptions: {
                  'access_token':
                      BuildConfig.instance.mapConfig.mapboxAccessToken,
                  'id': BuildConfig.instance.mapConfig.mapboxId,
                },
              ),
            ),
            Obx(
              () => MarkerLayerWidget(
                  options: MarkerLayerOptions(markers: [
                Marker(
                    height: markerSize,
                    width: markerSize,
                    point: controller.coordSender,
                    builder: (_) => SvgPicture.asset(AppAssets.storeIcon)),
                Marker(
                    height: markerSize,
                    width: markerSize,
                    point: controller.coordAccount[0],
                    builder: (_) => SvgPicture.asset(AppAssets.locationIcon)),
                Marker(
                    height: markerSize,
                    width: markerSize,
                    point: controller.coordAccount[1],
                    builder: (_) => SvgPicture.asset(AppAssets.locationIcon)),
                for (int i = 0; i < controller.coordPackage.length; i++)
                  if (controller.selectedPackages
                      .contains(controller.packageIds[i]))
                    Marker(
                        height: markerSize,
                        width: markerSize,
                        point: controller.coordPackage[i],
                        builder: (_) =>
                            SvgPicture.asset(AppAssets.locationBlueIcon))
              ])),
            ),
            LocationMarkerLayerWidget(
              options: LocationMarkerLayerOptions(
                moveAnimationDuration: const Duration(milliseconds: 800),
                showHeadingSector: false,
                markerSize: Size(50.r, 50.r),
                markerDirection: MarkerDirection.heading,
                marker: Stack(
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: lottie.Lottie.asset(
                        AppAnimationAssets.scanPulsePurple,
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: ShadowStyles.locationMarker,
                        ),
                        height: 26.r,
                        width: 26.r,
                        child: DefaultLocationMarker(
                          color: AppColors.purple,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 2.r),
                            child: Center(
                              child: Icon(
                                Icons.navigation,
                                color: Colors.white,
                                size: 16.r,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            LocationMarkerLayerWidget(
              options: LocationMarkerLayerOptions(
                moveAnimationDuration: const Duration(milliseconds: 800),
                showHeadingSector: false,
                markerSize: Size(60.r, 60.r),
                markerDirection: MarkerDirection.heading,
                marker: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: ShadowStyles.locationMarker,
                        ),
                        height: 26.r,
                        width: 26.r,
                        child: DefaultLocationMarker(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 2.r),
                            child: Center(
                              child: Icon(
                                Icons.navigation,
                                color: Colors.white,
                                size: 16.r,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
