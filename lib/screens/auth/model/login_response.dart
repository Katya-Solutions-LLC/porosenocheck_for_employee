class LoginResponse {
  bool status;
  UserData userData;
  String message;

  LoginResponse({
    this.status = false,
    required this.userData,
    this.message = "",
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
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

class UserData {
  int id;
  String firstName;
  String lastName;
  String userName;
  String address;
  String latitude;
  String longitude;
  String mobile;
  String email;
  String gender;
  String aboutSelf;
  String expert;
  String facebookLink;
  String instagramLink;
  String twitterLink;
  String dribbbleLink;
  List<String> userRole;
  String apiToken;
  String profileImage;
  String loginType;
  bool isSocialLogin;
  int isEnableStore;
  String userType;

  UserData({
    this.id = -1,
    this.firstName = "",
    this.lastName = "",
    this.userName = "",
    this.address = "",
    this.latitude = "",
    this.longitude = "",
    this.mobile = "",
    this.email = "",
    this.gender = "",
    this.aboutSelf = "",
    this.expert = "",
    this.facebookLink = "",
    this.instagramLink = "",
    this.dribbbleLink = "",
    this.twitterLink = "",
    this.userRole = const <String>[],
    this.apiToken = "",
    this.profileImage = "",
    this.loginType = "",
    this.isSocialLogin = false,
    this.isEnableStore = 0,
    this.userType = "",
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] is int ? json['id'] : -1,
      firstName: json['first_name'] is String ? json['first_name'] : "",
      lastName: json['last_name'] is String ? json['last_name'] : "",
      userName: json['user_name'] is String ? json['user_name'] : "${json['first_name']} ${json['last_name']}",
      mobile: json['mobile'] is String ? json['mobile'] : "",
      address: json['address'] is String ? json['address'] : "",
      latitude: json['latitude'] is String ? json['latitude'] : "",
      longitude: json['longitude'] is String ? json['longitude'] : "",
      email: json['email'] is String ? json['email'] : "",
      gender: json['gender'] is String ? json['gender'] : "",
      aboutSelf: json['about_self'] is String ? json['about_self'] : "",
      expert: json['expert'] is String ? json['expert'] : "",
      facebookLink: json['facebook_Link'] is String ? json['facebook_Link'] : "",
      instagramLink: json['instagram_Link'] is String ? json['instagram_Link'] : "",
      twitterLink: json['twitter_Link'] is String ? json['twitter_Link'] : "",
      dribbbleLink: json['dribbble_Link'] is String ? json['dribbble_Link'] : "",
      userRole: json['user_role'] is List ? List<String>.from(json['user_role'].map((x) => x)) : [],
      apiToken: json['api_token'] is String ? json['api_token'] : "",
      profileImage: json['profile_image'] is String ? json['profile_image'] : "",
      loginType: json['login_type'] is String ? json['login_type'] : "",
      isSocialLogin: json['is_social_login'] is bool ? json['is_social_login'] : false,
      isEnableStore: json['enable_store'] is int ? json['enable_store'] : 0,
      userType: json['user_type'] is String ? json['user_type'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'user_name': userName,
      'mobile': mobile,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'email': email,
      'gender': gender,
      'about_self': aboutSelf,
      'expert': expert,
      'facebook_Link': facebookLink,
      'instagram_Link': instagramLink,
      'twitter_Link': twitterLink,
      'dribbble_Link': dribbbleLink,
      'user_role': userRole.map((e) => e).toList(),
      'api_token': apiToken,
      'profile_image': profileImage,
      'login_type': loginType,
      'is_social_login': isSocialLogin,
      "enable_store": isEnableStore,
      'user_type': userType,
    };
  }
}
