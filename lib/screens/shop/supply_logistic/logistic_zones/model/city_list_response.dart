class CityListResponse {
  bool status;
  List<CityData> data;
  String message;

  CityListResponse({
    this.status = false,
    this.data = const <CityData>[],
    this.message = "",
  });

  factory CityListResponse.fromJson(Map<String, dynamic> json) {
    return CityListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<CityData>.from(json['data'].map((x) => CityData.fromJson(x))) : [],
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

class CityData {
  int id;
  String name;
  int stateId;
  bool? isSelected;

  CityData({
    this.id = -1,
    this.name = "",
    this.stateId = -1,
    this.isSelected = false,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      stateId: json['state_id'] is int ? json['state_id'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': stateId,
    };
  }
}
