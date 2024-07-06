class EmployeeResponse {
  bool status;
  EmployeeData data;
  String message;

  EmployeeResponse({
    this.status = false,
    required this.data,
    this.message = "",
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map ? EmployeeData.fromJson(json['data']) : EmployeeData(userSetting: UserSetting(), profile: Profile()),
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

class EmployeeData {
  int id;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String loginType;
  String playerId;
  String webPlayerId;
  String gender;
  String dateOfBirth;
  int isManager;
  int showInCalender;
  String emailVerifiedAt;
  String avatar;
  int isBanned;
  int isSubscribe;
  int status;
  String lastNotificationSeen;
  UserSetting userSetting;
  String address;
  String latitude;
  String longitude;
  String userType;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String aboutSelf;
  String expert;
  String facebookLink;
  String instagramLink;
  String twitterLink;
  String dribbbleLink;
  String fullName;
  String profileImage;
  Profile profile;
  List<Media> media;

  EmployeeData({
    this.id = -1,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.mobile = "",
    this.loginType = "",
    this.playerId = "",
    this.webPlayerId = "",
    this.gender = "",
    this.dateOfBirth = "",
    this.isManager = -1,
    this.showInCalender = -1,
    this.emailVerifiedAt = "",
    this.avatar = "",
    this.isBanned = -1,
    this.isSubscribe = -1,
    this.status = -1,
    this.lastNotificationSeen = "",
    required this.userSetting,
    this.address = "",
    this.latitude = "",
    this.longitude = "",
    this.userType = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    this.aboutSelf = "",
    this.expert = "",
    this.facebookLink = "",
    this.instagramLink = "",
    this.twitterLink = "",
    this.dribbbleLink = "",
    this.fullName = "",
    this.profileImage = "",
    required this.profile,
    this.media = const <Media>[],
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      id: json['id'] is int ? json['id'] : -1,
      firstName: json['first_name'] is String ? json['first_name'] : "",
      lastName: json['last_name'] is String ? json['last_name'] : "",
      email: json['email'] is String ? json['email'] : "",
      mobile: json['mobile'] is String ? json['mobile'] : "",
      loginType: json['login_type'] is String ? json['login_type'] : "",
      playerId: json['player_id'] is String ? json['player_id'] : "",
      webPlayerId: json['web_player_id'] is String ? json['web_player_id'] : "",
      gender: json['gender'] is String ? json['gender'] : "",
      dateOfBirth: json['date_of_birth'] is String ? json['date_of_birth'] : "",
      isManager: json['is_manager'] is int ? json['is_manager'] : -1,
      showInCalender: json['show_in_calender'] is int ? json['show_in_calender'] : -1,
      emailVerifiedAt: json['email_verified_at'] is String ? json['email_verified_at'] : "",
      avatar: json['avatar'] is String ? json['date_of_birth'] : "",
      isBanned: json['is_banned'] is int ? json['is_banned'] : -1,
      isSubscribe: json['is_subscribe'] is int ? json['is_subscribe'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      lastNotificationSeen: json['last_notification_seen'] is String ? json['last_notification_seen'] : "",
      userSetting: json['user_setting'] is Map ? UserSetting.fromJson(json['user_setting']) : UserSetting(),
      address: json['address'] is String ? json['address'] : "",
      latitude: json['latitude'] is String ? json['latitude'] : "",
      longitude: json['longitude'] is String ? json['longitude'] : "",
      userType: json['user_type'] is String ? json['user_type'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
      aboutSelf: json['about_self'] is String ? json['about_self'] : "",
      expert: json['expert'] is String ? json['expert'] : "",
      facebookLink: json['facebook_link'] is String ? json['facebook_link'] : "",
      instagramLink: json['instagram_link'] is String ? json['instagram_link'] : "",
      twitterLink: json['twitter_link'] is String ? json['twitter_link'] : "",
      dribbbleLink: json['dribbble_link'] is String ? json['dribbble_link'] : "",
      fullName: json['full_name'] is String ? json['full_name'] : "",
      profileImage: json['profile_image'] is String ? json['profile_image'] : "",
      profile: json['profile'] is Map ? Profile.fromJson(json['profile']) : Profile(),
      media: json['media'] is List ? List<Media>.from(json['media'].map((x) => Media.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'login_type': loginType,
      'player_id': playerId,
      'web_player_id': webPlayerId,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'is_manager': isManager,
      'show_in_calender': showInCalender,
      'email_verified_at': emailVerifiedAt,
      'avatar': avatar,
      'is_banned': isBanned,
      'is_subscribe': isSubscribe,
      'status': status,
      'last_notification_seen': lastNotificationSeen,
      'user_setting': userSetting.toJson(),
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'user_type': userType,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'about_self': aboutSelf,
      'expert': expert,
      'facebook_link': facebookLink,
      'instagram_link': instagramLink,
      'twitter_link': twitterLink,
      'dribbble_link': dribbbleLink,
      'full_name': fullName,
      'profile_image': profileImage,
      'profile': profile.toJson(),
      'media': media.map((e) => e.toJson()).toList(),
    };
  }
}

class UserSetting {
  String themeScheme;

  UserSetting({
    this.themeScheme = "",
  });

  factory UserSetting.fromJson(Map<String, dynamic> json) {
    return UserSetting(
      themeScheme: json['theme_scheme'] is String ? json['theme_scheme'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'theme_scheme': themeScheme,
    };
  }
}

class Profile {
  int id;
  String aboutSelf;
  String expert;
  String facebookLink;
  String instagramLink;
  String twitterLink;
  String dribbbleLink;
  String latitude;
  String longitude;
  int userId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Profile({
    this.id = -1,
    this.aboutSelf = "",
    this.expert = "",
    this.facebookLink = "",
    this.instagramLink = "",
    this.twitterLink = "",
    this.dribbbleLink = "",
    this.latitude = "",
    this.longitude = "",
    this.userId = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] is int ? json['id'] : -1,
      aboutSelf: json['about_self'] is String ? json['about_self'] : "",
      expert: json['expert'] is String ? json['expert'] : "",
      facebookLink: json['facebook_link'] is String ? json['facebook_link'] : "",
      instagramLink: json['instagram_link'] is String ? json['instagram_link'] : "",
      twitterLink: json['twitter_link'] is String ? json['twitter_link'] : "",
      dribbbleLink: json['dribbble_link'] is String ? json['dribbble_link'] : "",
      latitude: json['latitude'] is String ? json['latitude'] : "",
      longitude: json['longitude'] is String ? json['longitude'] : "",
      userId: json['user_id'] is int ? json['user_id'] : -1,
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'about_self': aboutSelf,
      'expert': expert,
      'facebook_link': facebookLink,
      'instagram_link': instagramLink,
      'twitter_link': twitterLink,
      'dribbble_link': dribbbleLink,
      'latitude': latitude,
      'longitude': longitude,
      'user_id': userId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class Media {
  int id;
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  List<dynamic> manipulations;
  List<dynamic> customProperties;
  List<dynamic> generatedConversions;
  List<dynamic> responsiveImages;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String originalUrl;
  String previewUrl;

  Media({
    this.id = -1,
    this.modelType = "",
    this.modelId = -1,
    this.uuid = "",
    this.collectionName = "",
    this.name = "",
    this.fileName = "",
    this.mimeType = "",
    this.disk = "",
    this.conversionsDisk = "",
    this.size = -1,
    this.manipulations = const [],
    this.customProperties = const [],
    this.generatedConversions = const [],
    this.responsiveImages = const [],
    this.orderColumn = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.originalUrl = "",
    this.previewUrl = "",
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] is int ? json['id'] : -1,
      modelType: json['model_type'] is String ? json['model_type'] : "",
      modelId: json['model_id'] is int ? json['model_id'] : -1,
      uuid: json['uuid'] is String ? json['uuid'] : "",
      collectionName: json['collection_name'] is String ? json['collection_name'] : "",
      name: json['name'] is String ? json['name'] : "",
      fileName: json['file_name'] is String ? json['file_name'] : "",
      mimeType: json['mime_type'] is String ? json['mime_type'] : "",
      disk: json['disk'] is String ? json['disk'] : "",
      conversionsDisk: json['conversions_disk'] is String ? json['conversions_disk'] : "",
      size: json['size'] is int ? json['size'] : -1,
      manipulations: json['manipulations'] is List ? json['manipulations'] : [],
      customProperties: json['custom_properties'] is List ? json['custom_properties'] : [],
      generatedConversions: json['generated_conversions'] is List ? json['generated_conversions'] : [],
      responsiveImages: json['responsive_images'] is List ? json['responsive_images'] : [],
      orderColumn: json['order_column'] is int ? json['order_column'] : -1,
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      originalUrl: json['original_url'] is String ? json['original_url'] : "",
      previewUrl: json['preview_url'] is String ? json['preview_url'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model_type': modelType,
      'model_id': modelId,
      'uuid': uuid,
      'collection_name': collectionName,
      'name': name,
      'file_name': fileName,
      'mime_type': mimeType,
      'disk': disk,
      'conversions_disk': conversionsDisk,
      'size': size,
      'manipulations': [],
      'custom_properties': [],
      'generated_conversions': [],
      'responsive_images': [],
      'order_column': orderColumn,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'original_url': originalUrl,
      'preview_url': previewUrl,
    };
  }
}
