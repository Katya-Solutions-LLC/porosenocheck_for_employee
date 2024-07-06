import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';
import 'package:porosenocheck_employee/utils/constants.dart';

import '../model/unit_tag_list_response.dart';
import '../services/unit_tag_api.dart';

class UnitsTagsController extends RxController {
  Rx<Future<RxList<UnitTagData>>> getUnitTags = Future(() => RxList<UnitTagData>()).obs;
  List<UnitTagData> list = [];
  RxInt selectedFilter = 0.obs;
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxString selectedFilterStatus = ServiceFilterStatusConst.addedByMe.obs;

  RxList<String> allUnitTagFilterStatus = RxList([
    ServiceFilterStatusConst.all,
    ServiceFilterStatusConst.addedByMe,
    ServiceFilterStatusConst.createdByAdmin,
  ]);

  @override
  void onReady() {
    getUnitTagList(isFromTag: Get.arguments == true ? true : false);
    super.onReady();
  }

  getUnitTagList({bool showLoader = true, String search = "", bool isFromTag = false}) {
    if (showLoader) {
      isLoading(true);
    }

    if (Get.arguments == true) {
      getUnitTags(
        UnitTagsAPI.getTags(
          filterByServiceStatus: selectedFilterStatus.value,
          employeeId: loginUserData.value.id,
          list: list,
          page: page.value,
          isAddedByAdmin: selectedFilter.value,
          lastPageCallBack: (p) {
            isLastPage(p);
          },
        ),
      ).then((value) {}).catchError((e) {
        log('getTags Error: $e');
      }).whenComplete(() => isLoading(false));
    } else {
      getUnitTags(
        UnitTagsAPI.getUnits(
          filterByServiceStatus: selectedFilterStatus.value,
          employeeId: loginUserData.value.id,
          list: list,
          isAddedByAdmin: selectedFilter.value,
          page: page.value,
          lastPageCallBack: (p) {
            isLastPage(p);
          },
        ),
      ).then((value) {}).catchError((e) {
        log('getUnits Error: $e');
      }).whenComplete(() => isLoading(false));
    }
  }
}
