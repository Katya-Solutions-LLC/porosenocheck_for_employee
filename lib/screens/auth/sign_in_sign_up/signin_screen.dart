import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import 'package:porosenocheckemployee/configs.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/screens/auth/password/forget_password_screen.dart';
import 'package:porosenocheckemployee/screens/auth/sign_in_sign_up/sign_in_controller.dart';

import '../../../components/app_logo_widget.dart';
import '../../../components/app_scaffold.dart';
import '../../../components/bottom_selection_widget.dart';
import '../../../components/cached_image_widget.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../model/demo_login_data_model.dart';
import 'signup_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final SignInController signInController = Get.put(SignInController());
  final GlobalKey<FormState> _signInformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      isLoading: signInController.isLoading,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    isDarkMode.value ? Assets.imagesLogoDark : Assets.imagesLogo,
                    height: Constants.appLogoSize,
                    width: Constants.appLogoSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const AppLogoWidget(),
                  ).paddingTop(46),
                  Text(
                    '${locale.value.hello} ${locale.value.guest}!',
                    style: primaryTextStyle(size: 24),
                  ).paddingTop(8),
                  Text(
                    signInController.userName.value.isNotEmpty ? '${locale.value.welcomeBackToThe} $APP_NAME' : '${locale.value.welcomeToThe} $APP_NAME',
                    style: secondaryTextStyle(size: 14),
                  ).paddingTop(8),
                  Form(
                    key: _signInformKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => AppTextField(
                            title: locale.value.email,
                            controller: signInController.emailCont,
                            textFieldType: TextFieldType.EMAIL,
                            decoration: inputDecoration(
                              context,
                              fillColor: context.cardColor,
                              filled: true,
                              hintText: "${locale.value.eG} merry_456@gmail.com",
                            ),
                            suffix: Assets.iconsIcMail.iconImage(fit: BoxFit.contain).paddingAll(14),
                          ),
                        ),
                        Obx(
                          () => AppTextField(
                            title: locale.value.password,
                            controller: signInController.passwordCont,
                            // Optional
                            textFieldType: TextFieldType.PASSWORD,
                            decoration: inputDecoration(
                              context,
                              fillColor: context.cardColor,
                              filled: true,
                              hintText: "••••••••",
                            ),
                            suffixPasswordVisibleWidget: commonLeadingWid(imgPath: Assets.iconsIcEye, icon: Icons.password_outlined, size: 14).paddingAll(12),
                            suffixPasswordInvisibleWidget: commonLeadingWid(imgPath: Assets.iconsIcEyeSlash, icon: Icons.password_outlined, size: 14).paddingAll(12),
                          ),
                        ).paddingTop(16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: signInController.toggleSwitch,
                                borderRadius: radius(),
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.75,
                                      child: Switch(
                                        activeTrackColor: switchActiveTrackColor,
                                        value: signInController.isRememberMe.value,
                                        activeColor: switchActiveColor,
                                        inactiveTrackColor: switchColor.withOpacity(0.2),
                                        onChanged: (bool value) {
                                          signInController.toggleSwitch();
                                        },
                                      ),
                                    ),
                                    Text(
                                      locale.value.rememberMe,
                                      style: secondaryTextStyle(color: darkGrayGeneral),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => ForgetPassword());
                              },
                              child: Text(
                                locale.value.forgotPassword,
                                style: primaryTextStyle(
                                  size: 12,
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                  decorationColor: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ).paddingTop(8),
                        AppButton(
                          width: Get.width,
                          text: locale.value.signIn,
                          textStyle: appButtonTextStyleWhite,
                          onTap: () {
                            if (_signInformKey.currentState!.validate()) {
                              _signInformKey.currentState!.save();
                              signInController.saveForm();
                            }
                          },
                        ).paddingTop(32),
                      ],
                    ),
                  ).paddingTop(42),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(locale.value.notRegistered, style: secondaryTextStyle()),
                      4.width,
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {
                          Get.to(() => SignUpScreen());
                        },
                        child: Text(
                          locale.value.registerNow,
                          style: primaryTextStyle(
                            size: 12,
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ).paddingSymmetric(horizontal: 8),
                      ),
                    ],
                  ).paddingTop(8),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      chooseEmployeeType(
                        context,
                        isLoading: signInController.isLoading,
                        isFromDemoAccountTap: true,
                        onChange: (p0) {
                          signInController.selectedDemoUser(p0);
                          signInController.emailCont.text = signInController.selectedDemoUser.value.email;
                          signInController.passwordCont.text = signInController.selectedDemoUser.value.password;
                        },
                      );
                    },
                    child: Text(
                      locale.value.demoAccounts,
                      style: primaryTextStyle(
                        size: 12,
                        color: primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                      ),
                    ).paddingSymmetric(horizontal: 8),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: const Divider(
                          color: borderColor,
                        ),
                      ).expand(),
                      Text(locale.value.orSignInWith, style: primaryTextStyle(color: secondaryTextColor, size: 14)).paddingSymmetric(horizontal: 20),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: const Divider(
                          color: borderColor,
                        ),
                      ).expand(),
                    ],
                  ).paddingTop(8),
                  AppButton(
                    width: Get.width,
                    color: context.cardColor,
                    text: "",
                    textStyle: appButtonFontColorText,
                    onTap: () {
                      chooseEmployeeType(
                        context,
                        isLoading: signInController.isLoading,
                        onChange: (p0) {
                          signInController.selectedUserTypeForLogin(p0);
                          signInController.googleSignIn();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesGoogleLogo,
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata_rounded),
                        ),
                        8.width,
                        Text(
                          locale.value.signInWithGoogle,
                          style: primaryTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 16, bottom: 16),
                  AppButton(
                    width: Get.width,
                    color: context.cardColor,
                    text: "",
                    textStyle: appButtonFontColorText,
                    onTap: () {
                      chooseEmployeeType(
                        context,
                        isLoading: signInController.isLoading,
                        onChange: (p0) {
                          signInController.selectedUserTypeForLogin(p0);
                          signInController.appleSignIn();
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.imagesAppleLogo,
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata_rounded),
                        ),
                        8.width,
                        Text(
                          locale.value.signInWithApple,
                          style: primaryTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 16).visible(isApple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void chooseEmployeeType(BuildContext context, {RxBool? isLoading, required Function(DemoLoginData) onChange, bool isFromDemoAccountTap = false}) {
  return serviceCommonBottomSheet(
    context,
    child: Obx(
      () => BottomSelectionSheet(
        heightRatio: 0.68,
        title: isFromDemoAccountTap ? locale.value.demoAccounts : locale.value.selectUserType,
        hideSearchBar: true,
        hintText: locale.value.searchForStatus,
        controller: TextEditingController(),
        hasError: false,
        isLoading: isLoading,
        isEmpty: demoUsers.isEmpty,
        noDataTitle: locale.value.statusListIsEmpty,
        noDataSubTitle: locale.value.thereAreNoStatus,
        listWidget: ListView.separated(
          itemCount: demoUsers.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SettingItemWidget(
              title: demoUsers[index].serviceName,
              titleTextStyle: primaryTextStyle(size: 14),
              leading: CachedImageWidget(url: demoUsers[index].icon, color: index.isEven ? primaryColor : secondaryColor, height: 22, fit: BoxFit.cover, width: 22),
              onTap: () {
                onChange(demoUsers[index]);
                Get.back();
              },
            );
          },
          separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
        ).expand(),
      ),
    ),
  );
}
