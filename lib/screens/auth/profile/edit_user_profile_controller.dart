import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/permissions.dart';

import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/local_storage.dart';
import '../../location_service.dart';
import '../../map/map_screen.dart';
import '../model/login_response.dart';
import '../services/auth_services.dart';

class EditUserProfileController extends GetxController {
  //Constructor region
  EditUserProfileController({this.isProfilePhoto = false});

  RxBool isShopEnable = loginUserData.value.isEnableStore.getBoolInt().obs;

  bool isProfilePhoto;

  //Constructor endregion
  RxBool isLoading = false.obs;
  Rx<File> imageFile = File("").obs;
  XFile? pickedFile;
  RxString genderOption = GenderTypeConst.MALE.obs;
  TextEditingController fNameCont = TextEditingController();
  TextEditingController lNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController addressCont = TextEditingController();
  TextEditingController aboutSelfCont = TextEditingController();
  TextEditingController expertCont = TextEditingController();
  TextEditingController facebookLinkCont = TextEditingController();
  TextEditingController instagramLinkCont = TextEditingController();
  TextEditingController twitterLinkCont = TextEditingController();
  TextEditingController dribbbleLinkCont = TextEditingController();
  TextEditingController latitudeCont = TextEditingController();
  TextEditingController longitudeCont = TextEditingController();

  FocusNode fNameFocus = FocusNode();
  FocusNode lNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode aboutSelfFocus = FocusNode();
  FocusNode expertFocus = FocusNode();
  FocusNode facebookFocus = FocusNode();
  FocusNode instagramFocus = FocusNode();
  FocusNode twitterFocus = FocusNode();
  FocusNode dribbbleFocus = FocusNode();
  Rx<Country> selectedCountry = defaultCountry().obs;

  @override
  void onInit() {
    getViewProfile();
    init();
    super.onInit();
  }

  Future<void> init() async {
    fNameCont.text = loginUserData.value.firstName;
    lNameCont.text = loginUserData.value.lastName;
    mobileCont.text = loginUserData.value.mobile;
    emailCont.text = loginUserData.value.email;
    addressCont.text = loginUserData.value.address;
    latitudeCont.text = loginUserData.value.latitude;
    longitudeCont.text = loginUserData.value.longitude;
  }

  Future<void> updateUserProfile() async {
    if (!isProfilePhoto) {
      hideKeyBoardWithoutContext();
    }
    isLoading(true);

    AuthServiceApis.updateProfile(
      firstName: isProfilePhoto ? loginUserData.value.firstName : fNameCont.text.trim(),
      lastName: isProfilePhoto ? loginUserData.value.lastName : lNameCont.text.trim(),
      mobile: isProfilePhoto ? loginUserData.value.mobile : mobileCont.text.trim(),
      address: isProfilePhoto ? loginUserData.value.address : addressCont.text.trim(),
      aboutSelf: isProfilePhoto ? loginUserData.value.aboutSelf : aboutSelfCont.text.trim(),
      expert: isProfilePhoto ? loginUserData.value.expert : expertCont.text.trim(),
      gender: isProfilePhoto ? loginUserData.value.gender : genderOption.trim(),
      latitude: isProfilePhoto ? loginUserData.value.latitude : latitudeCont.text.trim(),
      longitude: isProfilePhoto ? loginUserData.value.longitude : longitudeCont.text.trim(),
      facebookLink: isProfilePhoto ? loginUserData.value.facebookLink : facebookLinkCont.text.trim(),
      instagramLink: isProfilePhoto ? loginUserData.value.instagramLink : instagramLinkCont.text.trim(),
      twitterLink: isProfilePhoto ? loginUserData.value.twitterLink : twitterLinkCont.text.trim(),
      dribbbleLink: isProfilePhoto ? loginUserData.value.dribbbleLink : dribbbleLinkCont.text.trim(),
      imageFile: imageFile.value.path.isNotEmpty ? imageFile.value : null,
      enableStore: isProfilePhoto
          ? loginUserData.value.isEnableStore.toString()
          : isShopEnable.value
              ? '1'
              : '0',
      onSuccess: (data) {
        isLoading(false);
        if (data != null) {
          if ((data as String).isJson()) {
            log("Response: ${jsonDecode(data)}");
            LoginResponse loginResponseModel = LoginResponse.fromJson(jsonDecode(data));
            loginUserData(UserData(
              id: loginUserData.value.id,
              firstName: loginResponseModel.userData.firstName,
              lastName: loginResponseModel.userData.lastName,
              userName: "${loginResponseModel.userData.firstName} ${loginResponseModel.userData.lastName}",
              mobile: loginResponseModel.userData.mobile,
              email: loginUserData.value.email,
              userRole: loginUserData.value.userRole,
              address: loginResponseModel.userData.address,
              aboutSelf: loginResponseModel.userData.aboutSelf,
              latitude: loginResponseModel.userData.latitude,
              longitude: loginResponseModel.userData.longitude,
              expert: loginResponseModel.userData.expert,
              facebookLink: loginResponseModel.userData.facebookLink,
              instagramLink: loginResponseModel.userData.instagramLink,
              twitterLink: loginResponseModel.userData.twitterLink,
              dribbbleLink: loginResponseModel.userData.dribbbleLink,
              gender: loginResponseModel.userData.gender,
              apiToken: loginUserData.value.apiToken,
              profileImage: loginResponseModel.userData.profileImage,
              loginType: loginUserData.value.loginType,
              isEnableStore: loginResponseModel.userData.isEnableStore,
            ));
            setValueToLocal(SharedPreferenceConst.USER_DATA, loginUserData.toJson());
            Get.back();
          }
        }
      },
    ).then((data) {
      toast(locale.value.profileUpdatedSuccessfully);
    }).catchError((e) {
      isLoading(false);
    });
  }

  void _getFromGallery() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile(File(pickedFile!.path));
      if (isProfilePhoto) {
        showConfirmDialogChoosePhoto();
      }
    }
  }

  getViewProfile() {
    AuthServiceApis.viewProfile().then((value) {
      isLoading(false);
      genderOption(value.data.gender.toLowerCase());
      latitudeCont.text = value.data.profile.latitude;
      longitudeCont.text = value.data.profile.longitude;
      aboutSelfCont.text = value.data.profile.aboutSelf;
      expertCont.text = value.data.profile.expert;
      facebookLinkCont.text = value.data.profile.facebookLink;
      instagramLinkCont.text = value.data.profile.instagramLink;
      twitterLinkCont.text = value.data.profile.twitterLink;
      dribbbleLinkCont.text = value.data.profile.dribbbleLink;
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile(File(pickedFile!.path));
      if (isProfilePhoto) {
        showConfirmDialogChoosePhoto();
      }
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
                _getFromGallery();
                finish(context);
              },
            ),
            SettingItemWidget(
              title: locale.value.camera,
              leading: const Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _getFromCamera();
                finish(context);
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

  void showMapOptionBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.value.chooseFromMap,
              leading: const Icon(Icons.maps_home_work_outlined, color: primaryColor),
              onTap: () async {
                handleSetLocationClick();
                Get.back();
              },
            ),
            SettingItemWidget(
              title: locale.value.useCurrentLocation,
              leading: const Icon(Icons.location_on_outlined, color: primaryColor),
              onTap: () {
                handleCurrentLocationClick();
                Get.back();
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

  void handleSetLocationClick() {
    Permissions.cameraFilesAndLocationPermissionsGranted().then((value) async {
      await setValue(PERMISSION_STATUS, value);
      if (value) {
        Get.to(() => MapScreen(address: addressCont.text, latitude: getDoubleAsync(LATITUDE), latLong: getDoubleAsync(LONGITUDE)))?.then((result) {
          try {
            latitudeCont.text = getDoubleAsync(LATITUDE).toString();
            longitudeCont.text = getDoubleAsync(LONGITUDE).toString();
            if (result.toString().trim().isNotEmpty) {
              addressCont.text = result.toString();
            }
          } catch (e) {
            log('handleSetLocationClick E: $e');
          }
        });
      }
    });
  }

  void handleCurrentLocationClick() {
    Permissions.cameraFilesAndLocationPermissionsGranted().then((value) async {
      await setValue(PERMISSION_STATUS, value);

      if (value) {
        isLoading(true);

        await getUserLocation().then((value) {
          addressCont.text = value;
          loginUserData.value.address = value.toString();
        }).catchError((e) {
          log("handleCurrentLocationClick $e");
          toast(e.toString());
        });

        isLoading(false);
      }
    }).catchError((e) {
      //
    });
  }

  void showConfirmDialogChoosePhoto() {
    showConfirmDialogCustom(
      getContext,
      primaryColor: primaryColor,
      negativeText: locale.value.cancel,
      positiveText: locale.value.yes,
      onAccept: (_) async {
        ifNotTester(() async {
          if (await isNetworkAvailable()) {
            updateUserProfile();
          } else {
            toast(locale.value.yourInternetIsNotWorking);
          }
        });
      },
      dialogType: DialogType.ACCEPT,
      customCenterWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(
            imageFile.value,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              decoration: boxDecorationDefault(shape: BoxShape.circle, color: primaryColor.withOpacity(0.4)),
              child: Text(
                "${loginUserData.value.firstName.firstLetter.toUpperCase()}${loginUserData.value.lastName.firstLetter.toUpperCase()}",
                style: const TextStyle(fontSize: 100 * 0.3, color: Colors.white),
              ),
            ),
          ).cornerRadiusWithClipRRect(45),
        ],
      ).paddingSymmetric(vertical: 16),
      title: locale.value.wouldYouLikeToSetProfilePhotoAsEmployee,
    );
  }

  Future<void> changeCountry() async {
    showCountryPicker(
      context: getContext,
      countryListTheme: CountryListThemeData(textStyle: secondaryTextStyle(color: textSecondaryColorGlobal)),
      showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country country) {
        selectedCountry(country);
      },
    );
  }
}
