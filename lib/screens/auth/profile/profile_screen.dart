import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';
import 'package:porosenocheckemployee/screens/auth/other/pet_owners_screen_.dart';
import 'package:porosenocheckemployee/screens/auth/profile/profile_controller.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/common_profile_widget.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../add_services_forms/service_list_screen.dart';
import '../../shop/brand/brand_list/brand_list_screen.dart';
import '../../shop/orders/order_list/order_list_screen.dart';
import '../../shop/shop_product/shop_product_list/shop_product_list_screen.dart';
import '../../shop/units_tags/units_tags_list/units_tags_list_screen.dart';
import '../other/about_us_screen.dart';
import '../other/settings_screen.dart';
import 'edit_employee_profile.dart';
import 'edit_user_profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        hideAppBar: true,
        isLoading: profileController.isLoading,
        body: AnimatedScrollView(
          padding: const EdgeInsets.only(top: 39),
          children: [
            CommonAppBar(
              title: locale.value.profile,
              hasLeadingWidget: false,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => ProfilePicWidget(
                      heroTag: loginUserData.value.profileImage,
                      profileImage: loginUserData.value.profileImage,
                      firstName: loginUserData.value.firstName,
                      lastName: loginUserData.value.lastName,
                      userName: loginUserData.value.userName,
                      subInfo: loginUserData.value.email,
                      onCameraTap: () {
                        EditUserProfileController editUserProfileController = EditUserProfileController(isProfilePhoto: true);
                        editUserProfileController.showBottomSheet(context);
                      },
                    )),
                32.height,
                SettingItemWidget(
                  title: locale.value.myServices,
                  subTitle: locale.value.manageYourServices,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => ServiceListScreen());
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.iconsMyServices, icon: Icons.settings_outlined, color: primaryColor, size: 22),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.editProfile,
                  subTitle: locale.value.personalizeYourProfile,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => EditUserProfileScreen(), duration: const Duration(milliseconds: 800));
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.imagesIcEditprofileOutlined, icon: Icons.person_3_outlined, color: secondaryColor),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ),
                commonDivider,
                SettingItemWidget(
                  title: locale.value.petOwners,
                  subTitle: locale.value.manageNotesForPets,
                  splashColor: transparentColor,
                  onTap: () {
                    Get.to(() => PetOwnersScreen());
                  },
                  titleTextStyle: primaryTextStyle(),
                  leading: commonLeadingWid(imgPath: Assets.profileIconsIcUserOutlined, icon: Icons.settings_outlined, color: primaryColor, size: 22),
                  trailing: trailing,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                ).visible(!loginUserData.value.userRole.contains(EmployeeKeyConst.petStore)),
                if (!loginUserData.value.userRole.contains(EmployeeKeyConst.petSitter)) commonDivider,
                if ((loginUserData.value.userRole.contains(EmployeeKeyConst.petStore) && appConfigs.value.isMultiVendorEnable.getBoolInt()) || loginUserData.value.isEnableStore.getBoolInt()) ...[
                  SettingSection(
                    title: Text(locale.value.shop.toUpperCase(), style: boldTextStyle(color: primaryColor)),
                    headingDecoration: BoxDecoration(color: context.primaryColor.withOpacity(0.1)),
                    headerPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    divider: const Offstage(),
                    items: [
                      commonDivider,
                      SettingItemWidget(
                        title: locale.value.products,
                        subTitle: 'Manage shop products', //TODO: string
                        splashColor: transparentColor,
                        onTap: () {
                          Get.to(() => ShopProductListScreen(), duration: const Duration(milliseconds: 800));
                        },
                        titleTextStyle: primaryTextStyle(),
                        leading: commonLeadingWid(imgPath: Assets.serviceIconsIcPetStore, icon: Icons.settings_outlined, color: secondaryColor, size: 22),
                        trailing: trailing,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                      ),
                      if (!(loginUserData.value.userType.contains(EmployeeKeyConst.petStore))
                          || !(loginUserData.value.userRole.contains(EmployeeKeyConst.petStore))) commonDivider,
                      if (!(loginUserData.value.userType.contains(EmployeeKeyConst.petStore))
                          || !(loginUserData.value.userRole.contains(EmployeeKeyConst.petStore)))
                        SettingItemWidget(
                          title: locale.value.orders,
                          subTitle: 'Manage orders', //TODO: string
                          splashColor: transparentColor,
                          onTap: () {
                            Get.to(() => OrderListScreen(), duration: const Duration(milliseconds: 800));
                          },
                          titleTextStyle: primaryTextStyle(),
                          leading: commonLeadingWid(imgPath: Assets.navigationIcShopOutlined, icon: Icons.settings_outlined, color: primaryColor, size: 22),
                          trailing: trailing,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        ),
                      commonDivider,
                      SettingItemWidget(
                        title: locale.value.brands,
                        subTitle: 'Manage shop brands', //TODO: string
                        splashColor: transparentColor,
                        onTap: () {
                          Get.to(() => BrandListScreen(), duration: const Duration(milliseconds: 800));
                        },
                        titleTextStyle: primaryTextStyle(),
                        leading: commonLeadingWid(imgPath: Assets.profileIconsIcBrand, icon: Icons.settings_outlined, color: primaryColor, size: 22),
                        trailing: trailing,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                      ),
                      commonDivider,
                      SettingItemWidget(
                        title: locale.value.units,
                        subTitle: 'Manage shop units', //TODO: string
                        splashColor: transparentColor,
                        onTap: () {
                          Get.to(() => UnitsTagsScreen(), arguments: false, duration: const Duration(milliseconds: 800));
                        },
                        titleTextStyle: primaryTextStyle(),
                        leading: commonLeadingWid(imgPath: Assets.profileIconsIcShopUnit, icon: Icons.settings_outlined, color: secondaryColor, size: 22),
                        trailing: trailing,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                      ),
                      commonDivider,
                      SettingItemWidget(
                        title: locale.value.tags,
                        subTitle: 'Manage shop tags', //TODO: string
                        splashColor: transparentColor,
                        onTap: () {
                          Get.to(() => UnitsTagsScreen(), arguments: true, duration: const Duration(milliseconds: 800));
                        },
                        titleTextStyle: primaryTextStyle(),
                        leading: commonLeadingWid(imgPath: Assets.profileIconsIcShopTag, icon: Icons.settings_outlined, color: primaryColor, size: 22),
                        trailing: trailing,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                      ),
                    ],
                  ),
                ],
                SettingSection(
                  title: Text(locale.value.others.toUpperCase(), style: boldTextStyle(color: primaryColor)),
                  headingDecoration: BoxDecoration(color: context.primaryColor.withOpacity(0.1)),
                  headerPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  divider: const Offstage(),
                  items: [
                    SettingItemWidget(
                      title: locale.value.settings,
                      subTitle: "${locale.value.appLanguage}, ${locale.value.theme}, ${locale.value.deleteAccount}",
                      splashColor: transparentColor,
                      onTap: () {
                        Get.to(() => SettingScreen());
                      },
                      titleTextStyle: primaryTextStyle(),
                      leading: commonLeadingWid(imgPath: Assets.profileIconsIcSettingOutlined, icon: Icons.settings_outlined, color: primaryColor),
                      trailing: trailing,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    ),
                    commonDivider,
                    SettingItemWidget(
                      title: locale.value.rateApp,
                      subTitle: locale.value.showSomeLoveShare,
                      splashColor: transparentColor,
                      onTap: () {
                        handleRate();
                      },
                      titleTextStyle: primaryTextStyle(),
                      leading: commonLeadingWid(imgPath: Assets.profileIconsIcStarOutlined, icon: Icons.star_outline_rounded, color: secondaryColor),
                      trailing: trailing,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    ),
                    commonDivider,
                    SettingItemWidget(
                      title: locale.value.aboutApp,
                      subTitle: "${locale.value.privacyPolicy}, ${locale.value.termsConditions}",
                      splashColor: transparentColor,
                      onTap: () {
                        Get.to(() => const AboutScreen());
                      },
                      titleTextStyle: primaryTextStyle(),
                      leading: commonLeadingWid(imgPath: Assets.profileIconsIcInfoOutlined, icon: Icons.info_outline_rounded, color: primaryColor),
                      trailing: trailing,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    ),
                    commonDivider,
                    SettingItemWidget(
                      title: locale.value.logout,
                      subTitle: locale.value.securelyLogOutOfAccount,
                      splashColor: transparentColor,
                      onTap: () {
                        profileController.handleLogout(context);
                      },
                      titleTextStyle: primaryTextStyle(),
                      leading: commonLeadingWid(imgPath: Assets.profileIconsIcLogoutOutlined, icon: Icons.logout_outlined, color: secondaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    ),
                  ],
                ),
                30.height,
                SnapHelperWidget<PackageInfoData>(
                  future: getPackageInfo(),
                  onSuccess: (data) {
                    return VersionInfoWidget(prefixText: 'v', textStyle: primaryTextStyle()).center();
                  },
                ),
                32.height,
              ],
            ),
          ],
        ).visible(!updateUi.value),
      ),
    );
  }

  Widget get trailing => Icon(Icons.arrow_forward_ios, size: 12, color: darkGray.withOpacity(0.5));
}
