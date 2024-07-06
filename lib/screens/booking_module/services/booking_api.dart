import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/models/review_data.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';
import '../../../models/base_response_model.dart';
import '../model/booking_model.dart';
import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/constants.dart';
import '../model/bookings_model.dart';
import '../model/review_res_model.dart';

class BookingApi {
  static Future<List<BookingDataModel>> getBookingList({
    required String bookingType,
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<BookingDataModel> bookings,
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    final bookingRes = BookingRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBooking}?status=$bookingType$perPageQuery$pageQuery", method: HttpMethodType.GET)));
    if (page == 1) bookings.clear();
    bookings.addAll(bookingRes.data.validate());

    lastPageCallBack?.call(bookingRes.data.validate().length != perPage);

    return bookings;
  }

  static Future<RxList<BookingDataModel>> getBookingFilterList({
    required String filterByStatus,
    required String filterByService,
    bool isNearByBooking = false,
    int page = 1,
    String search = '',
    int perPage = Constants.perPageItem,
    required List<BookingDataModel> bookings,
    Function(bool)? lastPageCallBack,
  }) async {
    String searchBooking = search.isNotEmpty ? '&search=$search' : '';
    String statusFilter = filterByStatus.isNotEmpty ? '&status=$filterByStatus' : '';
    String nearbyBooking = isNearByBooking ? '&nearby_booking=1' : '';
    String serviceFilter = filterByService.isNotEmpty ? '&system_service_name=$filterByService' : '';
    final bookingRes = BookingRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBooking}?page=$page&per_page=$perPage$statusFilter$serviceFilter$searchBooking$nearbyBooking", method: HttpMethodType.GET)));
    if (page == 1) bookings.clear();
    bookings.addAll(bookingRes.data.validate());

    lastPageCallBack?.call(bookingRes.data.validate().length != perPage);

    return bookings.obs;
  }

  static Future<BookingDetailRes> getBookingDetail({required int bookingId, String noteId = ""}) async {
    String notificationId = noteId.isNotEmpty ? '&notification_id=$noteId' : '';
    return BookingDetailRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBookingDetail}?id=$bookingId$notificationId", method: HttpMethodType.GET)));
  }

  static Future<BaseResponseModel> updateBooking({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.bookingUpdate, request: request, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> acceptBookingRequest({required int bookingId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.acceptBooking}/$bookingId", method: HttpMethodType.GET)));
  }

  static Future<BaseResponseModel> updateReview({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.saveRating, request: request, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> deleteReview({required int id}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.deleteRating, request: {"id": id}, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> savePayment({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.savePayment, request: request, method: HttpMethodType.POST)));
  }

  static Future<List<ReviewData>> getEmployeeReviews({
    String filterByStatus = '',
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<ReviewData> reviews,
    Function(bool)? lastPageCallBack,
  }) async {
    if (isLoggedIn.value) {
      String employeeId = '&employee_id=${loginUserData.value.id}';
      String statusFilter = filterByStatus.isNotEmpty ? '&filter=$filterByStatus' : '';
      final reviewRes = ReviewRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getRating}?per_page=$perPage&page=$page$employeeId$statusFilter", method: HttpMethodType.GET)));
      if (page == 1) reviews.clear();
      reviews.addAll(reviewRes.reviewData);
      lastPageCallBack?.call(reviewRes.reviewData.length != perPage);
      return reviews;
    } else {
      return [];
    }
  }

  static Future<List<BookingDataModel>> getHomeBookingList({
    int page = 1,
    int perPage = 1,
    required List<BookingDataModel> bookings,
    Function(bool)? lastPageCallBack,
  }) async {
    final bookingRes = BookingRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBooking}?per_page=$perPage&page=$page", method: HttpMethodType.GET)));
    if (page == 1) bookings.clear();
    bookings.addAll(bookingRes.data);
    lastPageCallBack?.call(bookingRes.data.length != perPage);
    return bookings;
  }

  static Future<List<ReviewData>> getHomeEmployeeReviews({
    int page = 1,
    int perPage = 5,
  }) async {
    String employeeId = '&employee_id=${loginUserData.value.id}';
    final reviewRes = ReviewRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getRating}?per_page=$perPage&page=$page$employeeId", method: HttpMethodType.GET)));
    return reviewRes.reviewData;
  }
}
