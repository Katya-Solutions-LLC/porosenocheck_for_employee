import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/shop/brand/model/brand_list_response.dart';

import '../../../../utils/app_common.dart';
import '../services/brand_api.dart';

class BrandListController extends RxController {
  Rx<Future<RxList<BrandData>>> getBrands = Future(() => RxList<BrandData>()).obs;
  List<BrandData> brandList = [];
  RxInt selectedFilter = 0.obs;
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;

  @override
  void onReady() {
    getBrandList();
    super.onReady();
  }

  getBrandList({bool showLoader = true}) {
    if (showLoader) {
      isLoading(true);
    }

    getBrands(BrandAPI.getBrand(
      employeeId: loginUserData.value.id,
      page: page.value,
      brand: brandList,
      isAddedByAdmin: selectedFilter.value,
      lastPageCallBack: (p) {
        isLastPage(p);
      },
    )).then((value) {}).catchError((e) {
      log('getBrandList Error: $e');
    }).whenComplete(() => isLoading(false));
  }
}
