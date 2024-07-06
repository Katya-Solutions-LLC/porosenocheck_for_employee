import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/chat_gpt_loder.dart';
import '../../../components/common_profile_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import 'edit_user_profile_controller.dart';

class EditUserProfileScreen extends StatelessWidget {
  EditUserProfileScreen({super.key});

  final EditUserProfileController editUserProfileController = Get.put(EditUserProfileController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        appBartitleText: locale.value.editProfile,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    Obx(() => ProfilePicWidget(
                          heroTag: editUserProfileController.imageFile.value.path.isNotEmpty
                              ? editUserProfileController.imageFile.value.path
                              : loginUserData.value.profileImage.isNotEmpty
                                  ? loginUserData.value.profileImage
                                  : loginUserData.value.profileImage,
                          profileImage: editUserProfileController.imageFile.value.path.isNotEmpty
                              ? editUserProfileController.imageFile.value.path
                              : loginUserData.value.profileImage.isNotEmpty
                                  ? loginUserData.value.profileImage
                                  : loginUserData.value.profileImage,
                          firstName: loginUserData.value.firstName,
                          lastName: loginUserData.value.lastName,
                          userName: loginUserData.value.userName,
                          showBgCurves: false,
                          showOnlyPhoto: true,
                          onCameraTap: () {
                            editUserProfileController.showBottomSheet(context);
                          },
                          onPicTap: () {
                            editUserProfileController.showBottomSheet(context);
                          },
                        )),
                    32.height,
                    AppTextField(
                      title: locale.value.firstName,
                      controller: editUserProfileController.fNameCont,
                      focus: editUserProfileController.fNameFocus,
                      nextFocus: editUserProfileController.lNameFocus,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  ${locale.value.merry}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                      suffix: Assets.profileIconsIcUserOutlined.iconImage(fit: BoxFit.contain).paddingAll(14),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.lastName,
                      controller: editUserProfileController.lNameCont,
                      focus: editUserProfileController.lNameFocus,
                      nextFocus: editUserProfileController.emailFocus,
                      textFieldType: TextFieldType.USERNAME,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  ${locale.value.doe}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                      suffix: Assets.profileIconsIcUserOutlined.iconImage(fit: BoxFit.contain).paddingAll(14),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.email,
                      controller: editUserProfileController.emailCont,
                      focus: editUserProfileController.emailFocus,
                      nextFocus: editUserProfileController.mobileFocus,
                      textFieldType: TextFieldType.EMAIL,
                      readOnly: true,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} merry_456@gmail.com",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                      suffix: Assets.iconsIcMail.iconImage(fit: BoxFit.contain).paddingAll(14),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.contactNumber,
                      textFieldType: TextFieldType.PHONE,
                      controller: editUserProfileController.mobileCont,
                      focus: editUserProfileController.mobileFocus,
                      errorThisFieldRequired: locale.value.thisFieldIsRequired,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  1-2188219848",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    genderWidget(context),
                    16.height,
                    AppTextField(
                      isValidationRequired: false,
                      title: locale.value.address,
                      readOnly: true,
                      textFieldType: TextFieldType.MULTILINE,
                      controller: editUserProfileController.addressCont,
                      focus: editUserProfileController.addressFocus,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} 123 ${locale.value.mainStreet}",
                        fillColor: context.cardColor,
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              editUserProfileController.handleCurrentLocationClick();
                            },
                            icon: Assets.iconsIcAddress.iconImage(size: 20).paddingAll(14)),
                      ),
                      onTap: () {
                        hideKeyboard(context);
                        editUserProfileController.showMapOptionBottomSheet(context);
                      },
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      isValidationRequired: false,
                      title: locale.value.aboutSelf,
                      textFieldType: TextFieldType.MULTILINE,
                      controller: editUserProfileController.aboutSelfCont,
                      focus: editUserProfileController.aboutSelfFocus,
                      enableChatGPT: appConfigs.value.enableChatGpt,
                      promptFieldInputDecorationChatGPT: inputDecoration(context, hintText: locale.value.writeHere, fillColor: context.scaffoldBackgroundColor, filled: true),
                      testWithoutKeyChatGPT: appConfigs.value.testWithoutKey,
                      loaderWidgetForChatGPT: const ChatGPTLoadingWidget(),
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} ${locale.value.passionateAndAttentivePet}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      isValidationRequired: false,
                      title: locale.value.expert,
                      textFieldType: TextFieldType.NAME,
                      controller: editUserProfileController.expertCont,
                      focus: editUserProfileController.expertFocus,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  ${locale.value.firstAidKnowledgeForPets}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.facebookLink,
                      isValidationRequired: false,
                      textFieldType: TextFieldType.URL,
                      controller: editUserProfileController.facebookLinkCont,
                      focus: editUserProfileController.facebookFocus,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} https://www.facebook.com",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.instagramLink,
                      isValidationRequired: false,
                      textFieldType: TextFieldType.URL,
                      controller: editUserProfileController.instagramLinkCont,
                      focus: editUserProfileController.instagramFocus,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} https://www.instagram.com",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.twitterLink,
                      isValidationRequired: false,
                      textFieldType: TextFieldType.URL,
                      controller: editUserProfileController.twitterLinkCont,
                      focus: editUserProfileController.twitterFocus,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  https://www.twitter.com",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.dribbbleLink,
                      isValidationRequired: false,
                      textFieldType: TextFieldType.URL,
                      controller: editUserProfileController.dribbbleLinkCont,
                      focus: editUserProfileController.dribbbleFocus,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} https://www.instagram.com",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    if (!loginUserData.value.userType.contains(EmployeeKeyConst.petSitter))
                      Obx(
                        () => Row(
                          children: [
                            Text(locale.value.enableShop, style: primaryTextStyle()).expand(),
                            Switch.adaptive(
                              value: editUserProfileController.isShopEnable.value,
                              activeColor: context.primaryColor,
                              inactiveTrackColor: context.primaryColor.withOpacity(0.2),
                              inactiveThumbColor: context.primaryColor.withOpacity(0.5),
                              onChanged: (val) {
                                editUserProfileController.isShopEnable.value = !editUserProfileController.isShopEnable.value;
                              },
                            )
                          ],
                        ).paddingSymmetric(horizontal: 16).visible(appConfigs.value.isMultiVendorEnable.getBoolInt() && (!(loginUserData.value.userType.contains(EmployeeKeyConst.petStore)) || !(loginUserData.value.userRole.contains(EmployeeKeyConst.petStore)))),
                      ),
                    32.height,
                    AppButton(
                      width: Get.width,
                      text: locale.value.update,
                      textStyle: appButtonTextStyleWhite,
                      onTap: () async {
                        /*ifNotTester(() async {
                          if (await isNetworkAvailable()) {
                            editUserProfileController.updateUserProfile();
                          } else {
                            toast(locale.value.yourInternetIsNotWorking);
                          }
                        });*/

                        if (await isNetworkAvailable()) {
                          editUserProfileController.updateUserProfile();
                        } else {
                          toast(locale.value.yourInternetIsNotWorking);
                        }
                      },
                    ).paddingSymmetric(horizontal: 16),
                    24.height,
                  ],
                ),
              ),
            ),
            Obx(() => const LoaderWidget().visible(editUserProfileController.isLoading.value)),
          ],
        ),
      ),
    );
  }

  Widget genderWidget(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          Text(locale.value.gender, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
          8.height,
          Row(
            children: [
              SizedBox(
                width: Get.width,
                child: RadioListTile(
                  tileColor: context.cardColor,
                  shape: RoundedRectangleBorder(borderRadius: radius()),
                  fillColor: MaterialStateProperty.all(primaryColor),
                  title: Text(GenderTypeConst.FEMALE.capitalizeFirstLetter(), style: secondaryTextStyle()),
                  value: GenderTypeConst.FEMALE,
                  groupValue: editUserProfileController.genderOption.value,
                  onChanged: (value) {
                    editUserProfileController.genderOption(value.toString());
                  },
                ),
              ).expand(),
              16.width,
              SizedBox(
                width: Get.width,
                child: RadioListTile(
                  value: GenderTypeConst.MALE,
                  shape: RoundedRectangleBorder(borderRadius: radius()),
                  tileColor: context.cardColor,
                  fillColor: MaterialStateProperty.all(primaryColor),
                  title: Text(GenderTypeConst.MALE.capitalizeFirstLetter(), style: secondaryTextStyle()),
                  groupValue: editUserProfileController.genderOption.value,
                  onChanged: (value) {
                    editUserProfileController.genderOption(value.toString());
                  },
                ),
              ).expand(),
            ],
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }
}
