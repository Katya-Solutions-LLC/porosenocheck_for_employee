// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/common_base.dart';
import '../services/auth_services.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailCont = TextEditingController();

  saveForm() async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      'email': emailCont.text.trim(),
    };

    await AuthServiceApis.forgotPasswordAPI(request: req).then((value) async {
      isLoading(false);
      Get.back();
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }
}
