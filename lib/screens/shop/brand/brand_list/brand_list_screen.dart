import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/screens/shop/brand/brand_list/brand_list_controller.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../components/loader_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../../../../utils/app_common.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/empty_error_state_widget.dart';
import '../add_brand/add_brand_screen.dart';
import '../model/brand_list_response.dart';
import '../services/brand_api.dart';

class BrandListScreen extends StatelessWidget {
  BrandListScreen({super.key});

  final BrandListController brandListController = Get.put(BrandListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        appBartitleText: locale.value.brandList,
        isLoading: brandListController.isLoading,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: iconColor),
            onPressed: () async {
              bool? res = await Get.to(const AddBrandScreen(), duration: const Duration(milliseconds: 800));
              if (res ?? false) {
                brandListController.page(1);
                brandListController.isLoading(true);
                brandListController.getBrandList(showLoader: true);
              }
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (brandListController.selectedFilter.value != value) {
                brandListController.selectedFilter.value = value;
                brandListController.page(1);
                brandListController.getBrandList(showLoader: true);
              }
            },
            icon: Image.asset(
              Assets.iconsIcFilterOutlined,
              height: 20,
              width: 20,
              color: iconColor,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: Text(
                    locale.value.myBrands,
                    style: primaryTextStyle(color: brandListController.selectedFilter.value == 0 ? switchActiveTrackColor : null),
                  ),
                ),
                PopupMenuItem(
                  value: 1,
                  child: Text(
                    locale.value.addedByAdmin,
                    style: primaryTextStyle(color: brandListController.selectedFilter.value == 1 ? switchActiveTrackColor : null),
                  ),
                )
              ];
            },
          ),
        ],
        body: Stack(
          children: [
            SnapHelperWidget<List<BrandData>>(
              future: brandListController.getBrands.value,
              loadingWidget: const LoaderWidget(),
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.value.reload,
                  imageWidget: const ErrorStateWidget(),
                  onRetry: () {
                    brandListController.page(1);
                    brandListController.getBrandList(showLoader: true);
                  },
                );
              },
              onSuccess: (b) {
                return AnimatedListView(
                  shrinkWrap: true,
                  itemCount: brandListController.brandList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onSwipeRefresh: () async {
                    brandListController.page(1);
                    brandListController.getBrandList(showLoader: false);
                    return await Future.delayed(const Duration(seconds: 2));
                  },
                  itemBuilder: (context, index) {
                    BrandData brandData = brandListController.brandList[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      width: Get.width,
                      decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.rectangle),
                      child: Row(
                        children: [
                          CachedImageWidget(
                            url: brandData.brandImage.validate(),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            circle: true,
                          ),
                          16.width,
                          Text(brandData.name.validate(), style: primaryTextStyle()).expand(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildIconWidget(
                                icon: Assets.iconsIcEditReview,
                                onTap: () async {
                                  Get.to(() => const AddBrandScreen(isEdit: true), arguments: brandData)?.then(
                                    (value) {
                                      if (value == true) {
                                        brandListController.page(1);
                                        brandListController.getBrandList(showLoader: true);
                                      }
                                    },
                                  );
                                },
                              ),
                              buildIconWidget(
                                icon: Assets.iconsIcDelete,
                                iconColor: cancelStatusColor,
                                onTap: () => handleDeleteBrandClick(brandListController.brandList, index, context),
                              ),
                            ],
                          ).visible(brandData.createdBy == loginUserData.value.id),
                        ],
                      ),
                    );
                  },
                  onNextPage: () {
                    if (!brandListController.isLastPage.value) {
                      brandListController.page++;
                      brandListController.getBrandList(showLoader: true);
                    }
                  },
                  emptyWidget: NoDataWidget(
                    title: locale.value.noBrandFound,
                    imageWidget: const EmptyStateWidget(),
                    subTitle: locale.value.thereAreCurrentlyNoBrand,
                    retryText: locale.value.reload,
                    onRetry: () {
                      brandListController.page(1);
                      brandListController.getBrandList(showLoader: true);
                    },
                  ).paddingSymmetric(horizontal: 16).visible(!brandListController.isLoading.value),
                );
              },
            ),
            Obx(() => const LoaderWidget().visible(brandListController.isLoading.value)),
          ],
        ),
      ),
    );
  }

  //region Delete the Brand
  Future<void> handleDeleteBrandClick(List<BrandData> brand, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYouDeleteBrand,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        brandListController.isLoading(true);
        BrandAPI.removeBrand(brandId: brand[index].id).then((value) {
          brand.removeAt(index);
          toast(value.message.trim());
          brandListController.page(1);
          brandListController.getBrandList();
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() => brandListController.isLoading(false));
      },
    );
  }

//endregion
}
