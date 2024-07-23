import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';

import '../../../../components/loader_widget.dart';
import '../../../../main.dart';
import '../../../../utils/empty_error_state_widget.dart';
import 'components/order_review_component.dart';
import 'order_review_controller.dart';

class OrderReviewScreen extends StatelessWidget {
  OrderReviewScreen({super.key});

  final OrderReviewController orderReviewController = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasLeadingWidget: false,
      appBartitleText: locale.value.myReviews,
      isLoading: orderReviewController.isLoading,
      body: Obx(
        () => SnapHelperWidget(
          future: orderReviewController.getOrderReview.value,
          initialData: orderReviewController.orderReview.isNotEmpty ? orderReviewController.orderReview : null,
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                orderReviewController.page(1);
                orderReviewController.isLoading(true);
                orderReviewController.init();
              },
            ).paddingSymmetric(horizontal: 32);
          },
          loadingWidget: const LoaderWidget(),
          onSuccess: (reviews) {
            return AnimatedListView(
              shrinkWrap: true,
              itemCount: reviews.length,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              emptyWidget: NoDataWidget(
                title: locale.value.noDataFound,
                subTitle: locale.value.thereAreNoReview,
                titleTextStyle: primaryTextStyle(),
                imageWidget: const EmptyStateWidget(),
                onRetry: () {
                  orderReviewController.page(1);
                  orderReviewController.isLoading(false);
                  orderReviewController.init();
                },
              ).paddingSymmetric(horizontal: 32),
              itemBuilder: (context, index) {
                return OrderReviewComponent(reviewData: reviews[index]);
              },
              onNextPage: () async {
                if (!orderReviewController.isLastPage.value) {
                  orderReviewController.page(orderReviewController.page.value + 1);
                  orderReviewController.isLoading(true);
                  orderReviewController.init();
                  return await Future.delayed(const Duration(seconds: 2), () {
                    orderReviewController.isLoading(false);
                  });
                }
              },
              onSwipeRefresh: () async {
                orderReviewController.page(1);
                return await orderReviewController.init();
              },
            );
          },
        ),
      ),
    );
  }
}
