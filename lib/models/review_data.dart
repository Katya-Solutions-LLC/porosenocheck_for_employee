class ReviewData {
  int id;
  int employeeId;
  int userId;
  String reviewMsg;
  num rating;
  String username;
  String profileImage;
  List<Gallery> gallery;
  String createdAt;

  ReviewData({
    this.id = -1,
    this.employeeId = -1,
    this.userId = -1,
    this.reviewMsg = "",
    this.rating = 0,
    this.username = "",
    this.profileImage = "",
    this.gallery = const <Gallery>[],
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
      profileImage: json['profile_image'] is String ? json['profile_image'] : "",
      gallery: json['gallery'] is List ? List<Gallery>.from(json['gallery'].map((x) => Gallery.fromJson(x))) : [],
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
      'profile_image': profileImage,
      'gallery': gallery.map((e) => e.toJson()).toList(),
    };
  }
}

class Gallery {
  int id;
  int reviewId;
  int status;
  String fullUrl;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Gallery({
    this.id = -1,
    this.reviewId = -1,
    this.status = -1,
    this.fullUrl = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory Gallery.fromJson(Map<String, dynamic> json) {
    return Gallery(
      id: json['id'] is int ? json['id'] : -1,
      reviewId: json['review_id'] is int ? json['review_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      fullUrl: json['full_url'] is String ? json['full_url'] : "",
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'review_id': reviewId,
      'status': status,
      'full_url': fullUrl,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
