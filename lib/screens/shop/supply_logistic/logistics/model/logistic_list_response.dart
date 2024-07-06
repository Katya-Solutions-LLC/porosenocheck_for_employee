class LogisticListResponse {
  bool status;
  List<LogisticData> logisticData;
  String message;

  LogisticListResponse({this.status = false, this.logisticData = const <LogisticData>[], this.message = ""});

  factory LogisticListResponse.fromJson(Map<String, dynamic> json) {
    return LogisticListResponse(
      status: json['status'] is bool ? json['status'] : false,
      logisticData: json['data'] is List ? List<LogisticData>.from(json['data'].map((x) => LogisticData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': logisticData.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class LogisticData {
  int id;
  String name;
  int status;
  String logisticImage;
  int createdBy;
  int updatedBy;
  int deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  LogisticData({
    this.id = -1,
    this.name = "",
    this.status = -1,
    this.logisticImage = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory LogisticData.fromJson(Map<String, dynamic> json) {
    return LogisticData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      status: json['status'] is int ? json['status'] : -1,
      logisticImage: json['logistic_image'] is String ? json['logistic_image'] : "",
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
      'name': name,
      'status': status,
      'logistic_image': logisticImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
