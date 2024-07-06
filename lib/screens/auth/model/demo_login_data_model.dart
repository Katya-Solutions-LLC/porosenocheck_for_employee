import '../../../utils/constants.dart';

class DemoLoginData {
  int id;
  String serviceName;
  String email;
  String password;
  String icon;
  String userType;

  DemoLoginData({
    this.id = -1,
    this.serviceName = "",
    this.email = "",
    this.password = "",
    this.icon = "",
    this.userType = "",
  });

  factory DemoLoginData.fromJson(Map<String, dynamic> json) {
    return DemoLoginData(
      id: json['id'] is int ? json['id'] : -1,
      serviceName: json['serviceName'] is String ? json['serviceName'] : "",
      email: json['serviceName'] is String ? json['email'] : "",
      password: json['password'] is String ? json['password'] : "",
      icon: json['icon'] is String ? json['icon'] : "",
      userType: json[UserKeys.userType] is String ? json[UserKeys.userType] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'email': email,
      'password': password,
      'icon': icon,
      UserKeys.userType: userType,
    };
  }
}
