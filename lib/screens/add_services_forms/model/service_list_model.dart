import 'package:get/get.dart';

class ServiceListResponse {
  bool status;
  List<ServiceData> serviceData;
  String message;

  ServiceListResponse({
    this.status = false,
    this.serviceData = const <ServiceData>[],
    this.message = "",
  });

  factory ServiceListResponse.fromJson(Map<String, dynamic> json) {
    return ServiceListResponse(
      status: json['status'] is bool ? json['status'] : false,
      serviceData: json['data'] is List ? List<ServiceData>.from(json['data'].map((x) => ServiceData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': serviceData.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class ServiceData {
  RxInt id;
  String slug;
  String name;
  String description;
  int durationMin;
  int defaultPrice;
  int status;
  int categoryId;
  String categoryName;
  String categoryImage;
  int subCategoryId;
  String serviceImage;
  int createdBy;
  int updatedBy;
  int deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  ServiceData({
    required this.id,
    this.slug = "",
    this.name = "",
    this.description = "",
    this.durationMin = -1,
    this.defaultPrice = -1,
    this.status = -1,
    this.categoryId = -1,
    this.categoryName = "",
    this.categoryImage = "",
    this.subCategoryId = -1,
    this.serviceImage = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['id'] is int ? (json['id'] as int).obs : (-1).obs,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      description: json['description'] is String ? json['description'] : "",
      durationMin: json['duration_min'] is int ? json['duration_min'] : -1,
      defaultPrice: json['default_price'] is int ? json['default_price'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      categoryId: json['category_id'] is int ? json['category_id'] : -1,
      categoryName: json['category_name'] is String ? json['category_name'] : "",
      categoryImage: json['category_image'] is String ? json['category_image'] : "",
      subCategoryId: json['sub_category_id'] is int ? json['sub_category_id'] : -1,
      serviceImage: json['service_image'] is String ? json['service_image'] : "",
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'] is int ? json['deleted_by'] : -1,
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'duration_min': durationMin,
      'default_price': defaultPrice,
      'status': status,
      'category_id': categoryId,
      'category_name': categoryName,
      'category_image': categoryImage,
      'sub_category_id': subCategoryId,
      'service_image': serviceImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
