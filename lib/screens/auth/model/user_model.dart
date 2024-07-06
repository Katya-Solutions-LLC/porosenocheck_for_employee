class UserModel {
  int? contact;
  int userId;
  String? firstName;
  String? lastName;
  String? token;
  String? userEmail;
  String? profileImage;
  Subcription subscription;

  UserModel({
    this.contact,
    this.firstName,
    this.lastName,
    this.token,
    this.userEmail,
    this.profileImage,
    this.userId = -1,
    required this.subscription,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      contact: json['contact'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      token: json['token'],
      userEmail: json['user_email'],
      profileImage: json['profile_image'],
      userId: json['user_id'] is int ? json['user_id'] : -1,
      subscription: json['subcription'] is Map ? Subcription.fromJson(json['subcription']) : Subcription(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contact'] = contact;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['token'] = token;
    data['user_email'] = userEmail;
    data['profile_image'] = profileImage;
    data['user_id'] = userId;
    data['subscription'] = subscription.toJson();
    return data;
  }
}

class Subcription {
  String id;
  String subscriptionId;
  String name;
  String startdate;
  String enddate;
  int petCount;
  int totalFreeHealthConsults;
  int remainingFreeHealthConsults;
  bool canBookFreeHealthConsult;

  //local vars
  String txnId;
  String applicationFeeAmount;

  Subcription({
    this.id = "",
    this.subscriptionId = "",
    this.name = "",
    this.startdate = "",
    this.enddate = "",
    this.petCount = -1,
    this.totalFreeHealthConsults = -1,
    this.remainingFreeHealthConsults = -1,
    this.canBookFreeHealthConsult = false,
    this.txnId = "",
    this.applicationFeeAmount = "",
  });

  factory Subcription.fromJson(Map<String, dynamic> json) {
    return Subcription(
      id: json['id'] is String ? json['id'] : "-1",
      subscriptionId: json['subscription_id'] is String ? json['subscription_id'] : "",
      name: json['name'] is String ? json['name'] : "",
      startdate: json['startdate'] is String ? json['startdate'] : "",
      enddate: json['enddate'] is String ? json['enddate'] : "",
      petCount: json['pet_count'] is int ? json['pet_count'] : -1,
      totalFreeHealthConsults: json['total_free_health_consults'] is int ? json['total_free_health_consults'] : -1,
      remainingFreeHealthConsults: json['remaining_free_health_consults'] is int ? json['remaining_free_health_consults'] : -1,
      canBookFreeHealthConsult: json['can_book_free_health_consult'] is bool ? json['can_book_free_health_consult'] : false,
      txnId: json['txn_id'] is String ? json['txn_id'] : "",
      applicationFeeAmount: json['application_fee_amount'] is String ? json['application_fee_amount'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subscription_id': subscriptionId,
      'name': name,
      'startdate': startdate,
      'enddate': enddate,
      'pet_count': petCount,
      'total_free_health_consults': totalFreeHealthConsults,
      'remaining_free_health_consults': remainingFreeHealthConsults,
      'can_book_free_health_consult': canBookFreeHealthConsult,
      'txn_id': txnId,
      'application_fee_amount': applicationFeeAmount,
    };
  }
}
