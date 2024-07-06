import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../main.dart';
import '../../../../utils/colors.dart';
import '../model/brand_list_response.dart';
import '../services/brand_api.dart';

class AddBrandController extends RxController {
  TextEditingController nameCont = TextEditingController();

  XFile? pickedFile;
  Rx<File> imageFile = File("").obs;
  Rx<BrandData> brandData = BrandData(id: -1).obs;

  RxBool isLoading = false.obs;
  RxBool isStatus = true.obs;
  RxBool isEdit = false.obs;

  RxString brandImage = "".obs;

  @override
  void onInit() {
    if (Get.arguments is BrandData) {
      brandData(Get.arguments);
      isEdit(true);
      nameCont.text = brandData.value.name;
      isStatus = brandData.value.status == 1 ? true.obs : false.obs;
      brandImage(brandData.value.brandImage);
    }

    super.onInit();
  }

  Future<void> _handleGalleryClick() async {
    Get.back();
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile(File(pickedFile!.path));
    }
  }

  Future<void> _handleCameraClick() async {
    Get.back();
    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
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

  Future<void> addUpdateBrand() async {
    isLoading(true);
    BrandAPI.addUpdateBrand(
      isEdit: isEdit.value,
      id: brandData.value.id,
      brandName: nameCont.text,
      status: isStatus.value,
      imageFile: imageFile.value.path.isNotEmpty ? imageFile.value : null,
      onSuccess: (s) {
        Get.back(result: true);
      },
    ).then((value) {
      //
    }).catchError((e) {
      toast(e.toString());
    }).whenComplete(() => isLoading(false));
  }
}
