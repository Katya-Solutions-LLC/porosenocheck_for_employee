class NotificationRes {
  List<NotificationData> notificationData;
  int allUnreadCount;
  String message;
  bool status;

  NotificationRes({
    this.notificationData = const <NotificationData>[],
    this.allUnreadCount = -1,
    this.message = "",
    this.status = false,
  });

  factory NotificationRes.fromJson(Map<String, dynamic> json) {
    return NotificationRes(
      notificationData: json['notification_data'] is List ? List<NotificationData>.from(json['notification_data'].map((x) => NotificationData.fromJson(x))) : [],
      allUnreadCount: json['all_unread_count'] is int ? json['all_unread_count'] : -1,
      message: json['message'] is String ? json['message'] : "",
      status: json['status'] is bool ? json['status'] : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_data': notificationData.map((e) => e.toJson()).toList(),
      'all_unread_count': allUnreadCount,
      'message': message,
      'status': status,
    };
  }
}

class NotificationData {
  String id;
  String type;
  String notifiableType;
  int notifiableId;
  NotificationModel data;
  String readAt;
  String createdAt;
  String updatedAt;

  NotificationData({
    this.id = "",
    this.type = "",
    this.notifiableType = "",
    this.notifiableId = -1,
    required this.data,
    this.readAt = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] is String ? json['id'] : "",
      type: json['type'] is String ? json['type'] : "",
      notifiableType: json['notifiable_type'] is String ? json['notifiable_type'] : "",
      notifiableId: json['notifiable_id'] is int ? json['notifiable_id'] : -1,
      data: json['data'] is Map ? NotificationModel.fromJson(json['data']) : NotificationModel(notificationDetail: NotificationDetail()),
      readAt: json['read_at'] is String ? json['read_at'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'notifiable_type': notifiableType,
      'notifiable_id': notifiableId,
      'data': data.toJson(),
      'read_at': readAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class NotificationModel {
  String subject;
  NotificationDetail notificationDetail;

  NotificationModel({
    this.subject = "",
    required this.notificationDetail,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      subject: json['subject'] is String ? json['subject'] : "",
      notificationDetail: json['data'] is Map ? NotificationDetail.fromJson(json['data']) : NotificationDetail(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'data': notificationDetail.toJson(),
    };
  }
}

class NotificationDetail {
  String notificationType;
  String loggedInUserFullname;
  String loggedInUserRole;
  String companyName;
  String companyContactInfo;
  String type;
  int id;
  int itemId;
  int userId;
  String userName;
  int employeeId;
  String employeeName;
  String bookingDate;
  String bookingTime;
  String bookingServiceImage;
  String bookingServicesNames;
  String siteUrl;
  String notificationGroup;
  String orderCode;

  NotificationDetail({
    this.notificationType = "",
    this.loggedInUserFullname = "",
    this.loggedInUserRole = "",
    this.companyName = "",
    this.companyContactInfo = "",
    this.type = "",
    this.id = -1,
    this.itemId = -1,
    this.userId = -1,
    this.userName = "",
    this.employeeId = -1,
    this.employeeName = "",
    this.bookingDate = "",
    this.bookingTime = "",
    this.bookingServiceImage = "",
    this.bookingServicesNames = "",
    this.siteUrl = "",
    this.notificationGroup = "",
    this.orderCode = "",
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      notificationType: json['notification_type'] is String ? json['notification_type'] : "",
      loggedInUserFullname: json['logged_in_user_fullname'] is String ? json['logged_in_user_fullname'] : "",
      loggedInUserRole: json['logged_in_user_role'] is String ? json['logged_in_user_role'] : "",
      companyName: json['company_name'] is String ? json['company_name'] : "",
      companyContactInfo: json['company_contact_info'] is String ? json['company_contact_info'] : "",
      type: json['type'] is String ? json['type'] : "",
      id: json['id'] is int ? json['id'] : -1,
      itemId: json['item_id'] is int ? json['item_id'] : -1,
      userId: json['user_id'] is int ? json['user_id'] : -1,
      userName: json['user_name'] is String ? json['user_name'] : "",
      employeeId: json['employee_id'] is int ? json['employee_id'] : -1,
      employeeName: json['employee_name'] is String ? json['employee_name'] : "",
      bookingDate: json['booking_date'] is String ? json['booking_date'] : "",
      bookingTime: json['booking_time'] is String ? json['booking_time'] : "",
      bookingServiceImage: json['booking_services_image'] is String ? json['booking_services_image'] : "",
      bookingServicesNames: json['booking_services_names'] is String ? json['booking_services_names'] : "",
      siteUrl: json['site_url'] is String ? json['site_url'] : "",
      notificationGroup: json['notification_group'] is String ? json['notification_group'] : "",
      orderCode: json['order_code'] is String ? json['order_code'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_type': notificationType,
      'logged_in_user_fullname': loggedInUserFullname,
      'logged_in_user_role': loggedInUserRole,
      'company_name': companyName,
      'company_contact_info': companyContactInfo,
      'type': type,
      'id': id,
      'item_id': itemId,
      'user_id': userId,
      'user_name': userName,
      'employee_id': employeeId,
      'employee_name': employeeName,
      'booking_date': bookingDate,
      'booking_time': bookingTime,
      'booking_services_image': bookingServiceImage,
      'booking_services_names': bookingServicesNames,
      'site_url': siteUrl,
      'notification_group': notificationGroup,
      'order_code': orderCode,
    };
  }
}

class FirebaseNotificationModel {
  String? notificationId;
  String? templateId;
  String? templateName;
  String? sound;
  String? title;
  String? body;
  String? launchUrl;
  Map<String, dynamic>? additionalData;
  Map<String, dynamic>? attachments;
  bool? contentAvailable;
  bool? mutableContent;
  String? category;
  int? badge;
  int? badgeIncrement;
  String? subtitle;
  double? relevanceScore;
  String? interruptionLevel;
  int? androidNotificationId;
  String? smallIcon;
  String? largeIcon;
  String? bigPicture;
  String? smallIconAccentColor;
  String? ledColor;
  int? lockScreenVisibility;
  String? groupKey;
  String? groupMessage;
  String? fromProjectNumber;
  String? collapseId;
  int? priority;

  FirebaseNotificationModel.fromJson(Map<String, dynamic> json) {
    contentAvailable = json['contentAvailable'];
    mutableContent = json['mutableContent'];
    category = json['category'];
    badge = json['badge'];
    badgeIncrement = json['badgeIncrement'];
    subtitle = json['subtitle'];
    attachments = json['attachments']??{};
    relevanceScore = json['relevanceScore'];
    interruptionLevel = json['interruptionLevel'];

    // Android Specific Parameters
    smallIcon = json['smallIcon'];
    largeIcon = json['largeIcon'];
    bigPicture = json['bigPicture'];
    smallIconAccentColor = json['smallIconAccentColor'];
    ledColor = json['ledColor'];
    lockScreenVisibility = json['lockScreenVisibility'];
    groupMessage = json['groupMessage'];
    groupKey = json['groupKey'];
    fromProjectNumber = json['fromProjectNumber'];
    collapseId = json['collapseId'];
    priority = json['priority'];
    androidNotificationId = json['androidNotificationId'];

    templateName = json['templateName'];
    templateId = json['templateId'];
    sound = json['sound'];
    title = json['title'];
    body = json['body'];
    launchUrl = json['launchUrl'];
    additionalData = json['additionalData']??{};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['notificationId'] = notificationId;
    data['contentAvailable'] = contentAvailable;
    data['mutableContent'] = mutableContent;
    data['category'] = category;
    data['badge'] = badge;
    data['badgeIncrement'] = badgeIncrement;
    data['subtitle'] = subtitle;
    data['attachments'] = attachments;
    data['relevanceScore'] = relevanceScore;
    data['interruptionLevel'] = interruptionLevel;

    // Android Specific Parameters
    data['smallIcon'] = smallIcon;
    data['largeIcon'] = largeIcon;
    data['bigPicture'] = bigPicture;
    data['smallIconAccentColor'] = smallIconAccentColor;
    data['ledColor'] = ledColor;
    data['lockScreenVisibility'] = lockScreenVisibility;
    data['groupMessage'] = groupMessage;
    data['groupKey'] = groupKey;
    data['fromProjectNumber'] = fromProjectNumber;
    data['collapseId'] = collapseId;
    data['priority'] = priority;
    data['androidNotificationId'] = androidNotificationId;

    data['templateName'] = templateName;
    data['templateId'] = templateId;
    data['sound'] = sound;
    data['title'] = title;
    data['body'] = body;
    data['launchUrl'] = launchUrl;
    data['additionalData'] = additionalData;

    return data;
  }
}

