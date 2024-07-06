class PetCenterRes {
  bool status;
  PetCenterDetail data;
  String message;

  PetCenterRes({
    this.status = false,
    required this.data,
    this.message = "",
  });

  factory PetCenterRes.fromJson(Map<String, dynamic> json) {
    return PetCenterRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map ? PetCenterDetail.fromJson(json['data']) : PetCenterDetail(),
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

class PetCenterDetail {
  int id;
  String slug;
  String name;
  String addressLine1;
  int latitude;
  int longitude;
  String contactEmail;
  String contactNumber;
  dynamic description;
  List<String> paymentMethod;
  dynamic managerId;
  String branchFor;
  String branchImage;
  List<dynamic> gallery;
  double ratingStar;
  int totalReview;
  int status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  List<WorkingDays> workingDays;

  PetCenterDetail({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.addressLine1 = "",
    this.latitude = -1,
    this.longitude = -1,
    this.contactEmail = "",
    this.contactNumber = "",
    this.description,
    this.paymentMethod = const <String>[],
    this.managerId,
    this.branchFor = "",
    this.branchImage = "",
    this.gallery = const [],
    this.ratingStar = 0,
    this.totalReview = -1,
    this.status = -1,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
    this.workingDays = const <WorkingDays>[],
  });

  factory PetCenterDetail.fromJson(Map<String, dynamic> json) {
    return PetCenterDetail(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      addressLine1: json['address_line_1'] is String ? json['address_line_1'] : "",
      latitude: json['latitude'] is int ? json['latitude'] : -1,
      longitude: json['longitude'] is int ? json['longitude'] : -1,
      contactEmail: json['contact_email'] is String ? json['contact_email'] : "",
      contactNumber: json['contact_number'] is String ? json['contact_number'] : "",
      description: json['description'],
      paymentMethod: json['payment_method'] is List ? List<String>.from(json['payment_method'].map((x) => x)) : [],
      managerId: json['manager_id'],
      branchFor: json['branch_for'] is String ? json['branch_for'] : "",
      branchImage: json['branch_image'] is String ? json['branch_image'] : "",
      gallery: json['gallery'] is List ? json['gallery'] : [],
      ratingStar: json['rating_star'] is double ? json['rating_star'] : 0,
      totalReview: json['total_review'] is int ? json['total_review'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
      workingDays: json['working_days'] is List ? List<WorkingDays>.from(json['working_days'].map((x) => WorkingDays.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'address_line_1': addressLine1,
      'latitude': latitude,
      'longitude': longitude,
      'contact_email': contactEmail,
      'contact_number': contactNumber,
      'description': description,
      'payment_method': paymentMethod.map((e) => e).toList(),
      'manager_id': managerId,
      'branch_for': branchFor,
      'branch_image': branchImage,
      'gallery': [],
      'rating_star': ratingStar,
      'total_review': totalReview,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'working_days': workingDays.map((e) => e.toJson()).toList(),
    };
  }
}

class WorkingDays {
  String day;
  String startTime;
  String endTime;
  int isHoliday;
  List<dynamic> breaks;

  WorkingDays({
    this.day = "",
    this.startTime = "",
    this.endTime = "",
    this.isHoliday = -1,
    this.breaks = const [],
  });

  factory WorkingDays.fromJson(Map<String, dynamic> json) {
    return WorkingDays(
      day: json['day'] is String ? json['day'] : "",
      startTime: json['start_time'] is String ? json['start_time'] : "",
      endTime: json['end_time'] is String ? json['end_time'] : "",
      isHoliday: json['is_holiday'] is int ? json['is_holiday'] : -1,
      breaks: json['breaks'] is List ? json['breaks'] : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'is_holiday': isHoliday,
      'breaks': [],
    };
  }
}
