// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/screens/auth/sign_in_sign_up/signin_screen.dart';
import 'package:porosenocheck_employee/screens/home/model/about_page_res.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../configs.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/local_storage.dart';
import '../../home/services/home_service_api.dart';
import '../services/auth_services.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    try {
      final aboutPageResFromLocal = getValueFromLocal(APICacheConst.ABOUT_RESPONSE);
      if (aboutPageResFromLocal != null) {
        aboutPages(AboutPageRes.fromJson(aboutPageResFromLocal).data);
      }
    } catch (e) {
      log('aboutPageResFromLocal from cache E: $e');
    }
    getAboutPageData();
  }

  handleLogout(BuildContext context) async {
    if (isLoading.value) return;
    showConfirmDialogCustom(
      primaryColor: primaryColor,
      context,
      negativeText: locale.value.cancel,
      positiveText: locale.value.logout,
      onAccept: (_) async {
        isLoading(true);
        log('HANDLELOGOUT: called');
        await AuthServiceApis.logoutApi().then((value) async {
          await AuthServiceApis.clearData();
          isLoading(false);
          Get.offAll(() => SignInScreen());
        }).catchError((e) {
          isLoading(false);
          toast(e.toString());
        });
      },
      dialogType: DialogType.CONFIRMATION,
      subTitle: locale.value.doYouWantToLogout,
      title: locale.value.ohNoYouAreLeaving,
    );
  }

  handleRate() async {
    if (isAndroid) {
      if (getStringAsync(APP_PLAY_STORE_URL).isNotEmpty) {
        commonLaunchUrl(getStringAsync(APP_PLAY_STORE_URL), launchMode: LaunchMode.externalApplication);
      } else {
        commonLaunchUrl('${getSocialMediaLink(LinkProvider.PLAY_STORE)}${await getPackageName()}', launchMode: LaunchMode.externalApplication);
      }
    } else if (isIOS) {
      if (getStringAsync(APP_APPSTORE_URL).isNotEmpty) {
        commonLaunchUrl(getStringAsync(APP_APPSTORE_URL), launchMode: LaunchMode.externalApplication);
      }
    }
  }

  ///Get ChooseService List
  getAboutPageData() {
    isLoading(true);
    HomeServiceApi.getAboutPageData().then((value) {
      isLoading(false);
      aboutPages(value.data);
      setValueToLocal(APICacheConst.ABOUT_RESPONSE, value.toJson());
    }).onError((error, stackTrace) {
      isLoading(false);
      toast(error.toString());
    });
  }
}
