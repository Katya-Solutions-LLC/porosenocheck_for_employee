// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/screens/pet_store/store_home_controller.dart';

import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../components/loader_widget.dart';
import '../../utils/colors.dart';
import '../auth/other/notification_screen.dart';
import '../home/home_controller.dart';
import 'components/order_component.dart';
import 'components/total_component.dart';

class StoreHomeScreen extends StatelessWidget {
  final HomeController homeScreenController = Get.put(HomeController());
  final StoreHomeController storeHomeController = Get.put(StoreHomeController());

  StoreHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      hasLeadingWidget: false,
      isLoading: homeScreenController.isLoading,
      body: RefreshIndicator(
        onRefresh: () async {
          return await homeScreenController.getDashboardDetail(isFromSwipeRefresh: true);
        },
        child: AnimatedScrollView(
          listAnimationType: ListAnimationType.None,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Text(
                        '${locale.value.hello}, ${loginUserData.value.userName.isNotEmpty ? loginUserData.value.userName : locale.value.guest} 👋',
                        style: primaryTextStyle(size: 20),
                      ),
                    ),
                    const Spacer(),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => NotificationScreen());
                          },
                          child: Image.asset(Assets.iconsIcNotification, width: 26, height: 26),
                        ),
                        Positioned(
                          top: homeScreenController.dashboardData.value.notificationCount < 10 ? -8 : -4,
                          right: homeScreenController.dashboardData.value.notificationCount < 10 ? 0 : 0,
                          child: Obx(() => Container(
                            padding: const EdgeInsets.all(4),
                            decoration: boxDecorationDefault(color: primaryColor, shape: BoxShape.circle),
                            child: Text(
                              '${homeScreenController.dashboardData.value.notificationCount}',
                              style: primaryTextStyle(size: homeScreenController.dashboardData.value.notificationCount < 10 ? 10 : 8, color: white),
                            ),
                          ).visible(homeScreenController.dashboardData.value.notificationCount > 0)),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
                16.height,
                Column(
                  children: [
                    Obx(
                      () => SnapHelperWidget(
                        future: homeScreenController.getDashboardDetailFuture.value,
                        errorBuilder: (error) {
                          return NoDataWidget(
                            title: error,
                            retryText: locale.value.reload,
                            onRetry: () {
                              homeScreenController.init();
                            },
                          ).paddingSymmetric(horizontal: 16);
                        },
                        loadingWidget: homeScreenController.isLoading.value ? const Offstage() : const LoaderWidget(),
                        onSuccess: (data) {
                          return Column(
                            children: [
                              TotalComponent(),
                              OrderComponent(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingOnly(top: 60),
          ],
        ),
      ),
    );
  }
}
