import '../../../models/review_data.dart';

class ReviewRes {
  bool status;
  List<ReviewData> reviewData;
  String message;

  ReviewRes({
    this.status = false,
    this.reviewData = const <ReviewData>[],
    this.message = "",
  });

  factory ReviewRes.fromJson(Map<String, dynamic> json) {
    return ReviewRes(
      status: json['status'] is bool ? json['status'] : false,
      reviewData: json['data'] is List
          ? List<ReviewData>.from(
              json['data'].map((x) => ReviewData.fromJson(x)))
          : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': reviewData.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}
