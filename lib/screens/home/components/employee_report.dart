import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/screens/home/home_controller.dart';

import '../../../components/employee_total_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/constants.dart';
import '../../shop/orders/order_list/order_list_screen.dart';
import '../../shop/shop_product/shop_product_list/shop_product_list_screen.dart';
import '../dashboard_controller.dart';

class EmployeeReports extends StatelessWidget {
  EmployeeReports({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          EmployeeTotalWidget(
            title: 'Total Bookings', //TODO: string
            total: homeController.dashboardData.value.totalBooking.toString(),
            icon: Assets.iconsIcTotalBooking,
          ).onTap(() {
            DashboardController hCont = Get.find();
            hCont.currentIndex(1);
          }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
          if (loginUserData.value.userRole.contains(EmployeeKeyConst.petStore) || loginUserData.value.isEnableStore.getBoolInt())
            EmployeeTotalWidget(
              title: locale.value.totalProducts,
              total: homeController.dashboardData.value.petstoreDetail.productCount.toString(),
              icon: Assets.profileIconsIcShopUnit,
            ).onTap(() {
              Get.to(() => ShopProductListScreen(), duration: const Duration(milliseconds: 800));
            }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
          if (loginUserData.value.userRole.contains(EmployeeKeyConst.petStore) || loginUserData.value.isEnableStore.getBoolInt())
            EmployeeTotalWidget(
              title: locale.value.totalOrders,
              total: homeController.dashboardData.value.petstoreDetail.orderCount.toString(),
              icon: Assets.navigationIcShopOutlined,
            ).onTap(() {
              Get.to(() => OrderListScreen(), duration: const Duration(milliseconds: 800));
            }, highlightColor: Colors.transparent, splashColor: Colors.transparent),
          if (loginUserData.value.userRole.contains(EmployeeKeyConst.petStore) || loginUserData.value.isEnableStore.getBoolInt())
            EmployeeTotalWidget(
              title: locale.value.pendingOrderPayout,
              total: homeController.dashboardData.value.petstoreDetail.pendingOrderPayout.toString(),
              icon: Assets.iconsIcPercentLine,
              isPrice: true,
            ),
          EmployeeTotalWidget(
            title: locale.value.pendingBookingPayout,
            total: homeController.dashboardData.value.pendingServicePayout.toString(),
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
      ).paddingAll(16),
    );
  }
}
