class CategoryListResponse {
  bool status;
  List<Category> data;
  String message;

  CategoryListResponse({
    this.status = false,
    this.data = const <Category>[],
    this.message = "",
  });

  factory CategoryListResponse.fromJson(Map<String, dynamic> json) {
    return CategoryListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<Category>.from(json['data'].map((x) => Category.fromJson(x))) : [],
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

class Category {
  int id;
  String slug;
  String name;
  int parentId;
  int status;
  String categoryImage;
  String createdBy;
  String updatedBy;
  String deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Category({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.parentId = -1,
    this.status = -1,
    this.categoryImage = "",
    this.createdBy = "",
    this.updatedBy = "",
    this.deletedBy = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      parentId: json['parent_id'] is int ? json['parent_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      categoryImage: json['category_image'] is String ? json['category_image'] : "",
      createdBy: json['created_by'] is String ? json['created_by'] : "",
      updatedBy: json['updated_by'] is String ? json['updated_by'] : "",
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
