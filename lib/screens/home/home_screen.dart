// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';

import '../../components/loader_widget.dart';
import '../../main.dart';
import '../../utils/empty_error_state_widget.dart';
import 'components/booking_request.dart';
import 'components/employee_report.dart';
import 'components/greetings_component.dart';
import 'components/my_reviews_component.dart';
import 'components/upcoming_booking.dart';
import 'home_controller.dart';
import 'model/dashboard_res_model.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeScreenController = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

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
        child: Obx(
          () => SnapHelperWidget(
            future: homeScreenController.getDashboardDetailFuture.value,
            initialData: showInitialData ? DashboardRes(data: homeScreenController.dashboardData.value) : null,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  homeScreenController.init();
                },
              ).paddingSymmetric(horizontal: 16);
            },
            loadingWidget: homeScreenController.isLoading.value ? const Offstage() : const LoaderWidget(),
            onSuccess: (dashboardData) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 16),
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    40.height,
                    GreetingsComponent(),
                    16.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EmployeeReports(),
                        UpcomingBookings(),
                        BookingsRequest(),
                        MyReviews(),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  bool get showInitialData => homeScreenController.dashboardData.value.review.isNotEmpty || homeScreenController.dashboardData.value.bookingRequest.isNotEmpty || homeScreenController.dashboardData.value.upcommingBooking.isNotEmpty;
}
