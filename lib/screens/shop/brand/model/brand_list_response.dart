class BrandListResponse {
  bool status;
  List<BrandData> data;
  String message;

  BrandListResponse({
    this.status = false,
    this.data = const <BrandData>[],
    this.message = "",
  });

  factory BrandListResponse.fromJson(Map<String, dynamic> json) {
    return BrandListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<BrandData>.from(json['data'].map((x) => BrandData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class BrandData {
  int id;
  String slug;
  String name;
  int parentId;
  int status;
  String brandImage;
  int createdBy;
  int updatedBy;
  String deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  BrandData({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.parentId = -1,
    this.status = -1,
    this.brandImage = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory BrandData.fromJson(Map<String, dynamic> json) {
    return BrandData(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      parentId: json['parent_id'] is int ? json['parent_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      brandImage: json['brand_image'] is String ? json['brand_image'] : "",
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'] is String ? json['deleted_by'] : "",
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
      'parent_id': parentId,
      'status': status,
      'brand_image': brandImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
