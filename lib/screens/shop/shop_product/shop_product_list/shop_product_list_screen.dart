import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/components/cached_image_widget.dart';
import 'package:porosenocheck_employee/components/loader_widget.dart';
import 'package:porosenocheck_employee/components/price_widget.dart';
import 'package:porosenocheck_employee/generated/assets.dart';
import 'package:porosenocheck_employee/main.dart';
import 'package:porosenocheck_employee/screens/booking_module/booking_detail/booking_detail_controller.dart';
import 'package:porosenocheck_employee/screens/shop/shop_product/product_detail/model/product_item_data_response.dart';
import 'package:porosenocheck_employee/screens/shop/shop_product/shop_product_list/services/shop_product_api.dart';
import 'package:porosenocheck_employee/screens/shop/shop_product/shop_product_list/shop_product_list_controller.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';
import 'package:porosenocheck_employee/utils/colors.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';
import 'package:porosenocheck_employee/utils/empty_error_state_widget.dart';

import '../../../../components/search_product_widget.dart';
import '../add_shop_product/add_shop_product_screen.dart';
import '../product_detail/product_detail_screen.dart';

class ShopProductListScreen extends StatelessWidget {
  ShopProductListScreen({Key? key}) : super(key: key);

  final ShopProductListController shopProductListController = Get.put(ShopProductListController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.products,
      isLoading: shopProductListController.isLoading,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            Get.to(() => AddShopProductScreen())?.then((value) {
              if (value == true) {
                shopProductListController.page(1);
                shopProductListController.isLoading(true);
                shopProductListController.getProductList();
              }
            });
          },
        )
      ],
      body: SizedBox(
        height: Get.height,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchProductWidget(
                shopProductListController: shopProductListController,
                onFieldSubmitted: (p0) {
                  hideKeyboard(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              SnapHelperWidget<List<ProductItemDataResponse>>(
                future: shopProductListController.getProducts.value,
                loadingWidget: const LoaderWidget(),
                errorBuilder: (error) {
                  return NoDataWidget(
                    title: error,
                    retryText: locale.value.reload,
                    imageWidget: const ErrorStateWidget(),
                    onRetry: () {
                      shopProductListController.page(1);
                      shopProductListController.getProductList();
                    },
                  );
                },
                onSuccess: (productList) {
                  return Obx(
                    () => AnimatedListView(
                      shrinkWrap: true,
                      itemCount: shopProductListController.productList.length,
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      scaleConfiguration: ScaleConfiguration(duration: const Duration(milliseconds: 400), delay: const Duration(milliseconds: 50)),
                      listAnimationType: ListAnimationType.FadeIn,
                      fadeInConfiguration: FadeInConfiguration(duration: const Duration(seconds: 2)),
                      itemBuilder: (ctx, index) {
                        ProductItemDataResponse productData = shopProductListController.productList[index];

                        return Obx(
                          () => GestureDetector(
                            onTap: () async {
                              await Get.to(() => const ProductDetailScreen(), arguments: productData.id.value);
                              shopProductListController.page(1);
                              shopProductListController.getProductList();
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: boxDecorationWithRoundedCorners(
                                borderRadius: radius(),
                                backgroundColor: context.cardColor,
                                border: isDarkMode.value ? Border.all(color: context.dividerColor) : null,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CachedImageWidget(
                                    url: productData.productImage.isNotEmpty ? productData.productImage.validate() : '',
                                    fit: BoxFit.cover,
                                    height: 80,
                                    width: 80,
                                    circle: false,
                                    radius: defaultRadius,
                                  ),
                                  10.width,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(productData.name, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      6.height,
                                      Marquee(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            if (productData.isDiscount) PriceWidget(price: productData.variationData.first.discountedProductPrice.validate().toDouble(), size: 14),
                                            if (productData.isDiscount) 4.width,
                                            PriceWidget(
                                              price: productData.variationData.first.taxIncludeProductPrice.validate().toDouble(),
                                              isLineThroughEnabled: productData.isDiscount ? true : false,
                                              isBoldText: productData.isDiscount ? false : true,
                                              size: productData.isDiscount ? 12 : 16,
                                              color: productData.isDiscount ? textSecondaryColorGlobal : null,
                                            ).visible(productData.variationData.isNotEmpty),
                                          ],
                                        ),
                                      ),
                                      6.height,
                                      RatingBarWidget(
                                        size: 12,
                                        disable: true,
                                        activeColor: getRatingBarColor(productData.rating.toInt()),
                                        rating: productData.rating.toDouble(),
                                        inActiveColor: ratingBarColor,
                                        onRatingChanged: (aRating) {},
                                      ),
                                    ],
                                  ).expand(),
                                  4.width,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      buildIconWidget(
                                        icon: Assets.iconsIcEditReview,
                                        onTap: () async {
                                          Get.to(() => AddShopProductScreen(isEdit: true), arguments: productData)?.then((result) {
                                            log('ShopProductScreen VALUE: $result');
                                            if (result == true) {
                                              shopProductListController.page(1);
                                              shopProductListController.isLoading(true);
                                              shopProductListController.getProductList();
                                            }
                                          });
                                        },
                                      ).visible(productData.createdBy == loginUserData.value.id),
                                      buildIconWidget(
                                        icon: Assets.iconsIcDelete,
                                        iconColor: cancelStatusColor,
                                        onTap: () => handleDeleteProductClick(productList, index, context),
                                      ).visible(productData.createdBy == loginUserData.value.id),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      emptyWidget: NoDataWidget(
                        title: locale.value.oppsLooksLikeYouHaveNotAddedAnyProductYet,
                        retryText: locale.value.addNewProduct,
                        imageWidget: const EmptyStateWidget(),
                        onRetry: () async {
                          Get.to(() => AddShopProductScreen())?.then((result) {
                            if (result == true) {
                              shopProductListController.page(1);
                              shopProductListController.isLoading(true);
                              shopProductListController.getProductList();
                            }
                          });
                        },
                      ).paddingSymmetric(horizontal: 30).visible(!shopProductListController.isLoading.value),
                      onSwipeRefresh: () async {
                        shopProductListController.page(1);
                        shopProductListController.getProductList(showLoader: false);
                        return await Future.delayed(const Duration(seconds: 2));
                      },
                      onNextPage: () {
                        if (!shopProductListController.isLastPage.value) {
                          shopProductListController.page++;
                          shopProductListController.isLoading(true);
                          shopProductListController.getProductList();
                        }
                      },
                    ),
                  );
                },
              ).expand(),
            ],
          ),
        ).paddingTop(16),
      ),
    );
  }

  Future<void> handleDeleteProductClick(List<ProductItemDataResponse> productList, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYouWantToDeleteThisProduct,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        shopProductListController.isLoading(true);
        ShopProductAPI.removeProduct(productId: productList[index].id.value).then((value) {
          productList.removeAt(index);
          if (value.message.trim().isNotEmpty) toast(locale.value.productDeleteSuccessfully);
          shopProductListController.getProductList();
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() => shopProductListController.isLoading(false));
      },
    );
  }
}
