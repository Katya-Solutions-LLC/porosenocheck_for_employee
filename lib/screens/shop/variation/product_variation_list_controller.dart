import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/shop/variation/services/variation_api.dart';

import '../../../utils/app_common.dart';
import '../../../utils/constants.dart';
import 'model/variation_list_response.dart';

class ProductVariationListController extends RxController {
  Rx<Future<RxList<VariationData>>> getVariations = Future(() => RxList<VariationData>()).obs;

  List<VariationData> variationList = [];

  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxBool hasError = false.obs;

  RxInt page = 1.obs;

  RxString errorMessage = "".obs;
  RxString selectedFilterStatus = ServiceFilterStatusConst.addedByMe.obs;

  @override
  void onReady() {
    getVariationList();
    super.onReady();
  }

  //region Get Variation Type
  getVariationList({bool showLoader = true}) async {
    if (showLoader) {
      isLoading(true);
    }

    getVariations(VariationAPI.getVariations(
      filterByServiceStatus: selectedFilterStatus.value,
      employeeId: loginUserData.value.id,
      page: page.value,
      list: variationList,
      lastPageCallBack: (p) {
        isLastPage(p);
      },
    )).then((value) {
      //
    }).onError((error, stackTrace) {
      toast(error.toString(), print: true);
      log('Error: $error');
    }).whenComplete(() => isLoading(false));
  }
}
