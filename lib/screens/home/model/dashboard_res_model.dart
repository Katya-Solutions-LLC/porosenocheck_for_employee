import '../../../models/review_data.dart';
import '../../booking_module/model/bookings_model.dart';
import '../../pet_store/model/pet_store_dashboard_model.dart';

class DashboardRes {
  bool status;
  DashboardData data;
  String message;

  DashboardRes({
    this.status = false,
    required this.data,
    this.message = "",
  });

  factory DashboardRes.fromJson(Map<String, dynamic> json) {
    return DashboardRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map ? DashboardData.fromJson(json['data']) : DashboardData(petstoreDetail: PetStoreDetail()),
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class DashboardData {
  num totalBooking;
  num employeeEarning;

  num totalRevenue;
  num pendingServicePayout;
  List<BookingDataModel> upcommingBooking;
  List<BookingDataModel> bookingRequest;
  List<ReviewData> review;
  PetStoreDetail petstoreDetail;
  num notificationCount;

  DashboardData({
    this.totalBooking = 0,
    this.employeeEarning = 0,
    this.totalRevenue = 0,
    this.pendingServicePayout = 0,
    this.upcommingBooking = const <BookingDataModel>[],
    this.bookingRequest = const <BookingDataModel>[],
    this.review = const <ReviewData>[],
    required this.petstoreDetail,
    this.notificationCount = 0,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      totalBooking: json['total_booking'] is num ? json['total_booking'] : 0.0,
      totalRevenue: json['total_revenue'] is num ? json['total_revenue'] : 0.0,
      employeeEarning: json['employee_earning'] is num ? json['employee_earning'] : 0.0,
      pendingServicePayout: json['pending_service_payout'] is num ? json['pending_service_payout'] : 0.0,
      upcommingBooking: json['upcomming_booking'] is List ? List<BookingDataModel>.from(json['upcomming_booking'].map((x) => BookingDataModel.fromJson(x))) : [],
      bookingRequest: json['booking_request'] is List ? List<BookingDataModel>.from(json['booking_request'].map((x) => BookingDataModel.fromJson(x))) : [],
      review: json['review'] is List ? List<ReviewData>.from(json['review'].map((x) => ReviewData.fromJson(x))) : [],
      petstoreDetail: json['petstore_detail'] is Map ? PetStoreDetail.fromJson(json['petstore_detail']) : PetStoreDetail(),
      notificationCount: json['notification_count'] is num ? json['notification_count'] : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_booking': totalBooking,
      'total_revenue': totalRevenue,
      'employee_earning': employeeEarning,
      'pending_service_payout': pendingServicePayout,
      'upcomming_booking': upcommingBooking.map((e) => e.toJson()).toList(),
      'booking_request': bookingRequest.map((e) => e.toJson()).toList(),
      'review': review.map((e) => e.toJson()).toList(),
      'petstore_detail': petstoreDetail.toJson(),
      'notification_count': notificationCount,
    };
  }
}
