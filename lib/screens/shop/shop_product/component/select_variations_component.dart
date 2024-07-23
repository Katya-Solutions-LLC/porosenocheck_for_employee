import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/shop/variation/model/variation_list_response.dart';

import '../../../../main.dart';
import '../../../../utils/common_base.dart';
import '../add_shop_product/add_shop_product_controller.dart';

class SelectVariationsComponent extends StatefulWidget {
  final int? selectedIndex;
  final Function(List<String> val) onSelectedList;

  const SelectVariationsComponent({super.key, required this.onSelectedList, this.selectedIndex});

  @override
  State<SelectVariationsComponent> createState() => _SelectVariationsComponentState();
}

class _SelectVariationsComponentState extends State<SelectVariationsComponent> {
  final AddShopProductController addShopProductController = Get.put(AddShopProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Obx(
            () => AnimatedListView(
              itemCount: addShopProductController.selectedVariationType.value.productVariationData.length,
              listAnimationType: ListAnimationType.None,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                ProductVariationData data = addShopProductController.selectedVariationType.value.productVariationData[i];

                return Obx(
                  () => CheckboxListTile(
                    checkboxShape: RoundedRectangleBorder(borderRadius: radius(4)),
                    autofocus: false,
                    activeColor: context.primaryColor,
                    checkColor: Get.isDarkMode ? Get.iconColor : context.cardColor,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      data.name.validate(),
                      style: secondaryTextStyle(color: Get.iconColor),
                    ),
                    value: data.isSelected.value,
                    onChanged: (bool? value) {
                      data.isSelected(!data.isSelected.value);
                      addShopProductController.addProductVariationDataList(addShopProductController.selectedVariationType.value.productVariationData);
                      addShopProductController.addVariationsList[widget.selectedIndex!].variation = data.variationId;
                      addShopProductController.addVariationsList[widget.selectedIndex!].variationValue =
                          addShopProductController.selectedVariationType.value.productVariationData.where((element) => element.isSelected.value).toList().map((e) => e.id).toList();
                    },
                  ),
                );
              },
              onNextPage: () {
                if (!addShopProductController.isLastPage.value) {
                  addShopProductController.variationPage++;
                  addShopProductController.getVariationList(showLoader: true);
                }
              },
              onSwipeRefresh: () async {
                addShopProductController.variationPage(1);
                addShopProductController.getVariationList(showLoader: false);
                return await Future.delayed(const Duration(seconds: 2));
              },
            ).expand(),
          ),
          AppButton(
            text: locale.value.apply,
            textStyle: appButtonTextStyleWhite,
            width: Get.width,
            onTap: () {
              Get.back();
              widget.onSelectedList.call(
                addShopProductController.selectedVariationType.value.productVariationData.where((e) => e.isSelected.value).toList().map((e) => e.name).toList(),
              );
            },
          )
        ],
      ).expand(),
    );
  }
}
