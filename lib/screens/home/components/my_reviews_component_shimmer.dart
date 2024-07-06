import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/circle_widget.dart';
import '../../../components/shimmer_widget.dart';
import '../../../utils/colors.dart';

class MyReviewsComponentShimmer extends StatelessWidget {
  const MyReviewsComponentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: Get.width / 2 - 24,
      decoration: boxDecorationDefault(borderRadius: BorderRadius.circular(0)),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: const CircleWidget(height: 40, width: 40),
                  ),
                  36.width,
                  Column(
                    children: [
                      ShimmerWidget(
                        baseColor: shimmerLightBaseColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: boxDecorationDefault(),
                        ),
                      ),
                      ShimmerWidget(
                        baseColor: shimmerLightBaseColor,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: boxDecorationDefault(),
                        ),
                      )
                    ],
                  ).expand(),
                  16.width,
                  ShimmerWidget(
                    baseColor: shimmerLightBaseColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: boxDecorationDefault(),
                    ),
                  )
                ],
              ),
              24.height,
              ShimmerWidget(
                baseColor: shimmerLightBaseColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 8),
                  decoration: boxDecorationDefault(),
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16),
          ShimmerWidget(
            padding: const EdgeInsets.symmetric(vertical: 48),
            baseColor: shimmerLightBaseColor,
            child: Container(
              width: Get.width,
              decoration: boxDecorationDefault(),
            ),
          ),
        ],
      ),
    );
  }
}
