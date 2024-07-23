import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';

import '../../components/app_scaffold.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../auth/profile/profile_controller.dart';
import '../auth/review/employee_review_controller.dart';
import '../booking_module/booking_list/bookings_controller.dart';
import 'dashboard_controller.dart';
import 'home_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);
  final DashboardController dashboardController = Get.put(DashboardController());

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
                    HomeController hCont = Get.find();
                    hCont.getDashboardDetail(isFromSwipeRefresh: true);
                  } else if (v == 1) {
                    BookingsController bCont = Get.find();
                    bCont.page(1);
                    bCont.getBookingList(showloader: false);
                  } else if (v == 2) {
                    EmployeeReviewController rCont = Get.find();
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
                  tabName: locale.value.bookings,
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
