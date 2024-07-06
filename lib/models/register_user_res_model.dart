  import '../screens/auth/model/login_response.dart';

class RegUserResp {
  bool status;
  UserData userData;
  String message;

  RegUserResp({
    this.status = false,
    required this.userData,
    this.message = "",
  });

  factory RegUserResp.fromJson(Map<String, dynamic> json) {
    return RegUserResp(
      status: json['status'] is bool ? json['status'] : false,
      userData: json['data'] is Map ? UserData.fromJson(json['data']) : UserData(),
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': userData.toJson(),
      'message': message,
    };
  }
}
