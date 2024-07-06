import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/screens/shop/shop_product/add_shop_product/add_shop_product_controller.dart';

import '../../../../components/app_primary_widget.dart';
import '../../../../components/bottom_selection_widget.dart';
import '../../../../components/cached_image_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../../../../utils/app_common.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../brand/model/brand_list_response.dart';
import '../../units_tags/model/unit_tag_list_response.dart';
import '../../variation/model/variation_list_response.dart';
import '../component/select_category_component.dart';
import '../component/select_tags_component.dart';
import '../component/select_variations_component.dart';
import '../model/product_discount_data_response.dart';
import '../model/shop_category_model.dart';
import '../model/variation_combination_model.dart';

class AddShopProductScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();

  final AddShopProductController addShopController = Get.put(AddShopProductController());

  final bool isEdit;

  AddShopProductScreen({super.key, this.isEdit = false});

  //region Select Category
  Widget selectCategory(BuildContext ctx) {
    return Obx(
      () => Column(
        children: [
          if (addShopController.shopCategoryList.isNotEmpty && !addShopController.isLoading.value)
            AppTextField(
              title: locale.value.selectCategory,
              textStyle: primaryTextStyle(size: 12),
              controller: addShopController.categoryCont,
              textFieldType: TextFieldType.NAME,
              readOnly: true,
              onTap: () async {
                serviceCommonBottomSheet(
                  ctx,
                  child: Obx(
                    () => BottomSelectionSheet(
                      title: locale.value.chooseCategory,
                      hideSearchBar: true,
                      controller: TextEditingController(),
                      hasError: addShopController.hasError.value,
                      isEmpty: !addShopController.isLoading.value && addShopController.shopCategoryList.isEmpty,
                      errorText: addShopController.errorMessage.value,
                      noDataTitle: locale.value.categoryNotFound,
                      noDataSubTitle: locale.value.thereAreCurrentlyNoCategory,
                      isLoading: addShopController.isLoading,
                      onRetry: () {
                        addShopController.categoryPage(1);
                        addShopController.getCategoryList();
                      },
                      listWidget: SelectCategoryComponent(
                        onSelectedList: (List<ShopCategory> val) {
                          addShopController.selectedCategory(val.obs);
                          addShopController.selectedCategoryName.clear();

                          log('Category List: ${addShopController.selectedCategory}');

                          addShopController.selectedCategory.forEach((element) {
                            addShopController.selectedCategoryName.add(element.name);
                          });

                          addShopController.categoryCont.text = addShopController.selectedCategoryName.join(',');
                        },
                      ),
                    ),
                  ),
                );
              },
              decoration: inputDecoration(
                ctx,
                hintText: locale.value.selectYourProductCategory,
                fillColor: ctx.cardColor,
                filled: true,
                prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
              ),
            ),
        ],
      ),
    );
  }

  // endregion

  //region Set Brand
  Widget selectBrand(BuildContext ctx) {
    return Obx(
      () => Column(
        children: [
          AppTextField(
            title: locale.value.selectBrand,
            textStyle: primaryTextStyle(size: 12),
            controller: addShopController.brandCont,
            textFieldType: TextFieldType.NAME,
            readOnly: true,
            onTap: () async {
              serviceCommonBottomSheet(
                ctx,
                child: Obx(
                  () => BottomSelectionSheet(
                    title: locale.value.chooseBrand,
                    hideSearchBar: true,
                    controller: TextEditingController(),
                    hasError: addShopController.hasError.value,
                    isEmpty: !addShopController.isLoading.value && addShopController.brandsList.isEmpty,
                    errorText: addShopController.errorMessage.value,
                    noDataTitle: locale.value.brandNotFound,
                    noDataSubTitle: locale.value.thereAreCurrentlyNoBrandAvailable,
                    isLoading: addShopController.isLoading,
                    onRetry: () {
                      addShopController.brandPage(1);
                      addShopController.getCategoryList();
                    },
                    listWidget: Obx(
                      () => AnimatedListView(
                        itemCount: addShopController.brandsList.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          BrandData data = addShopController.brandsList[i];

                          return SettingItemWidget(
                            title: data.name,
                            titleTextStyle: primaryTextStyle(size: 14),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onTap: () {
                              addShopController.selectedBrand(data);
                              addShopController.brandCont.text = data.name.validate();
                              Get.back();
                            },
                          );
                        },
                        onNextPage: () {
                          if (!addShopController.isLastPage.value) {
                            addShopController.brandPage++;
                            addShopController.getBrandList(showLoader: true);
                          }
                        },
                        onSwipeRefresh: () async {
                          addShopController.brandPage(1);
                          addShopController.getBrandList(showLoader: false);
                          return await Future.delayed(const Duration(seconds: 2));
                        },
                      ).expand(),
                    ),
                  ),
                ),
              );
            },
            decoration: inputDecoration(
              ctx,
              hintText: locale.value.selectYourProductBrand,
              fillColor: ctx.cardColor,
              filled: true,
              prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
              suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
            ),
          ),
        ],
      ),
    );
  }

  //endregion

  //region Select Tag's
  Widget selectTags(BuildContext ctx) {
    return Obx(
      () => Column(
        children: [
          AppTextField(
            title: locale.value.selectTag,
            textStyle: primaryTextStyle(size: 12),
            controller: addShopController.tagsCont,
            textFieldType: TextFieldType.NAME,
            isValidationRequired: false,
            readOnly: true,
            onTap: () async {
              serviceCommonBottomSheet(
                ctx,
                child: Obx(
                  () => BottomSelectionSheet(
                    title: locale.value.selectTag,
                    hideSearchBar: true,
                    controller: TextEditingController(),
                    hasError: addShopController.hasError.value,
                    isEmpty: !addShopController.isLoading.value && addShopController.tagsList.isEmpty,
                    errorText: addShopController.errorMessage.value,
                    noDataTitle: locale.value.tagSNotFound,
                    noDataSubTitle: locale.value.thereAreCurrentlyNoTags,
                    isLoading: addShopController.isLoading,
                    listWidget: SelectTagsComponent(
                      onSelectedList: (List<UnitTagData> val) {
                        addShopController.selectedTag(val);
                        addShopController.selectedTagName.clear();

                        addShopController.selectedTag.forEach((element) {
                          addShopController.selectedTagName.add(element.name);
                        });
                        addShopController.tagsCont.text = addShopController.selectedTagName.join(',');
                      },
                    ),
                  ),
                ),
              );
            },
            decoration: inputDecoration(
              ctx,
              hintText: locale.value.selectYourProductTagS,
              fillColor: ctx.cardColor,
              filled: true,
              prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
              suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
            ),
          ).visible(addShopController.tagsList.isNotEmpty && !addShopController.isLoading.value),
        ],
      ),
    );
  }

  //endregion

  //region Select Unit
  Widget selectUnit(BuildContext ctx) {
    return Obx(
      () => Column(
        children: [
          if (addShopController.unitsList.isNotEmpty && !addShopController.isLoading.value)
            AppTextField(
              title: locale.value.selectUnit,
              textStyle: primaryTextStyle(size: 12),
              controller: addShopController.unitCont,
              textFieldType: TextFieldType.NAME,
              isValidationRequired: false,
              readOnly: true,
              onTap: () async {
                serviceCommonBottomSheet(
                  ctx,
                  child: Obx(
                    () => BottomSelectionSheet(
                      title: locale.value.selectUnit,
                      hideSearchBar: true,
                      controller: TextEditingController(),
                      hasError: addShopController.hasError.value,
                      isEmpty: !addShopController.isLoading.value && addShopController.unitsList.isEmpty,
                      errorText: addShopController.errorMessage.value,
                      noDataTitle: locale.value.unitNotFound,
                      noDataSubTitle: locale.value.thereAreCurrentlyNoUnit,
                      isLoading: addShopController.isLoading,
                      onRetry: () {
                        //
                      },
                      listWidget: Obx(
                        () => AnimatedListView(
                          itemCount: addShopController.unitsList.length,
                          shrinkWrap: true,
                          itemBuilder: (_, i) {
                            UnitTagData data = addShopController.unitsList[i];

                            return SettingItemWidget(
                              title: data.name,
                              titleTextStyle: primaryTextStyle(size: 14),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              onTap: () {
                                addShopController.selectedUnit(data);
                                addShopController.unitCont.text = data.name.validate();
                                Get.back();
                              },
                            );
                          },
                          onNextPage: () {
                            if (!addShopController.isLastPage.value) {
                              addShopController.unitPage++;
                              addShopController.getUnitTagList(showLoader: true, isFromTag: false);
                            }
                          },
                          onSwipeRefresh: () async {
                            addShopController.unitPage(1);
                            addShopController.getUnitTagList(showLoader: false, isFromTag: false);
                            return await Future.delayed(const Duration(seconds: 2));
                          },
                        ).expand(),
                      ),
                    ),
                  ),
                );
              },
              decoration: inputDecoration(
                ctx,
                hintText: locale.value.selectYourProductUnit,
                fillColor: ctx.cardColor,
                filled: true,
                prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
              ),
            ),
        ],
      ),
    );
  }

  //endregion

  /// region Variation List Widget
  Widget variationsListWidget(BuildContext ctx, {required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppTextField(
          title: locale.value.variationType,
          textStyle: primaryTextStyle(size: 12),
          controller: addShopController.addVariationsList[index].variationTypeCont,
          textFieldType: TextFieldType.NAME,
          readOnly: true,
          decoration: inputDecoration(
            ctx,
            hintText: locale.value.selectYourProductVariation,
            fillColor: ctx.cardColor,
            filled: true,
            prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
          ),
          onTap: () async {
            /*if (addShopController.variationCount.value == addShopController.variationList.length) {
              toast("You have already selected all the variations"); //TODO: string
            } else {
              serviceCommonBottomSheet(
                ctx,
                child: Obx(
                      () => BottomSelectionSheet(
                    title: locale.value.chooseVariationType,
                    hideSearchBar: true,
                    controller: TextEditingController(),
                    hasError: addShopController.hasError.value,
                    isEmpty: !addShopController.isLoading.value && addShopController.variationList.isEmpty,
                    errorText: addShopController.errorMessage.value,
                    noDataTitle: locale.value.variationTypeNotFound,
                    noDataSubTitle: locale.value.thereAreCurrentlyNoVariation,
                    isLoading: addShopController.isLoading,
                    onRetry: () {
                      addShopController.variationPage(1);
                      addShopController.getVariationList();
                    },
                    listWidget: Obx(
                          () => AnimatedListView(
                        itemCount: addShopController.variationList.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          VariationData data = addShopController.variationList[i];
                          log(data.toJson());

                          if (data.name == addShopController.selectedVariationType.value.name) {
                            return const Offstage();
                          } else {
                            return SettingItemWidget(
                              title: data.name,
                              titleTextStyle: primaryTextStyle(size: 14),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              onTap: () {
                                addShopController.selectedVariationType(data);
                                addShopController.addVariationsList[index].variationTypeCont?.text = data.name.validate();
                                if (addShopController.addVariationsList[index].variationTypeCont!.text.isNotEmpty) {
                                  addShopController.variationCount++;
                                  addShopController.isVariationType(true);
                                } else {
                                  addShopController.isVariationType(false);
                                }
                                Get.back();
                              },
                            );
                          }
                        },
                        onNextPage: () {
                          if (!addShopController.isLastPage.value) {
                            addShopController.variationPage++;
                            addShopController.getVariationList(showLoader: true);
                          }
                        },
                        onSwipeRefresh: () async {
                          addShopController.variationPage(1);
                          addShopController.getVariationList(showLoader: false);
                          return await Future.delayed(const Duration(seconds: 2));
                        },
                      ).expand(),
                    ),
                  ),
                ),
              );
            }*/
            serviceCommonBottomSheet(
              ctx,
              child: Obx(
                () => BottomSelectionSheet(
                  title: locale.value.chooseVariationType,
                  hideSearchBar: true,
                  controller: TextEditingController(),
                  hasError: addShopController.hasError.value,
                  isEmpty: !addShopController.isLoading.value && addShopController.variationList.isEmpty,
                  errorText: addShopController.errorMessage.value,
                  noDataTitle: locale.value.variationTypeNotFound,
                  noDataSubTitle: locale.value.thereAreCurrentlyNoVariation,
                  isLoading: addShopController.isLoading,
                  onRetry: () {
                    addShopController.variationPage(1);
                    addShopController.getVariationList();
                  },
                  listWidget: Obx(
                    () => AnimatedListView(
                      itemCount: addShopController.variationList.length,
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        VariationData data = addShopController.variationList[i];
                        log(data.toJson());

                        if (data.name == addShopController.selectedVariationType.value.name) {
                          return const Offstage();
                        } else {
                          return SettingItemWidget(
                            title: data.name,
                            titleTextStyle: primaryTextStyle(size: 14),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            onTap: () {
                              addShopController.selectedVariationType(data);
                              addShopController.addVariationsList[index].variationTypeCont?.text = data.name.validate();
                              if (addShopController.addVariationsList[index].variationTypeCont!.text.isNotEmpty) {
                                // addShopController.variationCount++;
                                addShopController.isVariationType(true);
                              } else {
                                addShopController.isVariationType(false);
                              }
                              Get.back();
                            },
                          );
                        }
                      },
                      onNextPage: () {
                        if (!addShopController.isLastPage.value) {
                          addShopController.variationPage++;
                          addShopController.getVariationList(showLoader: true);
                        }
                      },
                      onSwipeRefresh: () async {
                        addShopController.variationPage(1);
                        addShopController.getVariationList(showLoader: false);
                        return await Future.delayed(const Duration(seconds: 2));
                      },
                    ).expand(),
                  ),
                ),
              ),
            );
          },
        ).expand(),
        16.width,
        AppTextField(
          title: locale.value.variationValue,
          controller: addShopController.addVariationsList[index].variationValueCont,
          textStyle: primaryTextStyle(size: 12),
          textFieldType: TextFieldType.NAME,
          readOnly: true,
          decoration: inputDecoration(
            ctx,
            hintText: locale.value.selectVariations,
            fillColor: ctx.cardColor,
            filled: true,
            prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5)),
          ),
          onTap: () {
            serviceCommonBottomSheet(
              ctx,
              child: Obx(
                () => BottomSelectionSheet(
                  controller: TextEditingController(),
                  title: locale.value.selectVariations,
                  hideSearchBar: true,
                  hasError: addShopController.hasError.value,
                  isEmpty: !addShopController.isLoading.value && addShopController.selectedVariationType.value.productVariationData.isEmpty,
                  errorText: addShopController.errorMessage.value,
                  noDataTitle: locale.value.variationsNotFound,
                  noDataSubTitle: locale.value.thereAreCurrentlyNoVariationsAvailable,
                  isLoading: addShopController.isLoading,
                  onRetry: () {
                    addShopController.getVariationList();
                  },
                  listWidget: SelectVariationsComponent(
                    selectedIndex: index,
                    onSelectedList: (List<String> val) async {
                      log(val);
                      List<String> selectedList = [];
                      val.forEach((element) {
                        selectedList.add(element.validate());
                      });

                      addShopController.addVariationsList[index].variationValueCont?.text = selectedList.join(',').toString();

                      if (addShopController.addVariationsList[index].variationValueCont!.text.isNotEmpty) {
                        addShopController.isVariationValue(true);
                      } else {
                        addShopController.isVariationValue(false);
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ).expand(),
        8.width,
        buildIconWidget(
          icon: Assets.iconsIcDelete,
          iconColor: cancelStatusColor,
          onTap: () {
            if (addShopController.isEdit.value) {
              addShopController.addVariationsList[index].productVariationData.forEach((element) {
                element.isSelected(false);
              });
            } else {
              addShopController.variationList[index].productVariationData.forEach((element) {
                element.isSelected(false);
              });
            }
            addShopController.addVariationsList[index].variationTypeCont!.text = '';
            addShopController.addVariationsList[index].variationValueCont!.text = '';
            addShopController.addVariationsList.removeAt(index);

            ///Update Variation Combination APi
            addShopController.createCombinationList();
            // addShopController.variationCount--;
            addShopController.variationPage(1);
            addShopController.getVariationList();
          },
        ).paddingTop(16),
      ],
    ).paddingBottom(addShopController.addVariationsList.length > 1 ? 16 : 0);
  }

  //region Select Variation
  Widget setVariation(BuildContext ctx) {
    return Column(
      children: [
        Obx(
          () => CheckboxListTile(
            activeColor: ctx.primaryColor,
            checkColor: Get.isDarkMode ? iconColor : ctx.cardColor,
            value: addShopController.isHasVariation.value,
            contentPadding: EdgeInsets.zero,
            title: Text(locale.value.hasVariation, style: primaryTextStyle()),
            onChanged: (bool? v) {
              addShopController.isHasVariation(v);

              if (!(addShopController.isHasVariation.value)) {
                addShopController.addProductVariationDataList.forEach((element) {
                  element.isSelected(false);
                });
                addShopController.addVariationsList.clear();
                addShopController.isVariationType(false);
                addShopController.isVariationValue(false);
                addShopController.variationCombinationList.clear();
                // addShopController.variationCount(0);
                addShopController.selectedVariationType(VariationData());
              }
            },
          ),
        ),

        /// Variation List Fields
        Obx(
          () => AnimatedListView(
            listAnimationType: ListAnimationType.None,
            itemCount: addShopController.addVariationsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return variationsListWidget(ctx, index: index);
            },
          ).visible(addShopController.isHasVariation.value),
        ),

        /// Add Variation and Save Variation Button
        Obx(
          () => Row(
            children: [
              if (!(addShopController.addVariationsList.length == addShopController.variationList.length))
                AppButton(
                  text: locale.value.addMoreVariation,
                  textStyle: appButtonTextStyleWhite,
                  color: secondaryColor,
                  width: Get.width,
                  onTap: () {
                    addShopController.isLoading(true);
                    addShopController.addVariationsList.add(
                      VariationData(
                        index: addShopController.addVariationsList.length,
                        addVariationCount: addShopController.addVariationsList.length + 1,
                        variationTypeCont: TextEditingController(),
                        variationTypeFocus: FocusNode(),
                        variationValueCont: TextEditingController(),
                        variationValueFocus: FocusNode(),
                      ),
                    );
                    addShopController.isLoading(false);
                  },
                ).paddingRight(16).expand(),
              AppButton(
                text: locale.value.saveVariation,
                textStyle: appButtonTextStyleWhite,
                width: Get.width,
                onTap: () {
                  ///Create Variation Combination APi
                  if (addShopController.isVariationType.value && addShopController.isVariationValue.value) {
                    addShopController.createCombinationList();
                  } else {
                    toast(locale.value.pleaseSelectAtleastOne);
                  }
                },
              ).expand(),
            ],
          ).paddingTop(addShopController.addVariationsList.isNotEmpty ? 16 : 0).visible(addShopController.isHasVariation.value),
        ),

        /// Variation Combination List
        Obx(
          () => HorizontalList(
            spacing: 16,
            itemCount: addShopController.variationCombinationList.length,
            padding: const EdgeInsets.only(top: 16),
            itemBuilder: (ctx, index) {
              VariationCombinationData combinationData = addShopController.variationCombinationList[index];

              return Container(
                width: Get.width * 0.82,
                padding: const EdgeInsets.all(16),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(),
                  backgroundColor: ctx.cardColor,
                  border: isDarkMode.value ? Border.all(color: ctx.dividerColor) : null,
                ),
                child: Column(
                  children: [
                    AppTextField(
                      title: locale.value.variation,
                      textStyle: primaryTextStyle(size: 12),
                      controller: combinationData.variationsCont,
                      textFieldType: TextFieldType.NAME,
                      isValidationRequired: addShopController.isHasVariation.value ? true : false,
                      readOnly: true,
                      enabled: false,
                      decoration: inputDecoration(
                        ctx,
                        hintText: locale.value.variations,
                        fillColor: ctx.cardColor,
                        filled: true,
                      ),
                    ),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          title: locale.value.price,
                          textStyle: primaryTextStyle(size: 12),
                          controller: combinationData.priceCont,
                          textFieldType: TextFieldType.NUMBER,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          isValidationRequired: addShopController.isHasVariation.value ? true : false,
                          decoration: inputDecoration(
                            ctx,
                            hintText: locale.value.enterPrice,
                            fillColor: ctx.cardColor,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return locale.value.thisFieldIsRequired;
                            } else if (value.startsWith('.') || value.startsWith('-')) {
                              return locale.value.theInputtedPriceIsInvalid;
                            }  else if (value.toDouble() == 0.0) {
                              return 'Value must be greater than 0'; //TODO: string
                            } else {
                              return null;
                            }
                          },
                        ).expand(),
                        16.width,
                        AppTextField(
                          title: locale.value.stock,
                          textStyle: primaryTextStyle(size: 12),
                          controller: combinationData.stockCont,
                          textFieldType: TextFieldType.NUMBER,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          isValidationRequired: addShopController.isHasVariation.value ? true : false,
                          decoration: inputDecoration(
                            ctx,
                            hintText: locale.value.enterStock,
                            fillColor: ctx.cardColor,
                            filled: true,
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return locale.value.thisFieldIsRequired;
                            }  else if (v.toInt() == 0) {
                              return 'Value must be greater than 1'; //TODO: string
                            } else if (v.contains('.') || v.startsWith('-')) {
                              return locale.value.theInputtedStockIsInvalid;
                            } else {
                              return null;
                            }
                          },
                        ).expand(),
                      ],
                    ),
                    16.height,
                    Row(
                      children: [
                        AppTextField(
                          title: locale.value.sku,
                          textStyle: primaryTextStyle(size: 12),
                          controller: combinationData.skuCont,
                          textFieldType: TextFieldType.NAME,
                          isValidationRequired: false,
                          decoration: inputDecoration(
                            ctx,
                            hintText: locale.value.enterProductSku,
                            fillColor: ctx.cardColor,
                            filled: true,
                          ),
                        ).expand(),
                        16.width,
                        AppTextField(
                          title: locale.value.code,
                          textStyle: primaryTextStyle(size: 12),
                          controller: combinationData.codeCont,
                          textFieldType: TextFieldType.NAME,
                          isValidationRequired: false,
                          decoration: inputDecoration(
                            ctx,
                            hintText: locale.value.enterProductCode,
                            fillColor: ctx.cardColor,
                            filled: true,
                          ),
                        ).expand(),
                      ],
                    ),
                  ],
                ),
              );
            },
          ).visible(addShopController.isHasVariation.value && addShopController.variationCombinationList.isNotEmpty),
        ),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    title: locale.value.price,
                    textStyle: primaryTextStyle(size: 12),
                    controller: addShopController.priceCont,
                    textFieldType: TextFieldType.NUMBER,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    isValidationRequired: !addShopController.isHasVariation.value ? true : false,
                    decoration: inputDecoration(
                      ctx,
                      hintText: locale.value.enterYourPrice,
                      fillColor: ctx.cardColor,
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return locale.value.thisFieldIsRequired;
                      } else if (value.startsWith('.') || value.startsWith('-')) {
                        return locale.value.theInputtedPriceIsInvalid;
                      } else if (value.toDouble() == 0.0) {
                        return 'Value must be greater than or equal to 0'; //TODO: string
                      }
                      return null;
                    },
                  ).expand(),
                  16.width,
                  AppTextField(
                    title: locale.value.stock,
                    textStyle: primaryTextStyle(size: 12),
                    controller: addShopController.stockCont,
                    textFieldType: TextFieldType.NUMBER,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    isValidationRequired: !addShopController.isHasVariation.value ? true : false,
                    decoration: inputDecoration(
                      ctx,
                      hintText: locale.value.enterStock,
                      fillColor: ctx.cardColor,
                      filled: true,
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return locale.value.thisFieldIsRequired;
                      } else if (v.toInt() == 0) {
                        return 'Value must be greater than or equal to 1'; //TODO: string
                      } else if (v.contains('.') || v.startsWith('-')) {
                        return locale.value.theInputtedStockIsInvalid;
                      } else {
                        return null;
                      }
                    },
                  ).expand(),
                ],
              ),
              16.height,
              AppTextField(
                title: locale.value.sku,
                textStyle: primaryTextStyle(size: 12),
                controller: addShopController.skuCont,
                textFieldType: TextFieldType.NAME,
                isValidationRequired: false,
                decoration: inputDecoration(
                  ctx,
                  hintText: locale.value.enterProductSku,
                  fillColor: ctx.cardColor,
                  filled: true,
                ),
              ),
              16.height,
              AppTextField(
                title: locale.value.code,
                textStyle: primaryTextStyle(size: 12),
                controller: addShopController.codeCont,
                textFieldType: TextFieldType.NAME,
                isValidationRequired: false,
                decoration: inputDecoration(
                  ctx,
                  hintText: locale.value.enterYourProductCode,
                  fillColor: ctx.cardColor,
                  filled: true,
                ),
              ),
            ],
          ).visible(!addShopController.isHasVariation.value),
        ),
      ],
    );
  }

  //endregion

  //region Product Discount
  Widget dateRangePickerWidget(BuildContext ctx) {
    return Column(
      children: [
        Obx(
          () => AppTextField(
            title: locale.value.dateRange,
            textStyle: primaryTextStyle(size: 12),
            controller: addShopController.dateRangeCont,
            textFieldType: TextFieldType.NAME,
            readOnly: true,
            isValidationRequired: false,
            decoration: inputDecoration(
              ctx,
              hintText: locale.value.selectStartDateEndDate,
              fillColor: ctx.cardColor,
              filled: true,
              suffixIcon: addShopController.isSelectedDateRange.value
                  ? appCloseIconButton(
                      ctx,
                      onPressed: () {
                        addShopController.isSelectedDateRange(false);
                        addShopController.dateRangeCont.text = '';
                      },
                      size: 11,
                    )
                  : Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 24,
                      color: darkGray.withOpacity(0.5),
                    ),
            ),
            onTap: () {
              addShopController.selectDate(ctx);
            },
          ),
        ),
        16.height,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: boxDecorationDefault(
                borderRadius: BorderRadius.circular(defaultRadius),
                color: ctx.cardColor,
                border: Border.all(color: Colors.black12.withOpacity(0.12), width: 0.6),
              ),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  hintStyle: secondaryTextStyle(),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ctx.cardColor)),
                  focusedBorder: InputBorder.none,
                ),
                padding: const EdgeInsets.only(left: 8, right: 8),
                dropdownColor: ctx.cardColor,
                borderRadius: BorderRadius.circular(defaultRadius),
                items: productDiscountTypes.map((element) {
                  return DropdownMenuItem(
                    value: element,
                    child: Text(element.productDiscountName.capitalizeFirstLetter(), style: primaryTextStyle(size: 13)),
                  );
                }).toList(),
                onChanged: (newValue) {
                  if (newValue is ProductDiscountData) {
                    addShopController.selectedDiscountType(newValue);
                  }
                },
                value: addShopController.selectedDiscountType.value,
              ).paddingLeft(16),
            ).expand(),
            16.width,
            Obx(
              () => AppTextField(
                title: '',
                textStyle: primaryTextStyle(size: 12),
                controller: addShopController.discountAmountCont,
                textFieldType: TextFieldType.NUMBER,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                isValidationRequired: addShopController.isDiscountAmount.value ? true : false,
                decoration: inputDecoration(
                  ctx,
                  hintText: locale.value.discountAmount,
                  fillColor: ctx.cardColor,
                  filled: true,
                ),
                onChanged: (p0) {
                  if (addShopController.discountAmountCont.text.isNotEmpty) {
                    addShopController.isDiscountAmount(true);
                  } else {
                    addShopController.isDiscountAmount(false);
                  }
                },
                validator: (v) {
                  if (addShopController.isDiscountAmount.value && addShopController.dateRangeCont.text.isEmpty) {
                    return 'Please select a date range first'; //TODO: string
                  } else if (addShopController.selectedDiscountType.value.productDiscountType == ProductDiscountTypes.PERCENT
                      && addShopController.discountAmountCont.text.toDouble() >= 100) {
                    return locale.value.theInputtedDiscountIsInvalid;
                  } else if (addShopController.selectedDiscountType.value.productDiscountType == ProductDiscountTypes.FIXED) {
                    if (addShopController.isHasVariation.value) {
                      bool isValidDiscount = addShopController.variationCombinationList.any((element) => addShopController.discountAmountCont.text.toDouble() >= element.priceCont.text.toDouble());
                      if (isValidDiscount) {
                        return 'Fixed discount value must be less price'; //TODO: string
                      } else {
                        return null;
                      }
                    } else if (!addShopController.isHasVariation.value
                        && (addShopController.discountAmountCont.text.toDouble() >= addShopController.priceCont.text.toDouble())) {
                      return 'Fixed discount value must be less than price'; //TODO: string
                    } else {
                      return null;
                    }
                  } else {
                    return null;
                  }
                },
              ).expand(),
            ),
          ],
        ),
      ],
    );
  }

  //endregion

  //region Set Feature Product
  Widget setFeaturedProduct(BuildContext ctx) {
    return Obx(
      () => Column(
        children: [
          CheckboxListTile(
            autofocus: false,
            activeColor: ctx.primaryColor,
            checkColor: Get.isDarkMode ? iconColor : ctx.cardColor,
            value: addShopController.isFeature.value,
            contentPadding: EdgeInsets.zero,
            title: Text(locale.value.thisIsAFeaturedProduct, style: primaryTextStyle()),
            onChanged: (bool? v) {
              addShopController.isFeature(v!);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(locale.value.status, style: primaryTextStyle()).expand(),
              Obx(
                () => Switch.adaptive(
                  value: addShopController.isStatus.value,
                  activeColor: ctx.primaryColor,
                  inactiveTrackColor: ctx.primaryColor.withOpacity(0.2),
                  inactiveThumbColor: ctx.primaryColor.withOpacity(0.5),
                  onChanged: (val) {
                    addShopController.isStatus.value = !addShopController.isStatus.value;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAddProductWithHeadingWidget(Widget child, {required String title, bool addSpace = true, required BuildContext ctx}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          runSpacing: 8,
          children: [
            Text(title, style: primaryTextStyle(size: 18)),
            Divider(
              color: ctx.dividerColor,
              height: 2,
            )
          ],
        ),
        if (addSpace) 16.height,
        child,
      ],
    );
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: isEdit ? locale.value.editProduct : locale.value.addProduct,
      isLoading: addShopController.isLoading,
      body: Stack(
        children: [
          AnimatedScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 80),
            children: [
              Form(
                key: formKey,
                autovalidateMode: addShopController.isFirstTime.value ? AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAddProductWithHeadingWidget(
                      ctx: context,
                      title: locale.value.basicInformation,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => addShopController.imageFile.value.path.isNotEmpty || addShopController.productImage.value.isNotEmpty
                                ? Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 110,
                                        height: 110,
                                        child: Loader(),
                                      ).visible(addShopController.productImage.value.isNotEmpty || addShopController.imageFile.value.path.isNotEmpty),
                                      DottedBorderWidget(
                                        radius: defaultRadius,
                                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                                        gap: 1.5,
                                        child: CachedImageWidget(
                                          url: addShopController.imageFile.value.path.isNotEmpty ? addShopController.imageFile.value.path : addShopController.productImage.value,
                                          height: 110,
                                          width: 110,
                                          fit: BoxFit.cover,
                                        ).cornerRadiusWithClipRRect(defaultRadius),
                                      ),
                                      Positioned(
                                        top: 110 * 3 / 4 + 6,
                                        left: 110 * 3 / 4 + 6,
                                        child: GestureDetector(
                                          onTap: () {
                                            afterBuildCreated(() {
                                              hideKeyboard(context);
                                              addShopController.showBottomSheet(context);
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(3),
                                            decoration: boxDecorationDefault(shape: BoxShape.circle, color: Colors.white),
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: boxDecorationDefault(shape: BoxShape.circle, color: primaryColor),
                                              child: const Icon(Icons.edit, size: 16, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ).paddingSymmetric(vertical: 6)
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppPrimaryWidget(
                                        width: Get.width / 2 - 32,
                                        constraints: const BoxConstraints(minHeight: 100),
                                        border: Border.all(color: primaryColor),
                                        borderRadius: defaultRadius,
                                        onTapRadius: defaultRadius,
                                        onTap: () {
                                          afterBuildCreated(() {
                                            hideKeyboard(context);
                                            addShopController.showBottomSheet(context);
                                          });
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.add_circle_outline_rounded, color: primaryColor, size: 24),
                                            8.height,
                                            Text(
                                              locale.value.chooseImage,
                                              style: boldTextStyle(color: primaryColor, size: 14),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      8.height,
                                      Text(locale.value.noteYouCanUploadOne, style: secondaryTextStyle(size: 10)),
                                    ],
                                  ).expand(),
                          ),
                          16.width,
                          Column(
                            children: [
                              AppTextField(
                                title: locale.value.productName,
                                textStyle: primaryTextStyle(size: 12),
                                controller: addShopController.productNameCont,
                                textFieldType: TextFieldType.NAME,
                                textCapitalization: TextCapitalization.sentences,
                                isValidationRequired: true,
                                decoration: inputDecoration(
                                  context,
                                  hintText: locale.value.enterYourProductName,
                                  fillColor: context.cardColor,
                                  filled: true,
                                ),
                              ),
                              16.height,
                              AppTextField(
                                title: locale.value.shortDescription,
                                textStyle: primaryTextStyle(size: 12),
                                controller: addShopController.shortDescriptionCont,
                                textFieldType: TextFieldType.MULTILINE,
                                isValidationRequired: false,
                                minLines: 1,
                                maxLines: 2,
                                decoration: inputDecoration(
                                  context,
                                  hintText: locale.value.enterShortProductDescription,
                                  fillColor: context.cardColor,
                                  filled: true,
                                ),
                              )
                            ],
                          ).expand()
                        ],
                      ),
                    ),
                    16.height,
                    AppTextField(
                      title: locale.value.productDescription,
                      textStyle: primaryTextStyle(size: 12),
                      controller: addShopController.descriptionCont,
                      textFieldType: TextFieldType.MULTILINE,
                      isValidationRequired: false,
                      minLines: 4,
                      maxLines: 8,
                      decoration: inputDecoration(
                        context,
                        hintText: locale.value.enterProductDescription,
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ),
                    16.height,
                    Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Select Category
                          selectCategory(context).expand(),
                          if (addShopController.brandsList.isNotEmpty && !addShopController.isLoading.value) 16.width,
                          // Select Brand
                          if (addShopController.brandsList.isNotEmpty && !addShopController.isLoading.value) selectBrand(context).expand(),
                        ],
                      ),
                    ),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Select Tag
                        selectTags(context).expand(),
                        16.width,
                        // Select Unit
                        selectUnit(context).expand(),
                      ],
                    ),
                    30.height,
                    // Set Variation
                    Obx(
                      () => buildAddProductWithHeadingWidget(
                        setVariation(context),
                        title: locale.value.priceSkuStock,
                        addSpace: false,
                        ctx: context,
                      ).paddingBottom(addShopController.isHasVariation.value ? 16 : 30),
                    ),
                    // Product Discount
                    buildAddProductWithHeadingWidget(dateRangePickerWidget(context), title: locale.value.productDiscount, ctx: context),
                    // Set as Featured Product
                    20.height,
                    setFeaturedProduct(context),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              text: locale.value.save,
              textStyle: appButtonTextStyleWhite,
              width: Get.width,
              onTap: () {
                if (!addShopController.isLoading.value) {
                  if (addShopController.priceCont.text.startsWith('.')
                      || addShopController.priceCont.text.startsWith('-')) {
                    toast(locale.value.theInputtedPriceIsInvalid);
                  } else if (addShopController.discountAmountCont.text.contains('.')
                      || addShopController.discountAmountCont.text.startsWith('-')) {
                    toast(locale.value.theInputtedDiscountIsInvalid);
                  } else {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      log(addShopController.productImage.isEmpty);
                      if ((!isEdit && addShopController.imageFile.value.path.isEmpty) || (isEdit && addShopController.productImage.isEmpty)) {
                        toast(locale.value.pleaseSelectProductImage);

                        /// Open Gallery
                        hideKeyboard(context);
                        return;
                      }

                      /// Add Or Edit Product Api Call
                      addShopController.saveProduct();
                    } else {
                      addShopController.isFirstTime(false);
                    }
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
