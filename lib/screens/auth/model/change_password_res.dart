class ChangePassRes {
  bool status;
  Data data;
  String message;

  ChangePassRes({
    this.status = false,
    required this.data,
    this.message = "",
  });

  factory ChangePassRes.fromJson(Map<String, dynamic> json) {
    return ChangePassRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map ? Data.fromJson(json['data']) : Data(),
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

class Data {
  String apiToken;
  dynamic name;

  Data({
    this.apiToken = "",
    this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      apiToken: json['api_token'] is String ? json['api_token'] : "",
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'api_token': apiToken,
      'name': name,
    };
  }
}
