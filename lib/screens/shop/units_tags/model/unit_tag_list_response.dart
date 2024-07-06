class UnitTagListResponse {
  bool status;
  List<UnitTagData> data;
  String message;

  UnitTagListResponse({
    this.status = false,
    this.data = const <UnitTagData>[],
    this.message = "",
  });

  factory UnitTagListResponse.fromJson(Map<String, dynamic> json) {
    return UnitTagListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<UnitTagData>.from(json['data'].map((x) => UnitTagData.fromJson(x))) : [],
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

class UnitTagData {
  int id;
  String slug;
  String name;
  int status;
  int createdBy;
  int updatedBy;
  int deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;
  bool isSelected;

  UnitTagData({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.status = -1,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    this.isSelected = false,
  });

  factory UnitTagData.fromJson(Map<String, dynamic> json) {
    return UnitTagData(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      status: json['status'] is int ? json['status'] : -1,
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
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
