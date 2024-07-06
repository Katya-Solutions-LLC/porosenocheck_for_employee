class StateListResponse {
  bool status;
  List<StateData> data;
  String message;

  StateListResponse({
    this.status = false,
    this.data = const <StateData>[],
    this.message = "",
  });

  factory StateListResponse.fromJson(Map<String, dynamic> json) {
    return StateListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<StateData>.from(json['data'].map((x) => StateData.fromJson(x))) : [],
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

class StateData {
  int id;
  String name;
  int countryId;

  StateData({
    this.id = -1,
    this.name = "",
    this.countryId = -1,
  });

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      countryId: json['country_id'] is int ? json['country_id'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country_id': countryId,
    };
  }
}
