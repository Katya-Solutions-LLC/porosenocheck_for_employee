import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/main.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';
import 'package:porosenocheck_employee/utils/constants.dart';

import '../model/logistic_list_response.dart';
import '../services/logistic_api.dart';

class LogisticController extends RxController {
  Rx<Future<RxList<LogisticData>>> getLogisticList = Future(() => RxList<LogisticData>()).obs;
  List<LogisticData> logisticList = [];

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
    getLogistics();
    super.onReady();
  }

  getLogistics({bool showLoader = true}) {
    if (showLoader) {
      isLoading(true);
    }

    getLogisticList(
      LogisticAPI.getLogistics(
        filterByServiceStatus: selectedFilterStatus.value,
        employeeId: loginUserData.value.id,
        page: page.value,
        logisticList: logisticList,
        lastPageCallBack: (p) {
          isLastPage(p);
        },
      )
    ).then((value) {}).catchError((e) {
      toast(e.toString(), print: true);
      log('Error: $e');
    }).whenComplete(() => isLoading(false));
  }

  //region Delete the Brand
  Future<void> handleDeleteLogisticClick(List<LogisticData> logistic, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYouWantToDeleteThisBrand,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        isLoading(true);
        LogisticAPI.deleteLogistic(logisticId: logistic[index].id).then((value) {
          logistic.removeAt(index);
          toast(value.message.trim());

          page(1);
          getLogistics();
        }).catchError((e) {
          toast(e.toString());
        }).whenComplete(() => isLoading(false));
      },
    );
  }

//endregion
}
