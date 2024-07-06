import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/network/network_utils.dart';
import 'package:porosenocheck_employee/utils/api_end_points.dart';
import 'package:porosenocheck_employee/utils/constants.dart';

import '../../../../models/base_response_model.dart';
import '../../../../models/review_data.dart';
import '../../../../utils/app_common.dart';
import '../../../booking_module/model/review_res_model.dart';
import '../model/order_detail_model.dart';
import '../model/order_list_model.dart';
import '../model/order_status_model.dart';

class OrderAPIs {
  static Future<OrderStatusModel> getOrderFilterStatus() async {
    return OrderStatusModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getOrderStatusList, method: HttpMethodType.GET)));
  }

  static Future<OrderDetailModel> getOrderDetail({required int orderId, required int orderItemId, String noteId = ""}) async {
    String notificationId = noteId.isNotEmpty ? '&notification_id=$noteId' : '';
    return OrderDetailModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getOrderDetails}?order_id=$orderId&order_item_id=$orderItemId$notificationId', method: HttpMethodType.GET)));
  }

  static Future<List<OrderListData>> getOrderList({
    required String filterByStatus,
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<OrderListData> orders,
    Function(bool)? lastPageCallBack,
  }) async {
    String statusFilter = filterByStatus.isNotEmpty ? '&delivery_status=$filterByStatus' : '';
    final orderRes = OrderListModel.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getOrderList}?page=$page&per_page=$perPage$statusFilter", method: HttpMethodType.GET)));
    if (page == 1) orders.clear();
    orders.addAll(orderRes.data.validate());

    lastPageCallBack?.call(orderRes.data.validate().length != perPage);

    return orders;
  }

  static Future<BaseResponseModel> updateDeliveryStatus({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.updateDeliveryStatus, request: request, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> updatePaymentStatus({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.updatePaymentStatus, request: request, method: HttpMethodType.POST)));
  }

  static Future<List<ReviewData>> getOrderReviews({
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<ReviewData> reviews,
    Function(bool)? lastPageCallBack,
  }) async {
    if (isLoggedIn.value) {
      String employeeId = '&employee_id=${loginUserData.value.id}';
      final reviewRes = ReviewRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getRating}?per_page=$perPage&page=$page$employeeId", method: HttpMethodType.GET)));
      if (page == 1) reviews.clear();
      reviews.addAll(reviewRes.reviewData);
      lastPageCallBack?.call(reviewRes.reviewData.length != perPage);
      return reviews;
    } else {
      return [];
    }
  }
}
