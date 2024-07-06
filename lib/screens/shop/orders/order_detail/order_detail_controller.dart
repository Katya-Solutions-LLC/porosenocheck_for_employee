import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../../pet_store/model/pet_store_dashboard_model.dart';
import '../../variation/model/variation_list_response.dart';
import '../model/order_detail_model.dart';
import '../order_list/orders_controller.dart';
import '../services/order_service_api.dart';

class OrderDetailController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Future<OrderDetailModel>> getOrderDetailFuture = Future(() => OrderDetailModel(data: OrderListData(orderDetails: OrderDetails(productDetails: ProductDetails(qty: 0.obs, productVariation: VariationData()))))).obs;
  RxString orderCode = "".obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    try {
      if (Get.arguments is OrderListData) {
        getOrderDetailFuture(
          OrderAPIs.getOrderDetail(
            orderId: (Get.arguments as OrderListData).orderId,
            orderItemId: (Get.arguments as OrderListData).id,
            noteId: (Get.arguments as OrderListData).notificationId,
          ),
        ).then((value) {
          isLoading(false);
          orderCode(value.data.orderCode);
        });
      }
    } catch (e) {
      toast(e.toString());
    }
  }

  updatePaymentStatus({required int orderId, required int orderItemId}) {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      "order_id": orderId,
      "order_item_id": orderItemId,
      "status": PaymentStatus.PAID,
    };

    OrderAPIs.updatePaymentStatus(
      request: req,
    ).then((value) async {
      init();
      try {
        Get.find<OrderController>().getOrderList()();
      } catch (e) {
        log('OrderController Get.find() Err: $e');
      }
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    }); //
  }
}
