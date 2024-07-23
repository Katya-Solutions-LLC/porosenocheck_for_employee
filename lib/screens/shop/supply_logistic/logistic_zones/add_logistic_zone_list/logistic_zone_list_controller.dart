import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';
import 'package:porosenocheckemployee/utils/constants.dart';

import '../model/logistic_zone_list_response.dart';
import '../services/logistics_zone_api.dart';

class LogisticZoneController extends RxController {
  Rx<Future<RxList<LogisticZoneData>>> getLogisticZoneList = Future(() => RxList<LogisticZoneData>()).obs;
  List<LogisticZoneData> logisticZoneList = [];

  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;

  RxString selectedFilterStatus = ServiceFilterStatusConst.createdByAdmin.obs;

  RxList<String> allFilterStatus = RxList([
    ServiceFilterStatusConst.all,
    ServiceFilterStatusConst.addedByMe,
    ServiceFilterStatusConst.createdByAdmin,
  ]);

  @override
  void onReady() {
    getLogisticsZone();
    super.onReady();
  }

  getLogisticsZone({bool showLoader = true}) {
    if (showLoader) {
      isLoading(true);
    }

    getLogisticZoneList(
      LogisticZoneAPI.getLogisticsZones(
        filterByServiceStatus: selectedFilterStatus.value,
        employeeId: loginUserData.value.id,
        page: page.value,
        logisticZoneList: logisticZoneList,
        lastPageCallBack: (p) {
          isLastPage(p);
        },
      ),
    ).then((value) {}).catchError((e) {
      toast(e.toString(), print: true);
      log('Error: $e');
    }).whenComplete(() => isLoading(false));
  }

  String getCitiesName(List<Cities> city) {
    List<String> cities = [];

    for (var element in city) {
      cities.add(element.name);
    }

    return cities.join(', ');
  }

  //region Delete the Brand
  Future<void> handleDeleteLogisticZoneClick(List<LogisticZoneData> logisticZone, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYouWantToDeleteThisLogisticzone,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        isLoading(true);
        LogisticZoneAPI.deleteLogisticZone(logisticZoneId: logisticZone[index].id).then((value) {
          logisticZone.removeAt(index);
          toast(value.message.trim());

          page(1);
          getLogisticsZone();
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() => isLoading(false));
      },
    );
  }

//endregion
}
