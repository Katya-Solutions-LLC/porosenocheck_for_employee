import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/auth/review/employee_review_controller.dart';
import 'package:porosenocheckemployee/screens/home/model/pet_center_detail.dart';

import '../../utils/app_common.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import '../../utils/local_storage.dart';
import '../auth/profile/profile_controller.dart';
import '../auth/profile/profile_screen.dart';
import '../auth/review/employee_review_screen.dart';
import '../auth/services/auth_services.dart';
import '../booking_module/booking_list/bookings_screen.dart';
import 'home_controller.dart';
import 'home_screen.dart';
import 'model/status_list_res.dart';
import 'services/home_service_api.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLoading = false.obs;

  List screen = [
    HomeScreen(),
    BookingScreen(),
    EmployeeReviewScreen(),
    ProfileScreen(),
  ];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.context != null) {
      View.of(Get.context!).platformDispatcher.onPlatformBrightnessChanged = () {
        WidgetsBinding.instance.handlePlatformBrightnessChanged();
        try {
          final getThemeFromLocal = getValueFromLocal(SettingsLocalConst.THEME_MODE);
          if (getThemeFromLocal is int) {
            toggleThemeMode(themeId: getThemeFromLocal);
          }
        } catch (e) {
          log('getThemeFromLocal from cache E: $e');
        }
      };
    }
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.context != null) {
        showForceUpdateDialog(Get.context!);
      }
    });
    super.onReady();
  }

  void init() {
    try {
      final statusListResFromLocal = getValueFromLocal(APICacheConst.STATUS_RESPONSE);
      if (statusListResFromLocal != null) {
        allStatus(StatusListRes.fromJson(statusListResFromLocal).data);
      }
    } catch (e) {
      log('statusListResFromLocal from cache E: $e');
    }
    try {
      final petCenterResFromLocal = getValueFromLocal(APICacheConst.PET_CENTER_RESPONSE);
      if (petCenterResFromLocal != null) {
        petCenterDetail(PetCenterRes.fromJson(petCenterResFromLocal).data);
      }
    } catch (e) {
      log('petCenterResFromLocal from cache E: $e');
    }
    getAllStatusUsedForBooking();
    getPetCenterDetail();
    getAppConfigurations(isFromDashboard: true);
  }

  ///Get Booking Status List
  getAllStatusUsedForBooking() {
    isLoading(true);
    HomeServiceApi.getAllStatusUsedForBooking().then((value) {
      isLoading(false);
      allStatus(value.data);
      setValueToLocal(APICacheConst.STATUS_RESPONSE, value.toJson());
    }).onError((error, stackTrace) {
      isLoading(false);
      log('getAllStatusUsedForBooking  E: $error');
    });
  }

  getPetCenterDetail() {
    isLoading(true);
    AuthServiceApis.getPetCenterDetail().then((value) {
      isLoading(false);
      petCenterDetail(value.data);
      setValueToLocal(APICacheConst.PET_CENTER_RESPONSE, value.toJson());
    }).onError((error, stackTrace) {
      isLoading(false);
      log('getPetCenterDetail  E: $error');
    });
  }
}

///Get App Configuration List
getAppConfigurations({bool isFromDashboard = false}) {
  AuthServiceApis.getAppConfigurations().then((value) async {
    appCurrency(value.currency);
    appConfigs(value);

    /// Place ChatGPT Key Here
    chatGPTAPIkey = value.chatgptKey;
    if (getValueFromLocal(SharedPreferenceConst.IS_LOGGED_IN) == true && appConfigs.value.isUserPushNotification && isFromDashboard) {
      await Future.delayed(const Duration(seconds: 1));
    }
    setValueToLocal(APICacheConst.APP_CONFIGURATION_RESPONSE, value.toJson());
  }).onError((error, stackTrace) {
    log('getAppConfigurations  E: $error');
  });
}

void bottomNavigateByIndex(int index) {
  try {
    final DashboardController dashboardController = Get.find();
    if (!index.isNegative && index < dashboardController.screen.length) {
      dashboardController.currentIndex(index);
      try {
        if (index == 0) {
          HomeController hCont = Get.find();

          hCont.init();
        } else if (index == 2) {
          EmployeeReviewController rCont = Get.find();
          rCont.init();
        } else {
          ProfileController pCont = Get.find();
          pCont.getAboutPageData();
        }
      } catch (e) {
        log('onItemSelected Err: $e');
      }
    }
  } catch (e) {
    log('dashboardController = Get.find E: $e');
  }
}
