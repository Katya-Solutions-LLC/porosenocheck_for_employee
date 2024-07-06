// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/screens/pet_store/pet_store_dashboard_screen.dart';
import 'package:porosenocheck_employee/screens/shop/orders/order_list/orders_controller.dart';
import '../screens/auth/model/app_configuration_res.dart';
import '../screens/auth/model/login_response.dart';
import 'auth/sign_in_sign_up/signin_screen.dart';
import '../utils/app_common.dart';
import '../utils/common_base.dart';
import '../utils/constants.dart';
import '../utils/local_storage.dart';
import 'auth/profile/profile_screen.dart';
import 'auth/services/auth_services.dart';
import 'booking_module/booking_list/bookings_controller.dart';
import 'home/dashboard_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onReady() {
    try {
      final getThemeFromLocal = getValueFromLocal(SettingsLocalConst.THEME_MODE);
      if (getThemeFromLocal is int) {
        toggleThemeMode(themeId: getThemeFromLocal);
      } else {
        toggleThemeMode(themeId: THEME_MODE_SYSTEM);
      }
      if (Get.context != null) {
        isDarkMode.value
            ? setStatusBarColor(scaffoldDarkColor, statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light)
            : setStatusBarColor(Get.context!.scaffoldBackgroundColor, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.light);
      }
    } catch (e) {
      log('getThemeFromLocal from cache E: $e');
    }

    super.onReady();
  }

  void init() {
    try {
      final configurationResFromLocal = getValueFromLocal(APICacheConst.APP_CONFIGURATION_RESPONSE);
      if (configurationResFromLocal != null) {
        appConfigs(ConfigurationResponse.fromJson(configurationResFromLocal));
        appCurrency(appConfigs.value.currency);
      }
    } catch (e) {
      log('configurationResFromLocal from cache E: $e');
    }
    getAppConfigurations();
  }
}

Rx<Future<ConfigurationResponse>> appConfigsFuture = Future(() => ConfigurationResponse(currency: Currency(), onesignalEmployeeApp: OnesignalEmployeeApp(), employeeAppUrl: EmployeeAppUrl(), zoom: ZoomConfig())).obs;
RxBool isLoading = false.obs;

///Get ChooseService List
getAppConfigurations() {
  appConfigsFuture(AuthServiceApis.getAppConfigurations()).then((value) {
    appCurrency(value.currency);
    appConfigs(value);

    /// Place ChatGPT Key Here
    chatGPTAPIkey = value.chatgptKey;
    
    setValueToLocal(APICacheConst.APP_CONFIGURATION_RESPONSE, value.toJson());

    ///Navigation logic
    if (getValueFromLocal(SharedPreferenceConst.IS_LOGGED_IN) == true) {
      try {
        final userData = getValueFromLocal(SharedPreferenceConst.USER_DATA);
        isLoggedIn(true);
        loginUserData.value = UserData.fromJson(userData);
        if (loginUserData.value.userRole.contains(EmployeeKeyConst.petSitter)) {
          Get.offAll(() => ProfileScreen());
        } else if (loginUserData.value.userRole.contains(EmployeeKeyConst.petStore)
            && (loginUserData.value.userType.contains(EmployeeKeyConst.petStore))) {
          Get.offAll(() => PetStoreDashboardScreen(), binding: BindingsBuilder(() {
            Get.put(OrderController());
          }));
        } else {
          Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
            Get.put(BookingsController());
          }));
        }
      } catch (e) {
        log('SplashScreenController Err: $e');

        Get.offAll(() => SignInScreen());
      }
    } else {
      Get.offAll(() => SignInScreen());
    }
  }).whenComplete(() => isLoading(false));
}
