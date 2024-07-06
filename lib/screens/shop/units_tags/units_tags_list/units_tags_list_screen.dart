import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/app_scaffold.dart';
import 'package:porosenocheck_employee/components/loader_widget.dart';
import 'package:porosenocheck_employee/generated/assets.dart';
import 'package:porosenocheck_employee/screens/shop/units_tags/units_tags_list/units_tags_controller.dart';
import 'package:porosenocheck_employee/utils/colors.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';
import 'package:porosenocheck_employee/utils/empty_error_state_widget.dart';

import '../../../../components/bottom_selection_widget.dart';
import '../../../../main.dart';
import '../../../../utils/app_common.dart';
import '../add_update_units_tags/add_units_tags_screen.dart';
import '../model/unit_tag_list_response.dart';
import '../services/unit_tag_api.dart';

class UnitsTagsScreen extends StatelessWidget {
  UnitsTagsScreen({super.key});

  final UnitsTagsController unitsTagsController = Get.put(UnitsTagsController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: Get.arguments == true ? locale.value.tagList : locale.value.unitsList,
      actions: [
        IconButton(
          icon: const Icon(Icons.add, color: iconColor),
          onPressed: () async {
            Map arg = {
              "isFromTag": Get.arguments == true ? true : false,
              "data": null,
            };

            Get.to(() => const AddUnitTagsScreen(), arguments: arg)?.then((value) {
              if (value == true) {
                unitsTagsController.isLoading(true);
                unitsTagsController.page(1);
                unitsTagsController.getUnitTagList();
              }
            });
          },
        ),
        PopupMenuButton(
          onSelected: (value) {
            if (unitsTagsController.selectedFilter.value != value) {
              unitsTagsController.selectedFilter.value = value;
              unitsTagsController.page(1);
              unitsTagsController.getUnitTagList(showLoader: true);
            }
          },
          icon: Image.asset(
            Assets.iconsIcFilterOutlined,
            height: 20,
            width: 20,
            color: iconColor,
          ),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 0,
                child: Text(
                  Get.arguments == true ? locale.value.myTags : locale.value.myUnits,
                  style: primaryTextStyle(color: unitsTagsController.selectedFilter.value == 0 ? switchActiveTrackColor : null),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  locale.value.addedByAdmin,
                  style: primaryTextStyle(color: unitsTagsController.selectedFilter.value == 1 ? switchActiveTrackColor : null),
                ),
              )
            ];
          },
        ),
      ],
      body: Obx(
        () => Stack(
          children: [
            SnapHelperWidget<List<UnitTagData>>(
              future: unitsTagsController.getUnitTags.value,
              loadingWidget: const LoaderWidget(),
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.value.reload,
                  imageWidget: const ErrorStateWidget(),
                  onRetry: () {
                    unitsTagsController.page(1);
                    unitsTagsController.getUnitTagList(showLoader: true);
                  },
                );
              },
              onSuccess: (b) {
                return AnimatedListView(
                  shrinkWrap: true,
                  itemCount: unitsTagsController.list.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onSwipeRefresh: () async {
                    unitsTagsController.page(1);
                    unitsTagsController.getUnitTagList(showLoader: false);
                    return await Future.delayed(const Duration(seconds: 1));
                  },
                  itemBuilder: (context, index) {
                    UnitTagData data = unitsTagsController.list[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      width: Get.width,
                      decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.rectangle),
                      child: Row(
                        children: [
                          Text(data.name.validate(), style: primaryTextStyle()).expand(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildIconWidget(
                                icon: Assets.iconsIcEditReview,
                                onTap: () async {
                                  Map arg = {
                                    "isFromTag": Get.arguments == true ? true : false,
                                    "data": data,
                                  };

                                  Get.to(() => const AddUnitTagsScreen(isEdit: true), arguments: arg)?.then(
                                    (value) {
                                      if (value == true) {
                                        unitsTagsController.page(1);
                                        unitsTagsController.getUnitTagList(showLoader: true);
                                      }
                                    },
                                  );
                                  Get.to(() => const AddUnitTagsScreen(isEdit: true), arguments: data)?.then(
                                    (value) {
                                      if (value == true) {
                                        unitsTagsController.page(1);
                                        unitsTagsController.getUnitTagList(showLoader: true);
                                      }
                                    },
                                  );
                                },
                              ),
                              buildIconWidget(
                                icon: Assets.iconsIcDelete,
                                iconColor: cancelStatusColor,
                                onTap: () => handleDeleteClick(unitsTagsController.list, index, context, isFromTag: Get.arguments == true ? true : false),
                              ),
                            ],
                          ).visible(data.createdBy == loginUserData.value.id),
                        ],
                      ),
                    );
                  },
                  onNextPage: () {
                    if (!unitsTagsController.isLastPage.value) {
                      unitsTagsController.page++;
                      unitsTagsController.getUnitTagList();
                    }
                  },
                  emptyWidget: NoDataWidget(
                    title: Get.arguments == true ? locale.value.tagSNotFound : locale.value.noUnitsFound,
                    imageWidget: const EmptyStateWidget(),
                    subTitle: Get.arguments == true ? locale.value.thereAreCurrentlyNoTags : locale.value.thereAreCurrentlyNoUnitsAvailable,
                    retryText: locale.value.reload,
                    onRetry: () {
                      unitsTagsController.page(1);
                      unitsTagsController.getUnitTagList();
                    },
                  ).paddingSymmetric(horizontal: 16).visible(!unitsTagsController.isLoading.value),
                );
              },
            ),
            const LoaderWidget().visible(unitsTagsController.isLoading.value),
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
            heightRatio: 0.45,
            title: locale.value.filterBy,
            hideSearchBar: true,
            hintText: locale.value.searchForStatus,
            controller: TextEditingController(),
            hasError: false,
            isLoading: unitsTagsController.isLoading,
            isEmpty: unitsTagsController.allUnitTagFilterStatus.isEmpty,
            noDataTitle: locale.value.statusListIsEmpty,
            noDataSubTitle: locale.value.thereAreNoStatus,
            listWidget: filterListWid(context),
          ),
        ),
      );
    });
  }

  //region Delete the Brand
  Future<void> handleDeleteClick(List<UnitTagData> data, int index, BuildContext context, {bool isFromTag = false}) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYouWantToDeleteThisUnit,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        unitsTagsController.isLoading(true);

        UnitTagsAPI.removeUnitTag(id: data[index].id, isFromTags: isFromTag).then((value) {
          data.removeAt(index);
          toast(value.message.trim());
          unitsTagsController.page(1);
          unitsTagsController.getUnitTagList();
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() => unitsTagsController.isLoading(false));
      },
    );
  }

  //endregion
  Widget filterListWid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedWrap(
          runSpacing: 8,
          spacing: 8,
          itemCount: unitsTagsController.allUnitTagFilterStatus.length,
          listAnimationType: ListAnimationType.FadeIn,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  unitsTagsController.selectedFilterStatus(unitsTagsController.allUnitTagFilterStatus[index]);
                },
                child: Container(
                  width: Get.width / 2.7,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: boxDecorationDefault(
                    color: unitsTagsController.selectedFilterStatus.contains(unitsTagsController.allUnitTagFilterStatus[index])
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
                      ).visible(unitsTagsController.selectedFilterStatus.contains(unitsTagsController.allUnitTagFilterStatus[index])),
                      4.width.visible(unitsTagsController.selectedFilterStatus.contains(unitsTagsController.allUnitTagFilterStatus[index])),
                      Text(
                        getServiceFilterEmployee(status: unitsTagsController.allUnitTagFilterStatus[index]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: secondaryTextStyle(
                          color: unitsTagsController.selectedFilterStatus.contains(unitsTagsController.allUnitTagFilterStatus[index])
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
                unitsTagsController.page(1);
                unitsTagsController.getUnitTagList();
              },
            ).expand(),
          ],
        ),
      ],
    ).expand();
  }
}
