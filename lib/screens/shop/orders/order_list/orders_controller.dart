import 'dart:ui';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/app_common.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../../home/home_controller.dart';
import '../model/order_detail_model.dart';
import '../services/order_service_api.dart';

class OrderController extends RxController {
  Rx<Future<List<OrderListData>>> orderListFuture = Future(() => <OrderListData>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;
  List<OrderListData> orders = [];
  RxSet<String> selectedIndex = RxSet();

  @override
  void onInit() {
    getAllStatusUsedForOrder();
    getOrderList();
    super.onInit();
  }

  getOrderList({bool showLoader = true}) {
    if (showLoader) {
      isLoading(true);
    }
    orderListFuture(
      OrderAPIs.getOrderList(
        filterByStatus: selectedIndex.join(","),
        page: page.value,
        orders: orders,
        lastPageCallBack: (p0) {
          isLastPage(p0);
        },
      ),
    ).then((value) {}).catchError((e) {
      log('getOrderList Error: $e');
    }).whenComplete(() => isLoading(false));
  }

  ///Get Order Status List
  getAllStatusUsedForOrder() {
    isLoading(true);
    OrderAPIs.getOrderFilterStatus().then((value) {
      isLoading(false);
      allOrderStatus(value.data);
    }).onError((error, stackTrace) {
      isLoading(false);
      log('getAllStatusUsedForOrder Error: $error');
    });
  }

  updateDeliveryStatus({required int orderId, required int orderItemId, required String status, VoidCallback? onUpdateDeliveryStatus}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    try {
      Get.find<HomeController>().isLoading(true);
    } catch (e) {
      log('HomeController Get.find() Err: $e');
    }
    Map<String, dynamic> req = {
      "order_id": orderId,
      "order_item_id": orderItemId,
      "status": status,
    };
    await OrderAPIs.updateDeliveryStatus(request: req).then((value) async {
      if (status == OrderStatus.Delivered) {
        toast(value.message);
      }
      if (onUpdateDeliveryStatus != null) {
        onUpdateDeliveryStatus.call();
      }
      try {
        Get.find<HomeController>().getDashboardDetail();
      } catch (e) {
        log('HomeController Get.find() Err: $e');
      }
    }).catchError(
      (e) {
        isLoading(false);
        log('updateDeliveryStatus Err: $e');
      },
    ).whenComplete(() {
      try {
        Get.find<HomeController>().isLoading(true);
      } catch (e) {
        log('HomeController Get.find() Err: $e');
      }
      isLoading(false);
    });
  }
}
