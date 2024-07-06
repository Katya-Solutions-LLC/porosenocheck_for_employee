import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/price_widget.dart';
import 'package:porosenocheck_employee/utils/colors.dart';

import '../../components/cached_image_widget.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import 'model/service_list_model.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceData serviceInfo;

  const ServiceDetailScreen({super.key, required this.serviceInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      constraints: BoxConstraints(minWidth: Get.height * 0.65, maxHeight: Get.height * 0.62),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedImageWidget(
                  url: serviceInfo.serviceImage,
                  height: 220,
                  width: Get.width,
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRectOnly(topLeft: 30, topRight: 30),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: boxDecorationDefault(color: primaryColor.withOpacity(0.6), shape: BoxShape.circle),
                    child: CloseButton(color: Colors.white.withOpacity(0.9)),
                  ),
                ),
              ],
            ),
            16.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(serviceInfo.name, style: primaryTextStyle(size: 18)),
                Text(serviceInfo.categoryName, style: primaryTextStyle(color: primaryColor, size: 14)),
                10.height,
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: Get.width * 0.25,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: boxDecorationWithShadow(backgroundColor: primaryColor, borderRadius: radius(24)),
                      child: PriceWidget(price: serviceInfo.defaultPrice, color: Colors.white, size: 14),
                    ).visible(serviceInfo.defaultPrice != 0),
                    10.width,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(Assets.iconsIcDuration, width: 16, height: 16, color: primaryColor),
                        4.width,
                        Text('${serviceInfo.durationMin} ${locale.value.min}', textAlign: TextAlign.right, style: primaryTextStyle(size: 12)),
                      ],
                    ).visible(!serviceInfo.durationMin.isNegative),
                  ],
                ),
                10.height,
                Text('${locale.value.description} ', style: secondaryTextStyle()).paddingBottom(4).visible(serviceInfo.description.isNotEmpty),
                Text(serviceInfo.description, style: primaryTextStyle(size: 14)),
              ],
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }
}
