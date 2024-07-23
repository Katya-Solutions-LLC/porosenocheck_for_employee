import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';
import 'package:porosenocheckemployee/components/loader_widget.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/screens/shop/shop_product/product_detail/model/product_detail_response.dart';
import 'package:porosenocheckemployee/screens/shop/shop_product/product_detail/product_detail_controller.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';
import 'package:porosenocheckemployee/utils/empty_error_state_widget.dart';

import '../../../../generated/assets.dart';
import '../add_shop_product/add_shop_product_screen.dart';
import 'component/delivery_option_components.dart';
import 'component/food_packet_components.dart';
import 'component/product_info_component.dart';
import 'component/product_slider_components.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailController productDetailController = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future(() => false);
      },
      child: AppScaffold(
        isLoading: productDetailController.isLoading,
        hideAppBar: true,
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () async {
              productDetailController.getProductDetails(isFromSwipeRefresh: true);
              return await Future.delayed(const Duration(seconds: 2));
            },
            child: SnapHelperWidget<ProductDetailResponse>(
              future: productDetailController.productDetailsFuture.value,
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.value.reload,
                  imageWidget: const ErrorStateWidget(),
                  onRetry: () {
                    productDetailController.isLoading(true);
                    productDetailController.init();
                  },
                ).paddingSymmetric(horizontal: 16);
              },
              loadingWidget: const LoaderWidget(),
              onSuccess: (snap) {
                if (snap.data.id.isNegative) {
                  return NoDataWidget(
                    title: locale.value.noDetailFound,
                    retryText: locale.value.reload,
                    onRetry: () {
                      productDetailController.isLoading(true);
                      productDetailController.init();
                    },
                  );
                }
                return Stack(
                  children: [
                    AnimatedScrollView(
                      listAnimationType: ListAnimationType.FadeIn,
                      padding: const EdgeInsets.only(bottom: 85),
                      children: [
                        ProductSlider(productGalleryData: [snap.data.productImage.validate()]),
                        16.height,
                        ProductInfoComponent(productData: snap.data),
                        FoodPacketComponents(productData: snap.data),
                        DeliveryOptionComponents(productData: snap.data),
                      ],
                    ),
                    Positioned(
                      top: context.statusBarHeight + 8,
                      left: 16,
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: white),
                        child: backButton(context),
                      ).scale(scale: 0.8),
                    ),
                    Positioned(
                      top: context.statusBarHeight + 8,
                      right: 16,
                      child: Container(
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: white),
                        child: buildIconWidget(
                          icon: Assets.iconsIcEditReview,
                          onTap: () async {
                            Get.to(() => AddShopProductScreen(isEdit: true), arguments: snap.data)?.then((result) {
                              log('ShopProductScreen VALUE: $result');
                              if (result == true) {
                                productDetailController.isLoading(true);
                                productDetailController.init();
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
