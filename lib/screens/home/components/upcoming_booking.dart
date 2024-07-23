import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/home/home_controller.dart';

import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/view_all_label_component.dart';
import '../../booking_module/booking_list/bookings_card.dart';
import '../dashboard_controller.dart';

class UpcomingBookings extends StatelessWidget {
  UpcomingBookings({super.key});

  final HomeController homeScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        16.height,
        ViewAllLabel(
          label: locale.value.upcomingBooking,
          isShowAll: false,
          onTap: () {
            bottomNavigateByIndex(1);
          },
        ).paddingSymmetric(horizontal: 16),
        Obx(
          () => homeScreenController.isLoading.value
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${locale.value.loading}.... ", style: secondaryTextStyle(size: 14, fontFamily: fontFamilyFontBold)).paddingSymmetric(vertical: Get.height * 0.12),
                  ],
                )
              : AnimatedListView(
                  shrinkWrap: true,
                  listAnimationType: ListAnimationType.None,
                  itemCount: homeScreenController.dashboardData.value.upcommingBooking.take(3).length,
                  physics: const NeverScrollableScrollPhysics(),
                  emptyWidget: NoDataWidget(
                    title: locale.value.noUpcomingBookingsYet,
                  ).paddingBottom(16).paddingSymmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return BookingsCard(booking: homeScreenController.dashboardData.value.upcommingBooking[index]);
                  },
                ),
        ),
      ],
    );
  }
}
