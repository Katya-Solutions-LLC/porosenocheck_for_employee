import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/cached_image_widget.dart';
import 'package:porosenocheck_employee/components/price_widget.dart';

import '../../../../main.dart';
import '../../../../utils/common_base.dart';
import '../../../pet_store/model/pet_store_dashboard_model.dart';
import '../../shop_product/product_detail/product_detail_screen.dart';

class AboutProductComponent extends StatelessWidget {
  final ProductDetails productData;
  final String? deliveryStatus;

  const AboutProductComponent({super.key, this.deliveryStatus, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Product', style: primaryTextStyle()), //TODO: string
        8.height,
        GestureDetector(
          onTap: () {
            Get.to(() => const ProductDetailScreen(), arguments: productData.productId);
          },
          child: Container(
            decoration: boxDecorationDefault(color: context.cardColor),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedImageWidget(
                      url: productData.productImage,
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                      radius: defaultRadius,
                    ),
                    12.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productData.productName, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                        if (productData.productVariationType.isNotEmpty && productData.productVariationName.isNotEmpty)
                          Row(
                            children: [
                              Text('${productData.productVariationType} : ', style: secondaryTextStyle()),
                              Text(productData.productVariationName, style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                            ],
                          ),
                        Row(
                          children: [
                            Text('${locale.value.qty} : ', style: secondaryTextStyle()),
                            Text(productData.qty.toString(), style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                          ],
                        ),
                        PriceWidget(price: productData.getProductPrice, size: 12),
                      ],
                    ).expand(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
