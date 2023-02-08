import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/core/widgets/hyper_shape.dart';
import 'package:convenient_way/app/modules/create-route/controllers/create_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RouteInfo extends GetWidget<CreateRouteController> {
  const RouteInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 11.5.h),
              height: 85.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HyperShape.startCircle(),
                  HyperShape.dot(),
                  HyperShape.dot(),
                  HyperShape.dot(),
                  HyperShape.endCircle(),
                ],
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 3.5.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _homeTextField(),
                          _destinationTextField(),
                        ],
                      ),
                    ),
                    SizedBox(width: 5.w),
                    ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: AppColors.blue,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(0),
                        minimumSize: Size(40.r, 40.r),
                      ),
                      child: SizedBox(
                        height: 40.r,
                        width: 40.r,
                        child: Icon(
                          Icons.swap_vert,
                          size: 23.r,
                          color: AppColors.white,
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

  TypeAheadField _homeTextField() {
    return TypeAheadField(
      debounceDuration: const Duration(milliseconds: 500),
      minCharsForSuggestions: 2,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller.homeController,
        autofocus: true,
        style: subtitle1.copyWith(
          color: AppColors.lightBlack,
        ),
        decoration: InputStyles.map(
          hintText: 'Nhập điểm đi chỉ của bạn',
          labelText: 'Điểm đi',
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return [];
        }
        controller.setFromName = pattern;
        return await controller.queryLocation(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_pin),
          minLeadingWidth: 20,
          title: Text(
            suggestion.name ?? 'Unknown',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.setFromName = suggestion.name ?? '';
        LatLng coord =
            LatLng(suggestion.latitude ?? 0, suggestion.longitude ?? 0);
        controller.setFromCoord = coord;
        controller.homeController.text = suggestion.name ?? '';
      },
      noItemsFoundBuilder: (context) => Padding(
          padding: EdgeInsets.all(10.w),
          child: const Text('Không tìm thấy địa chỉ')),
      errorBuilder: ((context, error) => Padding(
          padding: EdgeInsets.all(10.w), child: Text(error.toString()))),
    );
  }

  TypeAheadField _destinationTextField() {
    return TypeAheadField(
      debounceDuration: const Duration(seconds: 2),
      minCharsForSuggestions: 4,
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller.workController,
        autofocus: true,
        style: subtitle1.copyWith(
          color: AppColors.lightBlack,
        ),
        decoration: InputStyles.map(
          hintText: 'Nhập điểm đến của bạn',
          labelText: 'Điểm đến',
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return [];
        }
        controller.setToName = pattern;
        return await controller.queryLocation(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_pin),
          minLeadingWidth: 20,
          title: Text(
            suggestion.name ?? 'Unknown',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        controller.setToName = suggestion.name ?? '';
        LatLng coord =
            LatLng(suggestion.latitude ?? 0, suggestion.longitude ?? 0);
        controller.setToCoord = coord;
        controller.workController.text = suggestion.name ?? '';
      },
      noItemsFoundBuilder: (context) => Padding(
          padding: EdgeInsets.all(10.w),
          child: const Text('Không tìm thấy địa chỉ')),
      errorBuilder: ((context, error) => Padding(
          padding: EdgeInsets.all(10.w), child: Text(error.toString()))),
    );
  }
}
