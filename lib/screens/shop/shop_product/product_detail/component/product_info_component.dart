import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/price_widget.dart';
import 'package:porosenocheck_employee/screens/shop/shop_product/product_detail/model/product_item_data_response.dart';
import 'package:porosenocheck_employee/utils/colors.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';

import '../../../../../main.dart';
import '../../../../../utils/constants.dart';
import '../../../../booking_module/booking_detail/booking_detail_controller.dart';
import '../product_detail_controller.dart';

class ProductInfoComponent extends StatelessWidget {
  final ProductItemDataResponse productData;

  ProductInfoComponent({super.key, required this.productData});

  final ProductDetailController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(productData.name, style: primaryTextStyle(fontFamily: fontFamilyFontWeight600, size: 15)),
          if (productData.shortDescription.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.height,
                Text(productData.shortDescription, style: secondaryTextStyle()),
              ],
            ),
          if (productData.brandName.isNotEmpty)
            Row(
              children: [
                Text(
                  '${locale.value.brand}: ',
                  style: secondaryTextStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(productData.brandName, style: primaryTextStyle(fontFamily: fontFamilyFontWeight600, size: 12, color: secondaryColor)),
              ],
            ).paddingOnly(top: 6),
          16.height,
          Obx(
            () => Row(
              children: [
                PriceWidget(
                  price: productController.selectedVariationData.value.taxIncludeProductPrice,
                  isLineThroughEnabled: productData.isDiscount ? true : false,
                  isBoldText: productData.isDiscount ? false : true,
                  size: productData.isDiscount ? 14 : 16,
                  color: productData.isDiscount ? textSecondaryColorGlobal : null,
                ),
                if (productData.isDiscount)
                  Row(
                    children: [
                      PriceWidget(
                        price: productController.selectedVariationData.value.discountedProductPrice,
                      ).paddingLeft(4),
                      if (productData.discountType == TaxType.PERCENT)
                        Text(
                          '${productData.discountValue}%  ${locale.value.off}',
                          style: primaryTextStyle(color: greenColor),
                        ).paddingLeft(8)
                      else if (productData.discountType == TaxType.FIXED)
                        PriceWidget(
                          price: productData.discountValue,
                          color: greenColor,
                          size: 14,
                          isBoldText: false,
                          isDiscountedPrice: true,
                        ).paddingLeft(4),
                    ],
                  ),
              ],
            ),
          ),
          16.height,
          Row(
            children: [
              RatingBarWidget(
                onRatingChanged: (rating) {},
                disable: true,
                activeColor: getRatingBarColor(productData.rating.toInt()),
                inActiveColor: ratingBarColor,
                rating: productData.rating.toDouble(),
                size: 18,
              ),
              if (productData.rating != 0) 8.width,
              if (productData.rating != 0) Text('${productData.rating.toString()} ${locale.value.ratings}', style: primaryTextStyle()),
            ],
          ),
        ],
      ),
    );
  }
}
