import '../../../models/review_data.dart';
import 'bookings_model.dart';

class BookingDetailRes {
  bool status;
  BookingDataModel data;
  ReviewData? customerReview;
  String message;

  BookingDetailRes({
    this.status = false,
    required this.data,
    this.customerReview,
    this.message = "",
  });

  factory BookingDetailRes.fromJson(Map<String, dynamic> json) {
    return BookingDetailRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map ? BookingDataModel.fromJson(json['data']) : BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training()),
      customerReview: json['customer_review'] is Map ? ReviewData.fromJson(json['customer_review']) : null,
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
      if (customerReview != null) 'customer_review': customerReview!.toJson(),
    };
  }
}
