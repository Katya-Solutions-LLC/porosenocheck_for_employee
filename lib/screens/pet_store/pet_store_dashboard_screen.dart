import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/screens/pet_store/pet_store_dashboard_controller.dart';
import 'package:porosenocheck_employee/screens/pet_store/store_home_controller.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';

import '../../../../components/app_scaffold.dart';
import '../../../../generated/assets.dart';
import '../../../../main.dart';
import '../auth/profile/profile_controller.dart';
import '../home/home_controller.dart';
import '../shop/orders/order_list/orders_controller.dart';
import '../shop/orders/order_review/order_review_controller.dart';

class PetStoreDashboardScreen extends StatelessWidget {
  PetStoreDashboardScreen({Key? key}) : super(key: key);
  final PetStoreDashboardController dashboardController = Get.put(PetStoreDashboardController());

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      message: locale.value.pressBackAgainToExitApp,
      child: AppScaffold(
        hideAppBar: true,
        isLoading: dashboardController.isLoading,
        body: Obx(() => dashboardController.screen[dashboardController.currentIndex.value]),
        bottomNavBar: Obx(
          () => NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: context.cardColor,
              indicatorColor: context.primaryColor.withOpacity(0.1),
              labelTextStyle: MaterialStateProperty.all(primaryTextStyle(size: 12)),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            child: NavigationBar(
              selectedIndex: dashboardController.currentIndex.value,
              onDestinationSelected: (v) {
                dashboardController.currentIndex(v);
                try {
                  if (v == 0) {
                    HomeController homeCont = Get.find();
                    homeCont.getDashboardDetail();
                  } else if (v == 1) {
                    StoreHomeController hCont = Get.find();
                    hCont.init();

                    OrderController orderController = Get.find();
                    orderController.page(1);
                    orderController.getOrderList();
                  } else if (v == 2) {
                    OrderReviewController rCont = Get.find();
                    rCont.init();
                  } else {
                    ProfileController pCont = Get.find();
                    pCont.getAboutPageData();
                  }
                } catch (e) {
                  log('onItemSelected Err: $e');
                }
              },
              destinations: [
                tab(
                  iconData: Assets.navigationIcHomeOutlined.iconImage(color: darkGray, size: 22),
                  activeIconData: Assets.navigationIcHomeFilled.iconImage(color: context.primaryColor, size: 22),
                  tabName: locale.value.home,
                ),
                tab(
                  iconData: Assets.navigationIcCalendarOutlined.iconImage(color: darkGray, size: 22),
                  activeIconData: Assets.navigationIcCalenderFilled.iconImage(color: context.primaryColor, size: 22),
                  tabName: locale.value.orders,
                ),
                tab(
                  iconData: Assets.profileIconsIcStarOutlined.iconImage(color: darkGray, size: 22),
                  activeIconData: Assets.navigationIcStarFilled.iconImage(color: context.primaryColor, size: 22),
                  tabName: locale.value.myReviews,
                ),
                tab(
                  iconData: Assets.navigationIcUserOutlined.iconImage(color: darkGray, size: 22),
                  activeIconData: Assets.navigationIcUserFilled.iconImage(color: context.primaryColor, size: 22),
                  tabName: locale.value.profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  NavigationDestination tab({required Widget iconData, required Widget activeIconData, required String tabName}) {
    return NavigationDestination(
      icon: iconData,
      selectedIcon: activeIconData,
      label: tabName,
    );
  }
}
