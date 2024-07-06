import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/circle_widget.dart';
import '../../../components/shimmer_widget.dart';
import '../../../utils/colors.dart';

class EmployeeReportShimmer extends StatelessWidget {
  const EmployeeReportShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: boxDecorationDefault(),
                        ),
                      ).expand(),
                      36.width,
                      ShimmerWidget(
                        baseColor: shimmerLightBaseColor,
                        child: CircleWidget(height: 32, width: 32),
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
        ),
        16.width,
        Container(
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                          decoration: boxDecorationDefault(),
                        ),
                      ).expand(),
                      36.width,
                      ShimmerWidget(
                        baseColor: shimmerLightBaseColor,
                        child: CircleWidget(height: 32, width: 32),
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
        )
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 16);
  }
}
