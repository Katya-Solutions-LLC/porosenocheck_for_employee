import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';
import 'package:porosenocheckemployee/components/loader_widget.dart';
import 'package:porosenocheckemployee/main.dart';

import '../../../components/bottom_selection_widget.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/empty_error_state_widget.dart';
import 'employee_review_components.dart';
import 'employee_review_controller.dart';

class EmployeeReviewScreen extends StatelessWidget {
  EmployeeReviewScreen({Key? key}) : super(key: key);
  final EmployeeReviewController employeeReviewController = Get.put(EmployeeReviewController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasLeadingWidget: false,
      appBartitleText: locale.value.myReviews,
      isLoading: employeeReviewController.isLoading,
      actions: [
        if (!(loginUserData.value.userType.contains(EmployeeKeyConst.petStore) || !(loginUserData.value.userRole.contains(EmployeeKeyConst.petStore))))
          IconButton(
            onPressed: () async {
              handleFilterClick(context);
            },
            icon: commonLeadingWid(imgPath: Assets.iconsIcFilter, color: isDarkMode.value ? Colors.white : switchColor, icon: Icons.filter_alt_outlined, size: 24),
          ),
      ],
      body: Obx(
        () => SnapHelperWidget(
            future: employeeReviewController.getReview.value,
            initialData: employeeReviewController.employeeReview.isNotEmpty ? employeeReviewController.employeeReview : null,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  employeeReviewController.page(1);
                  employeeReviewController.isLoading(true);
                  employeeReviewController.init();
                },
              ).paddingSymmetric(horizontal: 32);
            },
            loadingWidget: const LoaderWidget(),
            onSuccess: (reviews) {
              return AnimatedListView(
                shrinkWrap: true,
                itemCount: reviews.length,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                emptyWidget: NoDataWidget(
                  title: locale.value.noDataFound,
                  subTitle: locale.value.thereAreNoReview,
                  titleTextStyle: primaryTextStyle(),
                  imageWidget: const EmptyStateWidget(),
                  onRetry: () {
                    employeeReviewController.page(1);
                    employeeReviewController.isLoading(false);
                    employeeReviewController.init();
                  },
                ).paddingSymmetric(horizontal: 32),
                itemBuilder: (context, index) {
                  return EmployeeReviewComponents(employeeReview: reviews[index]);
                },
                onNextPage: () async {
                  if (!employeeReviewController.isLastPage.value) {
                    employeeReviewController.page(employeeReviewController.page.value + 1);
                    employeeReviewController.isLoading(true);
                    employeeReviewController.init();
                    return await Future.delayed(const Duration(seconds: 2), () {
                      employeeReviewController.isLoading(false);
                    });
                  }
                },
                onSwipeRefresh: () async {
                  employeeReviewController.page(1);
                  return await employeeReviewController.init();
                },
              );
            }),
      ),
    );
  }

  void handleFilterClick(BuildContext context) {
    doIfLoggedIn(context, () {
      serviceCommonBottomSheet(
        context,
        child: Obx(
          () => BottomSelectionSheet(
            heightRatio: 0.45,
            title: locale.value.filterBy,
            hideSearchBar: true,
            hintText: locale.value.searchForStatus,
            controller: TextEditingController(),
            hasError: false,
            isLoading: employeeReviewController.isLoading,
            isEmpty: employeeReviewController.reviewStatus.isEmpty,
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
        AnimatedWrap(
          runSpacing: 12,
          spacing: 12,
          itemCount: employeeReviewController.reviewStatus.length,
          listAnimationType: ListAnimationType.None,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (employeeReviewController.selectedIndex.contains(employeeReviewController.reviewStatus[index])) {
                    employeeReviewController.selectedIndex.remove(employeeReviewController.reviewStatus[index]);
                  } else {
                    employeeReviewController.selectedIndex.add(employeeReviewController.reviewStatus[index]);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: boxDecorationDefault(
                    color: employeeReviewController.selectedIndex.contains(employeeReviewController.reviewStatus[index])
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
                      ).visible(employeeReviewController.selectedIndex.contains(employeeReviewController.reviewStatus[index])),
                      4.width.visible(employeeReviewController.selectedIndex.contains(employeeReviewController.reviewStatus[index])),
                      Text(
                        getReviewStatus(status: employeeReviewController.reviewStatus[index]),
                        style: secondaryTextStyle(
                          color: employeeReviewController.selectedIndex.contains(employeeReviewController.reviewStatus[index])
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
                employeeReviewController.selectedIndex.clear();
                employeeReviewController.isLoading(true);
                employeeReviewController.page(1);
                employeeReviewController.init();
              },
            ).expand(),
            16.width,
            AppButton(
              text: locale.value.apply,
              textStyle: appButtonTextStyleWhite,
              onTap: () {
                Get.back();
                employeeReviewController.page(1);
                employeeReviewController.isLoading(true);
                employeeReviewController.init();
              },
            ).expand(),
          ],
        ),
      ],
    ).expand();
  }
}
