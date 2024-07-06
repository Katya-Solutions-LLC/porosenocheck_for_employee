import 'package:get/get.dart';

import '../../../utils/constants.dart';
import '../../auth/model/pet_owners_res.dart';

class BookingRes {
  bool status;
  List<BookingDataModel> data;
  String message;

  BookingRes({
    this.status = false,
    this.data = const <BookingDataModel>[],
    this.message = "",
  });

  factory BookingRes.fromJson(Map<String, dynamic> json) {
    return BookingRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<BookingDataModel>.from(json['data'].map((x) => BookingDataModel.fromJson(x))) : [],
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

class BookingDataModel {
  int id;
  String note;
  String status;
  String startDateTime;
  String petName;
  String breed;
  String petImage;
  SystemService service;
  int employeeId;
  String employeeName;
  String employeeImage;
  int customerId;
  String customerName;
  String customerImage;
  String customerContact;
  num price;
  String serviceDateTime;
  String duration;
  String veterinaryReason;
  int veterinaryServiceId;
  String veterinaryServiceName;
  String address;
  String dayCareDate;
  String dropoffTime;
  String pickupTime;
  List<String> food;
  List<String> activity;
  String dropoffDateTime;
  String dropoffAddress;
  String pickupDateTime;
  String pickupAddress;
  String medicalReport;
  String startVideoLink;
  String joinVideoLink;
  List<FacilityModel> additionalFacility;
  PaymentDetails payment;
  Training training;
  PetData? petDetails;

  num totalAmount;

  ///use only for notification id
  String notificationId;

  BookingDataModel({
    this.id = -1,
    this.note = "",
    this.status = "",
    this.startDateTime = "",
    this.petName = "",
    this.breed = "",
    this.petImage = "",
    required this.service,
    this.employeeId = -1,
    this.employeeName = "",
    this.employeeImage = "",
    this.customerId = -1,
    this.customerName = "",
    this.customerImage = "",
    this.customerContact = "",
    this.price = -1,
    this.serviceDateTime = "",
    this.duration = "",
    this.veterinaryReason = "",
    this.veterinaryServiceId = -1,
    this.veterinaryServiceName = "",
    this.address = "",
    this.dayCareDate = "",
    this.dropoffTime = "",
    this.pickupTime = "",
    this.food = const <String>[],
    this.activity = const <String>[],
    this.dropoffDateTime = "",
    this.dropoffAddress = "",
    this.pickupDateTime = "",
    this.pickupAddress = "",
    this.medicalReport = "",
    this.startVideoLink = "",
    this.joinVideoLink = "",
    this.additionalFacility = const <FacilityModel>[],
    required this.payment,
    required this.training,
    this.petDetails,
    this.totalAmount = 0.0,
    this.notificationId = "",
  });

  factory BookingDataModel.fromJson(Map<String, dynamic> json) {
    final paymentObj = PaymentDetails(
      taxs: json['taxes'] is List ? List<Taxs>.from(json['taxes'].map((x) => Taxs.fromJson(x))) : [],
      totalAmount: json['total_amount'] is num ? json['total_amount'] : 0,
      bookingId: json['id'] is int ? json['id'] : -1,
      paymentStatus: json['payment_status'] is int
          ? json['payment_status'] == 1
              ? PaymentStatus.PAID
              : json['payment_status'] == 0
                  ? PaymentStatus.pending
                  : PaymentStatus.failed
          : PaymentStatus.failed,
    );
    return BookingDataModel(
      id: json['id'] is int ? json['id'] : -1,
      note: json['note'] is String ? json['note'] : "",
      status: json['status'] is String ? json['status'] : "",
      startDateTime: json['start_date_time'] is String ? json['start_date_time'] : "",
      petName: json['pet_name'] is String ? json['pet_name'] : "",
      breed: json['breed'] is String ? json['breed'] : "",
      petImage: json['pet_image'] is String ? json['pet_image'] : "",
      service: json['service'] is Map ? SystemService.fromJson(json['service']) : SystemService(),
      employeeId: json['employee_id'] is int ? json['employee_id'] : -1,
      employeeName: json['employee_name'] is String ? json['employee_name'] : "",
      employeeImage: json['employee_image'] is String ? json['employee_image'] : "",
      customerId: json['customer_id'] is int ? json['customer_id'] : -1,
      customerName: json['customer_name'] is String ? json['customer_name'] : "",
      customerImage: json['customer_image'] is String ? json['customer_image'] : "",
      customerContact: json['customer_contact'] is String ? json['customer_contact'] : "",
      price: json['price'] is num ? json['price'] : -1,
      serviceDateTime: json['date_time'] is String ? json['date_time'] : "",
      duration: json['duration'] is String ? json['duration'] : "",
      veterinaryReason: json['reason'] is String ? json['reason'] : "",
      veterinaryServiceId: json['service_id'] is int ? json['service_id'] : -1,
      veterinaryServiceName: json['service_name'] is String ? json['service_name'] : "",
      address: json['address'] is String ? json['address'] : "",
      dayCareDate: json['date'] is String ? json['date'] : "",
      dropoffTime: json['dropoff_time'] is String ? json['dropoff_time'] : "",
      pickupTime: json['pickup_time'] is String ? json['pickup_time'] : "",
      food: json['food'] is List ? List<String>.from(json['food'].map((x) => x)) : [],
      activity: json['activity'] is List ? List<String>.from(json['activity'].map((x) => x)) : [],
      dropoffDateTime: json['dropoff_date_time'] is String ? json['dropoff_date_time'] : "",
      dropoffAddress: json['dropoff_address'] is String ? json['dropoff_address'] : "",
      pickupDateTime: json['pickup_date_time'] is String ? json['pickup_date_time'] : "",
      pickupAddress: json['pickup_address'] is String ? json['pickup_address'] : "",
      medicalReport: json['medical_report'] is String ? json['medical_report'] : "",
      startVideoLink: json['start_video_link'] is String ? json['start_video_link'] : "",
      joinVideoLink: json['join_video_link'] is String ? json['join_video_link'] : "",
      additionalFacility: json['additional_facility'] is List ? List<FacilityModel>.from(json['additional_facility'].map((x) => FacilityModel.fromJson(x))) : [],
      payment: json['payment'] is Map ? PaymentDetails.fromJson(json['payment']) : paymentObj,
      training: json['training'] is Map ? Training.fromJson(json['training']) : Training(),
      petDetails: json['pet_details'] is Map ? PetData.fromJson(json['pet_details']) : PetData(),
      totalAmount: json['total_amount'] is double ? json['total_amount'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'status': status,
      'start_date_time': startDateTime,
      'pet_name': petName,
      'breed': breed,
      'pet_image': petImage,
      'service': service.toJson(),
      'employee_id': employeeId,
      'employee_name': employeeName,
      'employee_image': employeeImage,
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_image': customerImage,
      'price': price,
      'date_time': serviceDateTime,
      'duration': duration,
      'reason': veterinaryReason,
      'service_id': veterinaryServiceId,
      'service_name': veterinaryServiceName,
      'address': address,
      'date': dayCareDate,
      'dropoff_time': dropoffTime,
      'pickup_time': pickupTime,
      'food': food.map((e) => e).toList(),
      'activity': activity.map((e) => e).toList(),
      'dropoff_date_time': dropoffDateTime,
      'dropoff_address': dropoffAddress,
      'pickup_date_time': pickupDateTime,
      'pickup_address': pickupAddress,
      'start_video_link': startVideoLink.trim(),
      'join_video_link': joinVideoLink.trim(),
      'additional_facility': additionalFacility.map((e) => e.toJson()).toList(),
      'payment': payment.toJson(),
      'training': training.toJson(),
      'pet_details': petDetails?.toJson(),
      'total_amount': totalAmount,
    };
  }
}

class PaymentDetails {
  int id;
  int bookingId;
  String externalTransactionId;
  num discountPercentage;
  num discountAmount;
  num totalAmount;
  List<Taxs> taxs;
  String paymentStatus;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  String transactionType;
  num tipAmount;
  String taxPercentage;

  PaymentDetails({
    this.id = -1,
    this.bookingId = -1,
    this.externalTransactionId = "",
    this.discountPercentage = 0.0,
    this.discountAmount = 0.0,
    this.totalAmount = 0.0,
    this.taxs = const <Taxs>[],
    this.paymentStatus = PaymentStatus.pending,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
    this.transactionType = "",
    this.tipAmount = 0.0,
    this.taxPercentage = "",
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      id: json['id'] is int ? json['id'] : -1,
      bookingId: json['booking_id'] is int ? json['booking_id'] : -1,
      externalTransactionId: json['external_transaction_id'] is String ? json['external_transaction_id'] : "",
      discountPercentage: json['discount_percentage'] is num ? json['discount_percentage'] : 0.0,
      discountAmount: json['discount_amount'] is num ? json['discount_amount'] : 0.0,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : 0.0,
      taxs: json['taxes'] is List ? List<Taxs>.from(json['taxes'].map((x) => Taxs.fromJson(x))) : [],
      paymentStatus: json['payment_status'] is int
          ? json['payment_status'] == 1
              ? PaymentStatus.PAID
              : json['payment_status'] == 0
                  ? PaymentStatus.pending
                  : PaymentStatus.failed
          : PaymentStatus.failed,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
      transactionType: json['transaction_type'] is String ? json['transaction_type'] : "",
      tipAmount: json['tip_amount'] is num ? json['tip_amount'] : 0.0,
      taxPercentage: json['tax_percentage'] is String ? json['tax_percentage'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'booking_id': bookingId,
      'external_transaction_id': externalTransactionId,
      'discount_percentage': discountPercentage,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'taxs': taxs.map((e) => e.toJson()).toList(),
      'payment_status': paymentStatus,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'transaction_type': transactionType,
      'tip_amount': tipAmount,
      'tax_percentage': taxPercentage,
    };
  }
}

class Taxs {
  String title;
  num value;

  Taxs({
    this.title = "",
    this.value = 0,
  });

  factory Taxs.fromJson(Map<String, dynamic> json) {
    return Taxs(
      title: json['title'] is String ? json['title'] : "",
      value: json['amount'] is num ? json['amount'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': value,
    };
  }
}

class SystemService {
  int id;
  String slug;
  String name;
  String description;
  int status;
  String serviceImage;
  num serviceAmount;

  SystemService({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.description = "",
    this.status = -1,
    this.serviceImage = "",
    this.serviceAmount = 0,
  });

  factory SystemService.fromJson(Map<String, dynamic> json) {
    return SystemService(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      description: json['description'] is String ? json['description'] : "",
      status: json['status'] is int ? json['status'] : -1,
      serviceImage: json['service_image'] is String ? json['service_image'] : "",
      serviceAmount: json['service_amount'] is num ? json['service_amount'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'status': status,
      'service_image': serviceImage,
      'service_amount': serviceAmount,
    };
  }
}

class FacilityModel {
  int id;
  String name;
  String slug;
  String description;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int status;
  RxBool isChecked = false.obs;

  FacilityModel({
    this.id = -1,
    this.name = "",
    this.slug = "",
    this.description = "",
    this.status = -1,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      slug: json['slug'] is String ? json['slug'] : "",
      description: json['description'] is String ? json['description'] : "",
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
    };
  }
}

class Training {
  int id;
  String slug;
  String name;
  String description;
  int status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Training({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.description = "",
    this.status = -1,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      description: json['description'] is String ? json['description'] : "",
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
