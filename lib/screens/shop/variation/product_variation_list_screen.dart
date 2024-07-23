import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';
import 'package:porosenocheckemployee/screens/shop/variation/product_variation_list_controller.dart';
import 'package:porosenocheckemployee/screens/shop/variation/services/variation_api.dart';

import '../../../components/bottom_selection_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/empty_error_state_widget.dart';
import 'add_variation_screen.dart';
import 'model/variation_list_response.dart';

class ProductVariationListScreen extends StatelessWidget {
  ProductVariationListScreen({super.key});

  final ProductVariationListController variationListController = Get.put(ProductVariationListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        appBartitleText: locale.value.variation,
        isLoading: variationListController.isLoading,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              bool? res = await Get.to(() => AddVariationScreen(), duration: const Duration(milliseconds: 800));
              if (res ?? false) {
                variationListController.page(1);
                variationListController.isLoading(true);
                variationListController.getVariationList(showLoader: true);
              }
            },
          )
        ],
        body: Stack(
          children: [
            SnapHelperWidget<List<VariationData>>(
              future: variationListController.getVariations.value,
              loadingWidget: const LoaderWidget(),
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.value.reload,
                  imageWidget: const ErrorStateWidget(),
                  onRetry: () {
                    variationListController.page(1);
                    variationListController.getVariationList(showLoader: true);
                  },
                );
              },
              onSuccess: (data) {
                return AnimatedListView(
                  shrinkWrap: true,
                  itemCount: variationListController.variationList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onSwipeRefresh: () async {
                    variationListController.page(1);
                    variationListController.getVariationList(showLoader: false);
                    return await Future.delayed(const Duration(seconds: 2));
                  },
                  itemBuilder: (context, index) {
                    VariationData variationData = variationListController.variationList[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      width: Get.width,
                      decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.rectangle),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (variationData.name.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(locale.value.variationName, style: secondaryTextStyle()),
                                    Text(variationData.name.validate(), style: primaryTextStyle()),
                                  ],
                                ),
                              if (variationData.type.isNotEmpty)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    16.height,
                                    Text(locale.value.variationType, style: secondaryTextStyle()),
                                    Text(variationData.type.validate(), style: primaryTextStyle(size: 15)),
                                  ],
                                ),
                            ],
                          ).expand(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildIconWidget(
                                icon: Assets.iconsIcEditReview,
                                onTap: () async {
                                  Get.to(() => AddVariationScreen(isEdit: true), arguments: variationData)?.then(
                                    (value) {
                                      if (value == true) {
                                        variationListController.page(1);
                                        variationListController.getVariationList(showLoader: true);
                                      }
                                    },
                                  );
                                },
                              ),
                              buildIconWidget(
                                icon: Assets.iconsIcDelete,
                                iconColor: cancelStatusColor,
                                onTap: () => handleDeleteBrandClick(variationListController.variationList, index, context),
                              ),
                            ],
                          ).visible(variationData.createdBy == loginUserData.value.id),
                        ],
                      ),
                    );
                  },
                  onNextPage: () {
                    if (!variationListController.isLastPage.value) {
                      variationListController.page++;
                      variationListController.getVariationList(showLoader: true);
                    }
                  },
                  emptyWidget: NoDataWidget(
                    title: locale.value.noVariationsFound,
                    imageWidget: const EmptyStateWidget(),
                    subTitle: locale.value.thereAreCurrentlyNoVariationsAvailable,
                    retryText: locale.value.reload,
                    onRetry: () {
                      variationListController.page(1);
                      variationListController.getVariationList(showLoader: true);
                    },
                  ).paddingSymmetric(horizontal: 16).visible(!variationListController.isLoading.value),
                );
              },
            ),
            Obx(() => const LoaderWidget().visible(variationListController.isLoading.value)),
          ],
        ),
      ),
    );
  }

  /*void handleFilterClick(BuildContext context) {
    doIfLoggedIn(context, () {
      serviceCommonBottomSheet(
        context,
        child: Obx(
          () => BottomSelectionSheet(
            heightRatio: 0.45,
            title: locale.value.filterBy,
            hideSearchBar: true,
            hintText: locale.value.searchForStatus,
            controller: TextEditingController(),
            hasError: false,
            isLoading: variationListController.isLoading,
            isEmpty: variationListController.allVariationsFilterStatus.isEmpty,
            noDataTitle: locale.value.statusListIsEmpty,
            noDataSubTitle: locale.value.thereAreNoStatus,
            listWidget: filterListWid(context),
          ),
        ),
      );
    });
  }*/

  /*Widget filterListWid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedWrap(
          runSpacing: 8,
          spacing: 8,
          itemCount: variationListController.allVariationsFilterStatus.length,
          listAnimationType: ListAnimationType.FadeIn,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  variationListController.selectedFilterStatus(variationListController.allVariationsFilterStatus[index]);
                },
                child: Container(
                  width: Get.width / 2.7,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: boxDecorationDefault(
                    color: variationListController.selectedFilterStatus.contains(variationListController.allVariationsFilterStatus[index])
                        ? isDarkMode.value
                            ? primaryColor
                            : lightPrimaryColor
                        : isDarkMode.value
                            ? lightPrimaryColor2
                            : Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 14,
                        color: isDarkMode.value ? whiteColor : primaryColor,
                      ).visible(variationListController.selectedFilterStatus.contains(variationListController.allVariationsFilterStatus[index])),
                      4.width.visible(variationListController.selectedFilterStatus.contains(variationListController.allVariationsFilterStatus[index])),
                      Text(
                        getServiceFilterEmployee(status: variationListController.allVariationsFilterStatus[index]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: secondaryTextStyle(
                          color: variationListController.selectedFilterStatus.contains(variationListController.allVariationsFilterStatus[index])
                              ? isDarkMode.value
                                  ? whiteColor
                                  : primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ).paddingOnly(top: 8, bottom: 0).expand(),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton(
              text: locale.value.apply,
              textStyle: appButtonTextStyleWhite,
              onTap: () {
                Get.back();
                variationListController.page(1);
                variationListController.getVariationList();
              },
            ).expand(),
          ],
        ),
      ],
    ).expand();
  }*/

  //region Delete the Brand
  Future<void> handleDeleteBrandClick(List<VariationData> variation, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYouDeleteBrand,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        variationListController.isLoading(true);
        VariationAPI.removeVariation(variationId: variation[index].id).then((value) {
          variation.removeAt(index);
          toast(value.message.trim());
          variationListController.page(1);
          variationListController.getVariationList();
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() => variationListController.isLoading(false));
      },
    );
  }

//endregion
}
