import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/home/home_controller.dart';

import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/view_all_label_component.dart';
import '../../shop/orders/components/order_card.dart';
import '../pet_store_dashboard_controller.dart';

class OrderComponent extends StatelessWidget {
  OrderComponent({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.height,
        ViewAllLabel(
          label: locale.value.orders,
          isShowAll: false,
          onTap: () {
            bottomNavigateByIndex(1);
          },
        ).paddingSymmetric(horizontal: 16),
        Obx(
          () => homeController.isLoading.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${locale.value.loading}.... ", style: secondaryTextStyle(size: 14, fontFamily: fontFamilyFontBold)).paddingSymmetric(vertical: Get.height * 0.12),
                  ],
                )
              : AnimatedListView(
                  shrinkWrap: true,
                  listAnimationType: ListAnimationType.None,
                  itemCount: homeController.dashboardData.value.petstoreDetail.order.take(4).length,
                  physics: const NeverScrollableScrollPhysics(),
                  emptyWidget: NoDataWidget(
                    title: locale.value.thereAreCurrentlyNoOrders,
                  ).paddingSymmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return NewOrderCard(getOrderData: homeController.dashboardData.value.petstoreDetail.order[index]);
                  },
                ),
        ),
      ],
    );
  }
}
