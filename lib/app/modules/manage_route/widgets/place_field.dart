import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/input_styles.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/data/models/response_goong_model.dart';
import 'package:convenient_way/app/modules/manage_route/controllers/manage_route_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class PlaceField extends GetWidget<ManageRouteController> {
  PlaceField(
      {super.key,
      required this.enable,
      required this.hintText,
      required this.labelText,
      required this.onSelected,
      this.textController});
  final bool enable;
  final String hintText;
  final String labelText;
  final Function(ResponseGoong) onSelected;
  final TextEditingController? textController;
  final TextEditingController reserveTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController realTextCtrl =
        textController != null ? textController! : reserveTextController;
    return Material(
        color: Colors.transparent,
        child: TypeAheadField<ResponseGoong>(
          debounceDuration: const Duration(milliseconds: 500),
          minCharsForSuggestions: 2,
          textFieldConfiguration: TextFieldConfiguration(
            enabled: enable,
            controller: realTextCtrl,
            autofocus: true,
            style: subtitle1.copyWith(
              color: AppColors.lightBlack,
            ),
            decoration: InputStyles.map(
              hintText: hintText,
              labelText: labelText,
            ),
          ),
          suggestionsCallback: (pattern) async {
            if (pattern.isEmpty) {
              return [];
            }
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
            onSelected(suggestion);
            realTextCtrl.text = suggestion.name ?? '';
          },
          noItemsFoundBuilder: (context) => Padding(
              padding: EdgeInsets.all(10.w),
              child: const Text('Không tìm thấy địa chỉ')),
          errorBuilder: ((context, error) => Padding(
              padding: EdgeInsets.all(10.w), child: Text(error.toString()))),
        ));
  }
}
