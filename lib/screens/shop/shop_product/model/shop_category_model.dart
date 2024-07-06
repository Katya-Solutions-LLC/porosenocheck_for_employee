class CategoryListResponse {
  bool status;
  List<ShopCategory> data;
  String message;

  CategoryListResponse({
    this.status = false,
    this.data = const <ShopCategory>[],
    this.message = "",
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) {
    return CategoryListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<ShopCategory>.from(json['data'].map((x) => ShopCategory.fromJson(x))) : [],
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

class ShopCategory {
  int id;
  String slug;
  String name;
  int parentId;
  int brandId;
  int status;
  String categoryImage;
  int createdBy;
  int updatedBy;
  int deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;
  bool? isSelected;

  ShopCategory({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.parentId = -1,
    this.brandId = -1,
    this.status = -1,
    this.categoryImage = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    this.isSelected = false,
  });

  factory ShopCategory.fromJson(Map<String, dynamic> json) {
    return ShopCategory(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      parentId: json['parent_id'] is int ? json['parent_id'] : -1,
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      categoryImage: json['category_image'] is String ? json['category_image'] : "",
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
      'parent_id': parentId,
      'brand_id': brandId,
      'status': status,
      'category_image': categoryImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
