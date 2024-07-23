import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/add_services_forms/service_api.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';

import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import 'model/category_model.dart';
import 'model/service_list_model.dart';

class AddServiceController extends GetxController {
  TextEditingController serviceCont = TextEditingController();
  TextEditingController durationCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController categoryCont = TextEditingController();
  TextEditingController searchCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();

  FocusNode serviceNameFocus = FocusNode();
  FocusNode serviceDurationFocus = FocusNode();
  FocusNode defaultPriceFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  Rx<ServiceData> serviceData = ServiceData(id: (-1).obs).obs;

  RxBool isLoading = false.obs;
  RxBool hasErrorFetchingCategory = false.obs;
  RxBool isEdit = false.obs;

  RxString errorMessageCategory = "".obs;
  RxString serviceImage = "".obs;

  RxList<PlatformFile> serviceFiles = RxList();

  //Category
  Rx<ShopCategoryModel> selectedVeterinaryType = ShopCategoryModel().obs;
  RxList<ShopCategoryModel> categoryList = RxList();
  RxList<ShopCategoryModel> categoryFilterList = RxList();

  // RxList<XFile> pickedFile = RxList();
  Rx<File> imageFile = File("").obs;
  XFile? pickedFile;

  @override
  void onInit() {
    getCategory();

    if (Get.arguments is ServiceData) {
      serviceData(Get.arguments as ServiceData);
      isEdit(true);
      serviceCont.text = serviceData.value.name;
      durationCont.text = serviceData.value.durationMin.toString();
      priceCont.text = serviceData.value.defaultPrice.toString();
      descriptionCont.text = serviceData.value.description;
      categoryCont.text = serviceData.value.categoryName;
      selectedVeterinaryType.value.categoryImage = serviceData.value.categoryImage;
      selectedVeterinaryType.value.id = serviceData.value.categoryId;
      serviceImage(serviceData.value.serviceImage);
    }

    super.onInit();
  }

  Future<void> handleFilesPickerClick() async {
    final pickedFiles = await pickFiles();
    Set<String> filePathsSet = serviceFiles.map((file) => file.name.trim().toLowerCase()).toSet();
    for (var i = 0; i < pickedFiles.length; i++) {
      if (!filePathsSet.contains(pickedFiles[i].name.trim().toLowerCase())) {
        serviceFiles.add(pickedFiles[i]);
      }
    }
  }

  //Get Category List
  getCategory() {
    isLoading(true);
    ServiceFormApis.getCategory(categoryType: serviceRole(loginUserData: loginUserData)).then((value) {
      isLoading(false);
      categoryList(value.data);
      hasErrorFetchingCategory(false);
    }).onError((error, stackTrace) {
      hasErrorFetchingCategory(true);
      errorMessageCategory(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  void searchCategoryFunc({
    required String searchtext,
    required RxList<ShopCategoryModel> categoryFilterList,
    required RxList<ShopCategoryModel> categorySList,
  }) {
    categoryFilterList.value = List.from(categorySList.where((element) => element.name.toString().toLowerCase().contains(searchtext.toString().toLowerCase())));
    for (var i = 0; i < categoryFilterList.length; i++) {
      log('SEARCHEDNAMES : ${categoryFilterList[i].toJson()}');
    }
    log('SEARCHEDNAMES.LENGTH: ${categoryFilterList.length}');
  }

  void onCategorySearchChange(searchtext) {
    searchCategoryFunc(
      searchtext: searchtext,
      categoryFilterList: categoryFilterList,
      categorySList: categoryList,
    );
  }

  bool get isShowFullList => categoryFilterList.isEmpty && searchCont.text.trim().isEmpty;

  serviceRole({loginUserData}) {
    if (loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)) {
      return ServicesKeyConst.veterinary;
    } else if (loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)) {
      return ServicesKeyConst.grooming;
    } else if (loginUserData.value.userRole.contains(EmployeeKeyConst.training)) {
      return ServicesKeyConst.training;
    } else {
      return "";
    }
  }

  Future<void> addServices() async {
    String id = '';
    isLoading(true);
    hideKeyBoardWithoutContext();
    if (selectedVeterinaryType.value.id.isNegative) return;

    if (isEdit.value) {
      id = serviceData.value.id.value.toString();
    }

    ServiceFormApis.addServices(
      isEdit: isEdit.value,
      serviceId: id,
      name: serviceCont.text.trim(),
      durationMin: durationCont.text.trim(),
      defaultPrice: priceCont.text.trim(),
      description: descriptionCont.text.trim(),
      type: serviceRole(loginUserData: loginUserData),
      categoryId: selectedVeterinaryType.value.id.toString(),
      imageFile: imageFile.value.path.isNotEmpty ? imageFile.value : null,
    ).then((value) {
      Get.back(result: true);
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString());
    });
  }

  Future<void> addServicesTraining() async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    if (selectedVeterinaryType.value.id.isNegative) return;
    ServiceFormApis.addServicesTraining(
      name: serviceCont.text.trim(),
      description: descriptionCont.text.trim(),
      type: serviceRole(loginUserData: loginUserData),
    ).catchError((e) {
      isLoading(false);
      toast(e.toString());
    });
  }

  Future<void> _handleGalleryClick() async {
    Get.back();
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      serviceImage('');
      imageFile(File(pickedFile!.path));
    }
  }

  Future<void> _handleCameraClick() async {
    Get.back();
    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      serviceImage('');
      imageFile(File(pickedFile!.path));
    }
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.value.gallery,
              leading: const Icon(Icons.image, color: primaryColor),
              onTap: () async {
                _handleGalleryClick();
              },
            ),
            SettingItemWidget(
              title: locale.value.camera,
              leading: const Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _handleCameraClick();
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }
}
