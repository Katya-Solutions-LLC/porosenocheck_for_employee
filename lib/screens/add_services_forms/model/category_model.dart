class CategoryRes {
  bool status;
  List<ShopCategoryModel> data;
  String message;

  CategoryRes({
    this.status = false,
    this.data = const <ShopCategoryModel>[],
    this.message = "",
  });

  factory CategoryRes.fromJson(Map<String, dynamic> json) {
    return CategoryRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<ShopCategoryModel>.from(json['data'].map((x) => ShopCategoryModel.fromJson(x))) : [],
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

class ShopCategoryModel {
  int id;
  String slug;
  String name;
  dynamic parentId;
  int status;
  String categoryImage;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  ShopCategoryModel({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.parentId,
    this.status = -1,
    this.categoryImage = "",
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) {
    return ShopCategoryModel(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      parentId: json['parent_id'],
      status: json['status'] is int ? json['status'] : -1,
      categoryImage: json['category_image'] is String ? json['category_image'] : "",
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'parent_id': parentId,
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
