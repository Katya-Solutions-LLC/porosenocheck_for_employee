import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';

import '../shop/orders/services/order_service_api.dart';

class StoreHomeController extends GetxController with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await getAllStatusUsedForOrder();
  }

  getAllStatusUsedForOrder() {
    isLoading(true);
    OrderAPIs.getOrderFilterStatus().then((value) {
      isLoading(false);
      allOrderStatus(value.data);
    }).onError((error, stackTrace) {
      isLoading(false);
      toast(error.toString());
    });
  }
}
