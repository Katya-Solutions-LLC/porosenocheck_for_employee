
import 'pet_note_model.dart';

class PetOwnersRes {
  bool status;
  List<PetOwner> petOwners;
  String message;

  PetOwnersRes({
    this.status = false,
    this.petOwners = const <PetOwner>[],
    this.message = "",
  });

  factory PetOwnersRes.fromJson(Map<String, dynamic> json) {
    return PetOwnersRes(
      status: json['status'] is bool ? json['status'] : false,
      petOwners: json['data'] is List ? List<PetOwner>.from(json['data'].map((x) => PetOwner.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': petOwners.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class PetOwner {
  int id;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String playerId;
  String fullName;
  String gender;
  String dateOfBirth;
  String profileImage;
  int status;
  List<PetData> pets;
  String createdAt;
  String updatedAt;
  String deletedAt;

  PetOwner({
    this.id = -1,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.mobile = "",
    this.playerId = "",
    this.fullName = "",
    this.gender = "",
    this.dateOfBirth = "",
    this.profileImage = "",
    this.status = -1,
    this.pets = const <PetData>[],
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory PetOwner.fromJson(Map<String, dynamic> json) {
    return PetOwner(
      id: json['id'] is int ? json['id'] : -1,
      firstName: json['first_name'] is String ? json['first_name'] : "",
      lastName: json['last_name'] is String ? json['last_name'] : "",
      email: json['email'] is String ? json['email'] : "",
      mobile: json['mobile'] is String ? json['mobile'] : "",
      playerId: json['player_id'] is String ? json['player_id'] : "",
      fullName: json['full_name'] is String ? json['full_name'] : "",
      gender: json['gender'] is String ? json['gender'] : "",
      dateOfBirth: json['date_of_birth'] is String ? json['date_of_birth'] : "",
      profileImage: json['profile_image'] is String ? json['profile_image'] : "",
      status: json['status'] is int ? json['status'] : -1,
      pets: json['pets'] is List ? List<PetData>.from(json['pets'].map((x) => PetData.fromJson(x))) : [],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'player_id': playerId,
      'full_name': fullName,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'profile_image': profileImage,
      'status': status,
      'pets': pets.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class PetData {
  int id;
  String name;
  String slug;
  String pettype;
  String breed;
  int breedId;
  String size;
  String petImage;
  String dateOfBirth;
  String age;
  String gender;
  num weight;
  String weightUnit;
  num height;
  String heightUnit;
  int userId;
  int status;
  String createdBy;
  String updatedBy;
  String deletedBy;
  List<NotePetModel> petNotes;

  PetData({
    this.id = -1,
    this.name = "",
    this.slug = "",
    this.pettype = "",
    this.breed = "",
    this.breedId = -1,
    this.size = "",
    this.petImage = "",
    this.dateOfBirth = "",
    this.age = "",
    this.gender = "",
    this.weight = 0,
    this.weightUnit = "",
    this.height = 0,
    this.heightUnit = "",
    this.userId = -1,
    this.status = -1,
    this.createdBy = "",
    this.updatedBy = "",
    this.deletedBy = "",
    this.petNotes = const <NotePetModel>[],
  });

  factory PetData.fromJson(Map<String, dynamic> json) {
    return PetData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      slug: json['slug'] is String ? json['slug'] : "",
      pettype: json['pettype'] is String ? json['pettype'] : "",
      breed: json['breed'] is String ? json['breed'] : "",
      breedId: json['breed_id'] is int ? json['breed_id'] : -1,
      size: json['size'] is String ? json['size'] : "",
      petImage: json['pet_image'] is String ? json['pet_image'] : "",
      dateOfBirth: json['date_of_birth'] is String ? json['date_of_birth'] : "",
      age: json['age'] is String ? json['age'] : "",
      gender: json['gender'] is String ? json['gender'] : "",
      weight: json['weight'] is num ? json['weight'] : 0,
      weightUnit: json['weight_unit'] is String ? json['weight_unit'] : "",
      height: json['height'] is num ? json['height'] : 0,
      heightUnit: json['height_unit'] is String ? json['height_unit'] : "",
      userId: json['user_id'] is int ? json['user_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'] is String ? json['created_by'] : "",
      updatedBy: json['updated_by'] is String ? json['updated_by'] : "",
      deletedBy: json['deleted_by'] is String ? json['deleted_by'] : "",
      petNotes: json['pet_notes'] is List ? List<NotePetModel>.from(json['pet_notes'].map((x) => NotePetModel.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'pettype': pettype,
      'breed': breed,
      'breed_id': breedId,
      'size': size,
      'pet_image': petImage,
      'date_of_birth': dateOfBirth,
      'age': age,
      'gender': gender,
      'weight': weight,
      'weight_unit': weightUnit,
      'height': height,
      'height_unit': heightUnit,
      'user_id': userId,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'pet_notes': petNotes.map((e) => e.toJson()).toList(),
    };
  }
}
