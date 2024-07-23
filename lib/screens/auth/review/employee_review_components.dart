import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/models/review_data.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/zoom_image_screen.dart';
import '../../../utils/app_common.dart';
import '../../../utils/constants.dart';
import '../../booking_module/booking_detail/booking_detail_controller.dart';

class EmployeeReviewComponents extends StatelessWidget {
  final ReviewData employeeReview;

  const EmployeeReviewComponents({super.key, required this.employeeReview});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: Get.width,
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CachedImageWidget(
                url: employeeReview.profileImage,
                firstName: employeeReview.username,
                height: 46,
                width: 46,
                fit: BoxFit.cover,
                circle: true,
              ),
              10.width,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employeeReview.username, style: primaryTextStyle()),
                  4.height,
                  RatingBarWidget(
                    size: 15,
                    disable: true,
                    activeColor: getRatingBarColor(employeeReview.rating),
                    rating: employeeReview.rating.toDouble(),
                    onRatingChanged: (aRating) {},
                  ),
                ],
              ),
              const Spacer(),
              Text(employeeReview.createdAt.dateInyyyyMMddHHmmFormat.timeAgoWithLocalization, style: secondaryTextStyle()),
            ],
          ),
          16.height,
          Text(employeeReview.reviewMsg, style: secondaryTextStyle()).visible(employeeReview.reviewMsg.isNotEmpty),
          if (!(loginUserData.value.userType.contains(EmployeeKeyConst.petStore) || !(loginUserData.value.userRole.contains(EmployeeKeyConst.petStore))))
            AnimatedWrap(
              spacing: 10,
              runSpacing: 10,
              itemCount: employeeReview.gallery.validate().take(3).length,
              itemBuilder: (ctx, index) {
                Gallery galleryData = employeeReview.gallery.validate()[index];

                return CachedImageWidget(
                  url: galleryData.fullUrl.validate(),
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                  radius: defaultRadius,
                ).onTap(
                  () {
                    if (galleryData.fullUrl.validate().isNotEmpty) {
                      ZoomImageScreen(
                        galleryImages: employeeReview.gallery.validate().map((e) => e.fullUrl.validate()).toList(),
                        index: index,
                      ).launch(context);
                    }
                  },
                );
              },
            ).paddingTop(16),
        ],
      ),
    );
  }
}
