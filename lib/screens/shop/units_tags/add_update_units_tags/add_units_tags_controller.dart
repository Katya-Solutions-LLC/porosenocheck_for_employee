import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';

import '../model/unit_tag_list_response.dart';
import '../services/unit_tag_api.dart';

class AddUnitTagController extends RxController {
  TextEditingController nameCont = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isStatus = true.obs;
  RxBool isEdit = false.obs;
  Rx<UnitTagData> brandData = UnitTagData(id: -1).obs;

  @override
  void onInit() {
    if (Get.arguments is Map) {
      if (Get.arguments['data'] != null) {
        brandData(Get.arguments['data'] as UnitTagData);
        isEdit(true);
        nameCont.text = brandData.value.name;
        isStatus = brandData.value.status == 1 ? true.obs : false.obs;
      }
    }

    super.onInit();
  }

  Future<void> addUpdateUnitTags({bool isFromTag = false}) async {
    isLoading(true);

    hideKeyBoardWithoutContext();

    Map request = {
      "name": nameCont.text.trim().validate(),
      "status": isStatus.value ? "1" : "0",
    };

    if (!isFromTag) {
      UnitTagsAPI.addUpdateUnit(
        unitId: brandData.value.id != -1 ? brandData.value.id.toString() : '',
        request: request,
        isUpdate: brandData.value.id != -1,
      ).then((value) {
        toast(value.message.toString(), print: true);
        Get.back(result: true);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => isLoading(false));
    } else {
      UnitTagsAPI.addUpdateTag(
        tagId: brandData.value.id != -1 ? brandData.value.id.toString() : '',
        request: request,
        isUpdate: brandData.value.id != -1,
      ).then((value) {
        toast(value.message.toString(), print: true);
        Get.back(result: true);
      }).catchError((e) {
        toast(e.toString());
      }).whenComplete(() => isLoading(false));
    }
  }
}
