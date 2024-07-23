import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/screens/shop/supply_logistic/logistics/model/logistic_list_response.dart';

import '../../../../../utils/colors.dart';
import '../services/logistic_api.dart';

class AddLogisticController extends RxController {
  TextEditingController nameCont = TextEditingController();

  XFile? pickedFile;
  Rx<File> imageFile = File("").obs;

  RxBool isLoading = false.obs;
  RxBool isStatus = false.obs;
  RxBool isEdit = false.obs;

  Rx<LogisticData> logisticData = LogisticData(id: -1).obs;
  RxString logisticImage = "".obs;

  @override
  void onInit() {
    if (Get.arguments is LogisticData) {
      logisticData(Get.arguments);
      isEdit(true);
      nameCont.text = logisticData.value.name;
      isStatus = logisticData.value.status == 1 ? true.obs : false.obs;
      logisticImage(logisticData.value.logisticImage);
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

  Future<void> addUpdateLogistics({bool isFromGroomer = false}) async {
    isLoading(true);
    LogisticAPI.addUpdateLogistic(
      id: logisticData.value.id,
      logisticName: nameCont.text,
      status: isStatus.value,
      imageFile: imageFile.value,
      isEdit: isEdit.value,
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
