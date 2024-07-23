import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';
import 'package:porosenocheckemployee/components/loader_widget.dart';
import 'package:porosenocheckemployee/screens/shop/orders/order_list/orders_controller.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';
import 'package:porosenocheckemployee/utils/colors.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';
import 'package:porosenocheckemployee/utils/empty_error_state_widget.dart';

import '../../../../components/bottom_selection_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../../../../utils/constants.dart';
import '../components/order_card.dart';
import '../model/order_detail_model.dart';

class OrderListScreen extends StatelessWidget {
  final bool isHideBack;
  OrderListScreen({super.key, this.isHideBack = false});

  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.orders,
      isLoading: orderController.isLoading,
      appBarTitleTextSize: APP_BAR_TEXT_SIZE,
      scaffoldBackgroundColor: context.scaffoldBackgroundColor,
      hasLeadingWidget: isHideBack ? false : true,
      actions: [
        IconButton(
          onPressed: () async {
            handleFilterClick(context);
          },
          icon: commonLeadingWid(imgPath: Assets.iconsIcFilter, color: isDarkMode.value ? Colors.white : switchColor, icon: Icons.filter_alt_outlined, size: 24),
        ),
      ],
      body: Obx(
        () => SnapHelperWidget<List<OrderListData>>(
          future: orderController.orderListFuture.value,
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                orderController.page(1);
                orderController.isLoading(true);
                orderController.getOrderList();
              },
            ).paddingSymmetric(horizontal: 16);
          },
          loadingWidget: const LoaderWidget(),
          onSuccess: (orderList) {
            return AnimatedListView(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: orderList.length,
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              emptyWidget: NoDataWidget(
                title: locale.value.noOrdersFound,
                subTitle: locale.value.thereAreCurrentlyNoOrders,
                imageWidget: const EmptyStateWidget(),
                retryText: locale.value.reload,
                onRetry: () {
                  orderController.page(1);
                  orderController.getOrderList();
                },
              ).paddingSymmetric(horizontal: 16),
              itemBuilder: (_, i) => NewOrderCard(
                getOrderData: orderList[i],
                onUpdateDeliveryStatus: () {
                  orderController.page(1);
                  orderController.getOrderList();
                },
              ),
              onNextPage: () {
                if (!orderController.isLastPage.value) {
                  orderController.page(orderController.page.value + 1);
                  orderController.getOrderList();
                }
              },
              onSwipeRefresh: () async {
                orderController.page(1);
                orderController.getOrderList(showLoader: false);
                return await Future.delayed(const Duration(seconds: 2));
              },
            );
          },
        ),
      ),
    );
  }

  void handleFilterClick(BuildContext context) {
    doIfLoggedIn(context, () {
      serviceCommonBottomSheet(
        context,
        child: Obx(
          () => BottomSelectionSheet(
            heightRatio: 0.55,
            title: locale.value.filterBy,
            hideSearchBar: true,
            hintText: locale.value.searchForStatus,
            controller: TextEditingController(),
            hasError: false,
            isLoading: orderController.isLoading,
            isEmpty: allOrderStatus.isEmpty,
            noDataTitle: locale.value.statusListIsEmpty,
            noDataSubTitle: locale.value.thereAreNoStatus,
            listWidget: statusListWid(context),
          ),
        ),
      );
    });
  }

  Widget statusListWid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.deliveryStatus, style: secondaryTextStyle()),
        16.height,
        AnimatedWrap(
          runSpacing: 12,
          spacing: 12,
          itemCount: allOrderStatus.length,
          listAnimationType: ListAnimationType.None,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (orderController.selectedIndex.contains(allOrderStatus[index].name)) {
                    orderController.selectedIndex.remove(allOrderStatus[index].name);
                  } else {
                    orderController.selectedIndex.add(allOrderStatus[index].name);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: boxDecorationDefault(
                    color: orderController.selectedIndex.contains(allOrderStatus[index].name)
                        ? isDarkMode.value
                            ? primaryColor
                            : lightPrimaryColor
                        : isDarkMode.value
                            ? lightPrimaryColor2
                            : Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check,
                        size: 14,
                        color: isDarkMode.value ? whiteColor : primaryColor,
                      ).visible(orderController.selectedIndex.contains(allOrderStatus[index].name)),
                      4.width.visible(orderController.selectedIndex.contains(allOrderStatus[index].name)),
                      Text(
                        getOrderStatus(status: allOrderStatus[index].name),
                        style: secondaryTextStyle(
                          color: orderController.selectedIndex.contains(allOrderStatus[index].name)
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
        ).paddingOnly(top: 10, bottom: 16),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton(
              text: locale.value.clearFilter,
              textStyle: appButtonTextStyleGray,
              color: lightSecondaryColor,
              onTap: () {
                Get.back();
                orderController.selectedIndex.clear();
                orderController.page(1);
                orderController.getOrderList();
              },
            ).expand(),
            16.width,
            AppButton(
              text: locale.value.apply,
              textStyle: appButtonTextStyleWhite,
              onTap: () {
                Get.back();
                orderController.page(1);
                orderController.getOrderList();
              },
            ).expand(),
          ],
        ),
      ],
    ).expand();
  }
}
