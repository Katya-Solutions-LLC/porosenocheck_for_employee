import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'model/variation_list_response.dart';

class AddVariationController extends RxController {
  RxBool isLoading = false.obs;
  RxBool isStatus = true.obs;
  RxBool hasError = false.obs;

  RxString errorMessage = "".obs;

  List<String> variationTypeList= ["Text","Color"];
  RxList<VariationData> addVariationsTypeList = RxList();

  // Rx<VariationData> selectedVariationType = VariationData().obs;
  Rx<String> selectedVariationType = ''.obs;

  TextEditingController variationNameCont = TextEditingController();
  TextEditingController variationTypeCont = TextEditingController();

  @override
  void onInit() {
    variationNameCont.text = '';
    variationTypeCont.text = '';
    selectedVariationType('');
    super.onInit();
  }
}