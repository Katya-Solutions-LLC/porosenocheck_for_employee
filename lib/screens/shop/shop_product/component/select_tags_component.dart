import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';

import '../../units_tags/model/unit_tag_list_response.dart';
import '../add_shop_product/add_shop_product_controller.dart';

class SelectTagsComponent extends StatefulWidget {
  final Function(List<UnitTagData> val) onSelectedList;

  @override
  State<SelectTagsComponent> createState() => _SelectTagsComponentState();

  const SelectTagsComponent({super.key, required this.onSelectedList});
}

class _SelectTagsComponentState extends State<SelectTagsComponent> {
  final AddShopProductController addShopProductController = Get.put(AddShopProductController());

  bool isExpanded = false;
  bool selectedValue = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          AnimatedListView(
            itemCount: addShopProductController.tagsList.length,
            shrinkWrap: true,
            itemBuilder: (_, i) {
              return CheckboxListTile(
                checkboxShape: RoundedRectangleBorder(borderRadius: radius(4)),
                autofocus: false,
                activeColor: context.primaryColor,
                checkColor: Get.isDarkMode ? Get.iconColor : context.cardColor,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  addShopProductController.tagsList[i].name.validate(),
                  style: secondaryTextStyle(color: Get.iconColor),
                ),
                value: addShopProductController.tagsList[i].isSelected,
                onChanged: (bool? val) {
                  addShopProductController.tagsList[i].isSelected = !addShopProductController.tagsList[i].isSelected.validate();
                  setState(() {});
                },
              );
            },
            onNextPage: () {
              if (!addShopProductController.isLastPage.value) {
                addShopProductController.tagPage++;
                addShopProductController.getUnitTagList(showLoader: true, isFromTag: true);
              }
            },
            onSwipeRefresh: () async {
              addShopProductController.tagPage(1);
              addShopProductController.getUnitTagList(showLoader: false, isFromTag: true);
              return await Future.delayed(const Duration(seconds: 2));
            },
          ).expand(),
          AppButton(
            text: locale.value.apply,
            textStyle: appButtonTextStyleWhite,
            width: Get.width,
            onTap: () {
              Get.back();
              widget.onSelectedList.call(addShopProductController.tagsList.where((element) => element.isSelected == true).map((e) => e).toList()); //
            },
          )
        ],
      ).expand(),
    );
  }
}
