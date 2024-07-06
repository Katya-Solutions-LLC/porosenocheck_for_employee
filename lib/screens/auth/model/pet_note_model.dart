import 'package:get/get.dart';

import 'login_response.dart';

class PetNoteRes {
  bool status;
  List<NotePetModel> data;
  String message;

  PetNoteRes({
    this.status = false,
    this.data = const <NotePetModel>[],
    this.message = "",
  });

  factory PetNoteRes.fromJson(Map<String, dynamic> json) {
    return PetNoteRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<NotePetModel>.from(json['data'].map((x) => NotePetModel.fromJson(x))) : [],
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

class NotePetModel {
  int id;
  String title;
  String description;
  int petId;
  String petName;
  String img;
  int status;
  int createdBy;
  UserData createdbyUser;
  String updatedBy;
  String deletedBy;
  RxBool isPrivate;

  NotePetModel({
    this.id = -1,
    this.title = "",
    this.description = "",
    this.petId = -1,
    this.petName = "",
    this.img = "",
    this.status = -1,
    this.createdBy = -1,
    required this.createdbyUser,
    this.updatedBy = "",
    this.deletedBy = "",
    required this.isPrivate,
  });

  factory NotePetModel.fromJson(Map<String, dynamic> json) {
    return NotePetModel(
      id: json['id'] is int ? json['id'] : -1,
      title: json['title'] is String ? json['title'] : "",
      description: json['description'] is String ? json['description'] : "",
      petId: json['pet_id'] is int ? json['pet_id'] : -1,
      petName: json['pet_name'] is String ? json['pet_name'] : "",
      img: json['img'] is String ? json['img'] : "",
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      createdbyUser: json['createdby_user'] is Map ? UserData.fromJson(json['createdby_user']) : UserData(),
      updatedBy: json['updated_by'] is String ? json['updated_by'] : "",
      deletedBy: json['deleted_by'] is String ? json['deleted_by'] : "",
      isPrivate: (json['is_private'] == 1).obs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'pet_id': petId,
      'pet_name': petName,
      'status': status,
      'created_by': createdBy,
      'created_by_name': createdbyUser,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'is_private': isPrivate.value,
    };
  }
}
