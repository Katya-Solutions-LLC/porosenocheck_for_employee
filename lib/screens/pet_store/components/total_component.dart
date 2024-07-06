import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/employee_total_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../home/home_controller.dart';
import '../../shop/orders/order_list/order_list_screen.dart';
import '../../shop/shop_product/shop_product_list/shop_product_list_screen.dart';

class TotalComponent extends StatelessWidget {
  final HomeController homeController = Get.find();

  TotalComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        EmployeeTotalWidget(
          title: locale.value.totalProducts,
          total: homeController.dashboardData.value.petstoreDetail.productCount.toString(),
          icon: Assets.profileIconsIcShopUnit,
        ).onTap(() {
          Get.to(() => ShopProductListScreen(), duration: const Duration(milliseconds: 800));
        }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
        EmployeeTotalWidget(
          title: locale.value.totalOrders,
          total: homeController.dashboardData.value.petstoreDetail.orderCount.toString(),
          icon: Assets.navigationIcShopOutlined,
        ).onTap(() {
          Get.to(() => OrderListScreen(), duration: const Duration(milliseconds: 800));
        }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
        EmployeeTotalWidget(
          title: locale.value.pendingOrderPayout,
          total: homeController.dashboardData.value.petstoreDetail.pendingOrderPayout.toString(),
          icon: Assets.iconsIcPercentLine,
          isPrice: true,
        ),
        EmployeeTotalWidget(
          title: locale.value.totalRevenue,
          total: homeController.dashboardData.value.totalRevenue.toString(),
          icon: Assets.iconsIcPercentLine,
          isPrice: true,
        ),
      ],
    ).paddingAll(16);
  }
}
