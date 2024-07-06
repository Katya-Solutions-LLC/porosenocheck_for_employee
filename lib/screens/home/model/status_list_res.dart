class StatusListRes {
  bool status;
  List<StatusModel> data;
  String message;

  StatusListRes({
    this.status = false,
    this.data = const <StatusModel>[],
    this.message = "",
  });

  factory StatusListRes.fromJson(Map<String, dynamic> json) {
    return StatusListRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List
          ? List<StatusModel>.from(json['data'].map((x) => StatusModel.fromJson(x)))
          : [],
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

class StatusModel {
  String status;
  String title;
  bool isDisabled;

  StatusModel({
    this.status = "",
    this.title = "",
    this.isDisabled = false,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      status: json['status'] is String ? json['status'] : "",
      title: json['title'] is String ? json['title'] : "",
      isDisabled: json['is_disabled'] is bool ? json['is_disabled'] : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'title': title,
      'is_disabled': isDisabled,
    };
  }
}
