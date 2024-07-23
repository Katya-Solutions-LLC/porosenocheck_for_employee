import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';

import '../../../../../components/cached_image_widget.dart';
import '../../../../../components/zoom_image_screen.dart';
import '../../../../../models/review_data.dart';
import '../../../../booking_module/booking_detail/booking_detail_controller.dart';

class OrderReviewComponent extends StatelessWidget {
  final ReviewData reviewData;

  const OrderReviewComponent({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
                    url: reviewData.profileImage,
                    firstName: reviewData.username,
                    height: 46,
                    width: 46,
                    fit: BoxFit.cover,
                    circle: true,
                  ),
                  10.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reviewData.username, style: primaryTextStyle()),
                      4.height,
                      RatingBarWidget(
                        size: 15,
                        disable: true,
                        activeColor: getRatingBarColor(reviewData.rating),
                        rating: reviewData.rating.toDouble(),
                        onRatingChanged: (aRating) {},
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(reviewData.createdAt.dateInyyyyMMddHHmmFormat.timeAgoWithLocalization, style: secondaryTextStyle()),
                ],
              ),
              16.height,
              Text(reviewData.reviewMsg, style: secondaryTextStyle()).visible(reviewData.reviewMsg.isNotEmpty),
              16.height,
              AnimatedWrap(
                spacing: 10,
                runSpacing: 10,
                itemCount: reviewData.gallery.validate().take(3).length,
                itemBuilder: (ctx, index) {
                  Gallery galleryData = reviewData.gallery.validate()[index];

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
                          galleryImages: reviewData.gallery.validate().map((e) => e.fullUrl.validate()).toList(),
                          index: index,
                        ).launch(context);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
