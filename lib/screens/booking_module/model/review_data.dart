class ReviewData {
  int id;
  int employeeId;
  int userId;
  String reviewMsg;
  num rating;
  String username;
  String createdAt;

  ReviewData({
    this.id = -1,
    this.employeeId = -1,
    this.userId = -1,
    this.reviewMsg = "",
    this.rating = 0,
    this.username = "",
    this.createdAt = "",
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['id'] is int ? json['id'] : -1,
      employeeId: json['staff_id'] is int ? json['staff_id'] : -1,
      userId: json['user_id'] is int ? json['user_id'] : -1,
      reviewMsg: json['review_msg'] is String ? json['review_msg'] : "",
      rating: json['rating'] is num ? json['rating'] : 0,
      username: json['username'] is String ? json['username'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'user_id': userId,
      'review_msg': reviewMsg,
      'rating': rating,
      'username': username,
    };
  }
}
