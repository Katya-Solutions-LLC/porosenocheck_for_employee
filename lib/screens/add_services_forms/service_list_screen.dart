import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/components/app_scaffold.dart';
import 'package:porosenocheckemployee/screens/add_services_forms/add_service_form.dart';
import 'package:porosenocheckemployee/screens/add_services_forms/service_api.dart';
import 'package:porosenocheckemployee/screens/add_services_forms/service_detail_screen.dart';
import 'package:porosenocheckemployee/screens/add_services_forms/service_list_controller.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';

import '../../components/bottom_selection_widget.dart';
import '../../components/cached_image_widget.dart';
import '../../components/loader_widget.dart';
import '../../components/price_widget.dart';
import '../../components/search_service_widget.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../../utils/app_common.dart';
import '../../utils/colors.dart';
import '../../utils/empty_error_state_widget.dart';
import 'model/service_list_model.dart';

class ServiceListScreen extends StatelessWidget {
  ServiceListScreen({super.key});

  final ServiceListController selectServiceListController = Get.put(ServiceListController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        appBartitleText: getServiceFilterEmployee(status: selectServiceListController.selectedFilterStatus.toString()),
        isLoading: selectServiceListController.isLoading,
        actions: [
          IconButton(
            onPressed: () async {
              hideKeyboard(context);
              handleFilterClick(context);
            },
            icon: commonLeadingWid(imgPath: Assets.iconsIcFilter, color: isDarkMode.value ? Colors.white : switchColor, icon: Icons.filter_alt_outlined, size: 24),
          ),
          IconButton(
            onPressed: () async {
              Get.to(() => AddServiceForm())?.then((value) {
                if (value == true) {
                  selectServiceListController.page(1);
                  selectServiceListController.isLoading(true);
                  selectServiceListController.getServiceList();
                }
              });
            },
            icon: Icon(Icons.add, size: 28, color: isDarkMode.value ? Colors.white : switchColor),
            tooltip: locale.value.addServices,
          ).paddingOnly(right: 8),
        ],
        body: SizedBox(
          height: Get.height,
          child: Obx(
            () => Column(
              children: [
                SearchServiceWidget(
                  serviceController: selectServiceListController,
                  onFieldSubmitted: (p0) {
                    hideKeyboard(context);
                  },
                ).paddingSymmetric(horizontal: 16),
                16.height,
                SnapHelperWidget<List<ServiceData>>(
                  future: selectServiceListController.getServices.value,
                  loadingWidget: const LoaderWidget(),
                  errorBuilder: (error) {
                    return NoDataWidget(
                      title: error,
                      retryText: locale.value.reload,
                      imageWidget: const ErrorStateWidget(),
                      onRetry: () {
                        selectServiceListController.page(1);
                        selectServiceListController.getServiceList();
                      },
                    );
                  },
                  onSuccess: (serviceList) {
                    return Obx(
                      () => AnimatedListView(
                        shrinkWrap: true,
                        itemCount: serviceList.length,
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 16),
                        physics: const AlwaysScrollableScrollPhysics(),
                        listAnimationType: ListAnimationType.None,
                        emptyWidget: NoDataWidget(
                          title: locale.value.oppsLooksLikeYou,
                          retryText: locale.value.addNewService,
                          imageWidget: const EmptyStateWidget(),
                          onRetry: () async {
                            Get.to(() => AddServiceForm())?.then((result) {
                              if (result == true) {
                                selectServiceListController.page(1);
                                selectServiceListController.isLoading(true);
                                selectServiceListController.getServiceList();
                              }
                            });
                          },
                        ).paddingSymmetric(horizontal: 32),
                        onSwipeRefresh: () async {
                          selectServiceListController.page(1);
                          selectServiceListController.getServiceList(showloader: false);
                          return await Future.delayed(const Duration(seconds: 2));
                        },
                        onNextPage: () async {
                          if (!selectServiceListController.isLastPage.value) {
                            selectServiceListController.page++;
                            selectServiceListController.isLoading(true);
                            selectServiceListController.getServiceList();
                          }
                        },
                        itemBuilder: (ctx, index) {
                          ServiceData serviceData = serviceList[index];

                          return Obx(
                            () => GestureDetector(
                              onTap: () {
                                serviceCommonBottomSheet(
                                  context,
                                  child: ServiceDetailScreen(serviceInfo: serviceData),
                                );
                              },
                              child: Container(
                                width: Get.width,
                                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: boxDecorationWithRoundedCorners(
                                  borderRadius: radius(),
                                  backgroundColor: context.cardColor,
                                  border: isDarkMode.value ? Border.all(color: context.dividerColor) : null,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CachedImageWidget(
                                      url: serviceData.serviceImage.isNotEmpty ? serviceData.serviceImage : '',
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                      circle: false,
                                      radius: defaultRadius,
                                    ),
                                    10.width,
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(serviceData.name.validate(), style: secondaryTextStyle(color: isDarkMode.value ? primaryColor : primaryTextColor, size: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                                        Text(
                                          serviceData.categoryName.validate(),
                                          style: secondaryTextStyle(color: isDarkMode.value ? textSecondaryColorGlobal : primaryColor, size: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ).paddingTop(6).visible(serviceData.categoryName.isNotEmpty),
                                        Container(
                                          alignment: Alignment.center,
                                          width: Get.width * 0.25,
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: boxDecorationWithShadow(backgroundColor: primaryColor, borderRadius: radius(24)),
                                          child: PriceWidget(
                                            price: serviceData.defaultPrice,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ).scale(scale: 0.92).paddingTop(11).visible(serviceData.defaultPrice != 0),
                                      ],
                                    ).expand(),
                                    4.width,
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildIconWidget(
                                          icon: Assets.iconsIcEditReview,
                                          onTap: () async {
                                            Get.to(() => AddServiceForm(isEdit: true), arguments: serviceData)?.then((value) {
                                              log('ServiceScreen VALUE: $value');
                                              if (value == true) {
                                                selectServiceListController.page(1);
                                                selectServiceListController.isLoading(true);
                                                selectServiceListController.getServiceList();
                                              }
                                            });
                                          },
                                        ).visible(serviceData.createdBy == loginUserData.value.id),
                                        buildIconWidget(
                                          icon: Assets.iconsIcDelete,
                                          iconColor: cancelStatusColor,
                                          onTap: () => handleDeleteServiceClick(serviceList, index, context),
                                        ).visible(serviceData.createdBy == loginUserData.value.id),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).visible(!selectServiceListController.isLoading.value),
                    );
                  },
                ).expand(),
              ],
            ),
          ).paddingTop(16),
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
            heightRatio: 0.44,
            title: locale.value.filterBy,
            hideSearchBar: true,
            hintText: locale.value.searchForStatus,
            controller: TextEditingController(),
            hasError: false,
            isLoading: selectServiceListController.isLoading,
            isEmpty: selectServiceListController.allServiceFilterStatus.isEmpty,
            noDataTitle: locale.value.statusListIsEmpty,
            noDataSubTitle: locale.value.thereAreNoStatus,
            listWidget: filterListWid(context),
          ),
        ),
      );
    });
  }

  Widget filterListWid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedWrap(
          runSpacing: 8,
          spacing: 8,
          itemCount: selectServiceListController.allServiceFilterStatus.length,
          listAnimationType: ListAnimationType.FadeIn,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  selectServiceListController.selectedFilterStatus(selectServiceListController.allServiceFilterStatus[index]);
                },
                child: Container(
                  width: Get.width / 2.7,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: boxDecorationDefault(
                    color: selectServiceListController.selectedFilterStatus.contains(selectServiceListController.allServiceFilterStatus[index])
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
                      ).visible(selectServiceListController.selectedFilterStatus.contains(selectServiceListController.allServiceFilterStatus[index])),
                      4.width.visible(selectServiceListController.selectedFilterStatus.contains(selectServiceListController.allServiceFilterStatus[index])),
                      Text(
                        getServiceFilterEmployee(status: selectServiceListController.allServiceFilterStatus[index]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: secondaryTextStyle(
                          color: selectServiceListController.selectedFilterStatus.contains(selectServiceListController.allServiceFilterStatus[index])
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
        AppButton(
          text: locale.value.apply,
          textStyle: appButtonTextStyleWhite,
          width: Get.width,
          onTap: () {
            Get.back();
            selectServiceListController.page(1);
            selectServiceListController.getServiceList();
          },
        ),
      ],
    ).expand();
  }

  Widget buildIconWidget({required String icon, required VoidCallback onTap, Color? iconColor}) {
    return SizedBox(
      height: 38,
      width: 38,
      child: IconButton(padding: EdgeInsets.zero, icon: icon.iconImage(size: 18, color: iconColor), onPressed: onTap),
    );
  }

  Future<void> handleDeleteServiceClick(List<ServiceData> serviceList, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYou,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        selectServiceListController.isLoading(true);
        ServiceFormApis.removeService(serviceId: serviceList[index].id.value).then((value) {
          serviceList.removeAt(index);
          if (value.message.trim().isNotEmpty) toast(locale.value.serviceDeleteSuccessfully);
          selectServiceListController.getServiceList();
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() => selectServiceListController.isLoading(false));
      },
    );
  }
}
