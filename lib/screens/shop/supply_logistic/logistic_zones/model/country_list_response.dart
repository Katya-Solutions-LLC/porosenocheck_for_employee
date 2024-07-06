class CountryListResponse {
  bool status;
  List<CountryData> data;
  String message;

  CountryListResponse({
    this.status = false,
    this.data = const <CountryData>[],
    this.message = "",
  });

  factory CountryListResponse.fromJson(Map<String, dynamic> json) {
    return CountryListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<CountryData>.from(json['data'].map((x) => CountryData.fromJson(x))) : [],
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

class CountryData {
  int id;
  String name;

  CountryData({
    this.id = -1,
    this.name = "",
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
