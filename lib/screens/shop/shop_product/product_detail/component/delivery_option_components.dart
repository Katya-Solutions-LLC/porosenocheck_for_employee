import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/shop/shop_product/product_detail/model/product_item_data_response.dart';
import 'package:porosenocheckemployee/utils/colors.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';
import 'package:porosenocheckemployee/utils/view_all_label_component.dart';

import '../../../../../main.dart';

class DeliveryOptionComponents extends StatelessWidget {
  final ProductItemDataResponse productData;

  const DeliveryOptionComponents({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.height,
         ViewAllLabel(label: locale.value.productDetails, isShowAll: false).paddingSymmetric(horizontal: 16),
        ReadMoreText(
          parseHtmlString(productData.description),
          trimLines: 3,
          style: secondaryTextStyle(size: 13),
          colorClickableText: secondaryColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: locale.value.readMore,
          trimExpandedText: locale.value.readLess,
          locale: Localizations.localeOf(context),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
