import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/components/cached_image_widget.dart';
import 'package:porosenocheck_employee/components/loader_widget.dart';
import 'package:porosenocheck_employee/main.dart';
import 'package:porosenocheck_employee/screens/shop/supply_logistic/logistics/model/logistic_list_response.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';
import 'package:porosenocheck_employee/utils/colors.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';
import 'package:porosenocheck_employee/utils/empty_error_state_widget.dart';

import '../../../../../components/bottom_selection_widget.dart';
import 'logistic_list_controller.dart';

class LogisticListScreen extends StatelessWidget {
  LogisticListScreen({Key? key}) : super(key: key);

  final LogisticController logisticController = Get.put(LogisticController());

  //endregion
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        appBartitleText: 'Logistic List',
        actions: const [
          //TODO: Uncomment in futue update
          /*IconButton(
            onPressed: () async {
              hideKeyboard(context);
              handleFilterClick(context);
            },
            icon: commonLeadingWid(imgPath: Assets.iconsIcFilter, color: switchColor, icon: Icons.filter_alt_outlined, size: 24),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              bool? res = await Get.to(const AddLogisticScreen(), duration: const Duration(milliseconds: 800));
              if (res ?? false) {
                logisticController.page(1);
                logisticController.getLogistics();
              }
            },
          )*/
        ],
        body: Stack(
          children: [
            SnapHelperWidget<List<LogisticData>>(
              future: logisticController.getLogisticList.value,
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.value.reload,
                  imageWidget: const ErrorStateWidget(),
                  onRetry: () {
                    logisticController.page(1);
                    logisticController.getLogistics();
                  },
                );
              },
              onSuccess: (b) {
                return AnimatedListView(
                  shrinkWrap: true,
                  itemCount: logisticController.logisticList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  listAnimationType: ListAnimationType.FadeIn,
                  onSwipeRefresh: () async {
                    logisticController.page(1);
                    logisticController.getLogistics(showLoader: false);
                    return await Future.delayed(const Duration(seconds: 2));
                  },
                  itemBuilder: (context, index) {
                    LogisticData data = logisticController.logisticList[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      width: Get.width,
                      decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.rectangle),
                      child: Row(
                        children: [
                          CachedImageWidget(
                            url: data.logisticImage.validate(),
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                            circle: true,
                          ),
                          16.width,
                          Text(data.name.validate(), style: primaryTextStyle()).expand(),
                          //TODO:
                          /*Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildIconWidget(
                                icon: Assets.iconsIcEditReview,
                                onTap: () async {
                                  Get.to(() => const AddLogisticScreen(isEdit: true), arguments: data)?.then(
                                    (value) {
                                      if (value == true) {
                                        logisticController.page(1);
                                        logisticController.getLogistics();
                                      }
                                    },
                                  );
                                },
                              ),
                              buildIconWidget(
                                icon: Assets.iconsIcDelete,
                                iconColor: cancelStatusColor,
                                onTap: () => logisticController.handleDeleteLogisticClick(logisticController.logisticList, index, context),
                              ),
                            ],
                          ).visible(data.createdBy == loginUserData.value.id),*/
                        ],
                      ),
                    );
                  },
                  onNextPage: () {
                    if (!logisticController.isLastPage.value) {
                      logisticController.page++;
                      logisticController.getLogistics();
                    }
                  },
                  emptyWidget: NoDataWidget(
                    title: locale.value.noLogisticFound,
                    imageWidget: const EmptyStateWidget(),
                    subTitle: locale.value.thereAreCurrentlyNoLogisticAvailable,
                    retryText: locale.value.reload,
                    onRetry: () {
                      logisticController.page(1);
                      logisticController.getLogistics();
                    },
                  ).paddingSymmetric(horizontal: 16).visible(!logisticController.isLoading.value),
                );
              },
            ),
            const LoaderWidget().visible(logisticController.isLoading.value)
          ],
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
            isLoading: logisticController.isLoading,
            isEmpty: logisticController.allFilterStatus.isEmpty,
            noDataTitle: locale.value.statusListIsEmpty,
            noDataSubTitle: locale.value.thereAreNoStatus,
            listWidget: filterListWid(context),
          ),
        ),
      );
    });
  }

  //region Filter list
  Widget filterListWid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedWrap(
          runSpacing: 8,
          spacing: 8,
          itemCount: logisticController.allFilterStatus.length,
          listAnimationType: ListAnimationType.None,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  logisticController.selectedFilterStatus(logisticController.allFilterStatus[index]);
                },
                child: Container(
                  width: Get.width / 2.7,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: boxDecorationDefault(
                    color: logisticController.selectedFilterStatus.contains(logisticController.allFilterStatus[index])
                        ? isDarkMode.value
                            ? primaryColor
                            : lightPrimaryColor
                        : isDarkMode.value
                            ? lightPrimaryColor2
                            : Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 14,
                        color: isDarkMode.value ? whiteColor : primaryColor,
                      ).visible(logisticController.selectedFilterStatus.contains(logisticController.allFilterStatus[index])),
                      4.width.visible(logisticController.selectedFilterStatus.contains(logisticController.allFilterStatus[index])),
                      Text(
                        getServiceFilterEmployee(status: logisticController.allFilterStatus[index]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: secondaryTextStyle(
                          color: logisticController.selectedFilterStatus.contains(logisticController.allFilterStatus[index])
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
        ).paddingOnly(top: 8, bottom: 0).expand(),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton(
              text: locale.value.apply,
              textStyle: appButtonTextStyleWhite,
              onTap: () {
                Get.back();
                logisticController.page(1);
                logisticController.getLogistics();
              },
            ).expand(),
          ],
        ),
      ],
    ).expand();
  }
}
