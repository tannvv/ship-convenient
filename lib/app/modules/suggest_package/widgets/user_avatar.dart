import 'package:cached_network_image/cached_network_image.dart';
import 'package:convenient_way/app/core/values/app_assets.dart';
import 'package:convenient_way/app/core/values/app_colors.dart';
import 'package:convenient_way/app/core/values/font_weight.dart';
import 'package:convenient_way/app/core/values/text_styles.dart';
import 'package:convenient_way/app/modules/suggest_package/controllers/suggest_package_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class UserAvatar extends GetView<SuggestPackageController> {
  const UserAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? fname = controller.account?.infoUser?.firstName;
    String? lname = controller.account?.infoUser?.lastName;
    return Row(
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(18.r), // Image radius
            child: CachedNetworkImage(
              fadeInDuration: const Duration(),
              fadeOutDuration: const Duration(),
              placeholder: (context, url) {
                return controller.account?.infoUser?.gender == 'FEMALE'
                    ? SvgPicture.asset(AppAssets.female)
                    : SvgPicture.asset(AppAssets.male);
              },
              imageUrl: controller.account?.infoUser?.photoUrl ?? '-',
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                return controller.account?.infoUser?.gender == 'FEMALE'
                    ? SvgPicture.asset(AppAssets.female)
                    : SvgPicture.asset(AppAssets.male);
              },
            ),
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xin chào',
              style: body2.copyWith(color: Colors.white),
            ),
            Text(
              '${fname} ${lname}',
              style: subtitle1.copyWith(
                fontWeight: FontWeights.medium,
                color: AppColors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
