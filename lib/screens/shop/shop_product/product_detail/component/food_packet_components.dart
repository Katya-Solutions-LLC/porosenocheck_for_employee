import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/view_all_label_component.dart';
import '../../../variation/model/variation_list_response.dart';
import '../../model/product_list_response.dart';
import '../model/product_item_data_response.dart';
import '../product_detail_controller.dart';

class FoodPacketComponents extends StatelessWidget {
  final ProductItemDataResponse productData;

  FoodPacketComponents({super.key, required this.productData});

  final ProductDetailController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (productData.hasVariation != 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          const ViewAllLabel(label: 'Product Size', isShowAll: false).paddingSymmetric(horizontal: 16), //TODO: string
          8.height,
          HorizontalList(
            wrapAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            itemCount: productData.variationData.length,
            spacing: 16,
            padding: const EdgeInsets.only(left: 16, right: 16),
            itemBuilder: (context, index) {
              VariationData variationData = productData.variationData[index];
              return Obx(
                () => InkWell(
                  onTap: () {
                    productController.selectedVariationData(variationData);
                    variationData.taxIncludeProductPrice = productController.selectedVariationData.value.taxIncludeProductPrice;
                  },
                  borderRadius: radius(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    decoration: boxDecorationDefault(
                      color: productController.selectedVariationData.value.id == variationData.id ? lightPrimaryColor : context.cardColor,
                    ),
                    child: AnimatedWrap(
                      itemCount: variationData.combination.length,
                      itemBuilder: (context, index) {
                        Combination combinationData = variationData.combination[index];
                        return Text(
                          combinationData.productVariationName,
                          style: primaryTextStyle(color: productController.selectedVariationData.value.id == variationData.id ? primaryColor : null),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else {
      return const Offstage();
    }
  }
}
