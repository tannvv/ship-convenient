import 'package:convenient_way/app/core/values/app_animation_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/shadow_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_stack.dart';
import 'package:convenient_way/app/modules/location_package/controllers/location_package_controller.dart';
import 'package:convenient_way/config/build_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';

class ConvenientMap extends GetWidget<LocationPackageController> {
  const ConvenientMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HyperStack(
      children: [
        FlutterMap(
          options: MapOptions(
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            center: LatLng(10.212884, 103.964889),
            zoom: 10.5,
            minZoom: 10.5,
            maxZoom: 18.4,
            slideOnBoundaries: true,
            onMapCreated: controller.onMapCreated,
          ),
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
            LocationMarkerLayerWidget(
              options: LocationMarkerLayerOptions(
                moveAnimationDuration: const Duration(milliseconds: 800),
                showHeadingSector: false,
                markerSize: Size(60.r, 60.r),
                markerDirection: MarkerDirection.heading,
                marker: Stack(
                  children: [
                    Lottie.asset(AppAnimationAssets.scanPulsePurple),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: ShadowStyles.locationMarker,
                        ),
                        height: 26.r,
                        width: 26.r,
                        child: DefaultLocationMarker(
                          color: AppColors.primary400,
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
