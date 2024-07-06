import '../../../generated/assets.dart';

class PetDataModel {
  String? image;
  String? name;
  String? title;

  PetDataModel({
    this.image,
    this.name,
    this.title,
  });
}

List<PetDataModel> getEditProfile() {
  List<PetDataModel> profileList = [
    PetDataModel(image: Assets.petProfileMille, name: "Mille", title: "Breed: Bulldog"),
    PetDataModel(image: Assets.petProfileBrownie, name: "Brownie", title: "Breed: Ragdoll"),
    PetDataModel(image: Assets.petProfileCuddles, name: "Cuddles", title: "Breed: Hyplus"),
    PetDataModel(image: Assets.petProfileJamaican, name: "Jamaican", title: "Breed: Leucistic"),
    PetDataModel(image: Assets.petProfileStuart, name: "stuart", title: "Breed: Stainrat"),
    PetDataModel(image: Assets.petProfileSpix, name: "spix", title: "Breed: Macaw"),
  ];
  return profileList;
}
