import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../generated/assets.dart';
import '../main.dart';
import '../screens/shop/shop_product/shop_product_list/shop_product_list_controller.dart';
import '../utils/common_base.dart';

class SearchProductWidget extends StatelessWidget {
  final String? hintText;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Function()? onClearButton;
  final ShopProductListController shopProductListController;

  const SearchProductWidget({
    super.key,
    this.hintText,
    this.onTap,
    this.onFieldSubmitted,
    this.onClearButton,
    required this.shopProductListController,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: shopProductListController.searchProductCont,
      textFieldType: TextFieldType.OTHER,
      textInputAction: TextInputAction.done,
      textStyle: primaryTextStyle(),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (p0) {
        shopProductListController.isSearchProductText(shopProductListController.searchProductCont.text.trim().isNotEmpty);
        shopProductListController.searchProductStream.add(p0);
      },
      suffix: Obx(
        () => appCloseIconButton(
          context,
          onPressed: () {
            if (onClearButton != null) {
              onClearButton!.call();
            }
            hideKeyboard(context);
            shopProductListController.searchProductCont.clear();
            shopProductListController.isSearchProductText(shopProductListController.searchProductCont.text.trim().isNotEmpty);
            shopProductListController.page(1);
            shopProductListController.getProductList();
          },
          size: 11,
        ).visible(shopProductListController.isSearchProductText.value),
      ),
      decoration: inputDecorationWithOutBorder(
        context,
        hintText: hintText ?? locale.value.searchHere,
        filled: true,
        fillColor: context.cardColor,
        prefixIcon: commonLeadingWid(imgPath: Assets.iconsIcSearch, icon: Icons.search_outlined, size: 18).paddingAll(14),
      ),
    );
  }
}
