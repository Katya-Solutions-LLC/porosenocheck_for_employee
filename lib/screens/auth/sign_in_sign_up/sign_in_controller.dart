// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/main.dart';
import 'package:porosenocheck_employee/screens/auth/model/login_response.dart';
import 'package:porosenocheck_employee/screens/auth/services/auth_services.dart';

import '../../../utils/app_common.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/local_storage.dart';
import '../../../utils/push_notification_service.dart';
import '../../booking_module/booking_list/bookings_controller.dart';
import '../../home/dashboard_screen.dart';
import '../../pet_store/pet_store_dashboard_screen.dart';
import '../../shop/orders/order_list/orders_controller.dart';
import '../model/demo_login_data_model.dart';
import '../profile/profile_screen.dart';
import '../services/social_logins.dart';

class SignInController extends GetxController {
  RxBool isRememberMe = true.obs;
  RxBool isLoading = false.obs;
  RxString userName = "".obs;
  Rx<DemoLoginData> selectedDemoUser = DemoLoginData().obs;

  TextEditingController emailCont = TextEditingController(text: Constants.DEFAULT_EMAIL);
  TextEditingController passwordCont = TextEditingController(text: Constants.DEFAULT_PASS);

  Rx<DemoLoginData> selectedUserTypeForLogin = DemoLoginData().obs;

  void toggleSwitch() {
    isRememberMe.value = !isRememberMe.value;
  }

  @override
  void onInit() {
    final userIsRememberMe = getValueFromLocal(SharedPreferenceConst.IS_REMEMBER_ME);
    final userNameFromLocal = getValueFromLocal(SharedPreferenceConst.USER_NAME);
    if (userNameFromLocal is String) {
      userName(userNameFromLocal);
    }
    if (userIsRememberMe == true) {
      final userEmail = getValueFromLocal(SharedPreferenceConst.USER_EMAIL);
      if (userEmail is String) {
        emailCont.text = userEmail;
      }
      final userPASSWORD = getValueFromLocal(SharedPreferenceConst.USER_PASSWORD);
      if (userPASSWORD is String) {
        passwordCont.text = userPASSWORD;
      }
    }
    super.onInit();
  }

  saveForm({String? userType}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      'email': emailCont.text.trim(),
      'password': passwordCont.text.trim(),
      'player_id': playerId.value,
      if ((userType ?? selectedUserTypeForLogin.value.userType).isNotEmpty) UserKeys.userType: userType ?? selectedUserTypeForLogin.value.userType,
    };

    await AuthServiceApis.loginUser(request: req).then((value) async {
      handleLoginResponse(loginResponse: value);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }

  void handleLoginResponse({required LoginResponse loginResponse, bool isSocialLogin = false}) {
    if (loginResponse.userData.userRole.contains(EmployeeKeyConst.veterinary) ||
        loginResponse.userData.userRole.contains(EmployeeKeyConst.walking) ||
        loginResponse.userData.userRole.contains(EmployeeKeyConst.boarding) ||
        loginResponse.userData.userRole.contains(EmployeeKeyConst.grooming) ||
        loginResponse.userData.userRole.contains(EmployeeKeyConst.training) ||
        loginResponse.userData.userRole.contains(EmployeeKeyConst.dayCare) ||
        loginResponse.userData.userRole.contains(EmployeeKeyConst.petSitter) ||
        loginResponse.userData.userRole.contains(EmployeeKeyConst.petStore)) {
      loginUserData(loginResponse.userData);
      loginUserData.value.isSocialLogin = isSocialLogin;
      setValueToLocal(SharedPreferenceConst.USER_DATA, loginUserData.toJson());
      setValueToLocal(SharedPreferenceConst.USER_PASSWORD, isSocialLogin ? "" : passwordCont.text.trim());
      isLoggedIn(true);
      setValueToLocal(SharedPreferenceConst.IS_LOGGED_IN, true);
      setValueToLocal(SharedPreferenceConst.IS_REMEMBER_ME, isRememberMe.value);

      isLoading(false);

      PushNotificationService().registerFCMAndTopics();

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
    } else {
      isLoading(false);
      toast(locale.value.sorryUserCannotSignin);
    }
  }

  googleSignIn() async {
    isLoading(true);
    await GoogleSignInAuthService.signInWithGoogle().then((value) async {
      Map request = {
        UserKeys.contactNumber: value.mobile,
        UserKeys.email: value.email,
        UserKeys.firstName: value.firstName,
        UserKeys.lastName: value.lastName,
        UserKeys.playerId: playerId.value,
        UserKeys.userType: selectedUserTypeForLogin.value.userType,
        UserKeys.username: value.userName,
        UserKeys.profileImage: value.profileImage,
        UserKeys.loginType: LoginTypeConst.LOGIN_TYPE_GOOGLE,
      };
      log('signInWithGoogle REQUEST: $request');

      /// Social Login Api
      await AuthServiceApis.loginUser(request: request, isSocialLogin: true).then((value) async {
        handleLoginResponse(loginResponse: value, isSocialLogin: true);
      }).catchError((e) {
        isLoading(false);
        toast(e.toString(), print: true);
      });
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  appleSignIn() async {
    isLoading(true);
    await GoogleSignInAuthService.signInWithApple().then((value) async {
      Map request = {
        UserKeys.contactNumber: value.mobile,
        UserKeys.email: value.email,
        UserKeys.firstName: value.firstName,
        UserKeys.lastName: value.lastName,
        UserKeys.playerId: playerId.value,
        UserKeys.userType: selectedUserTypeForLogin.value.userType,
        UserKeys.username: value.userName,
        UserKeys.profileImage: value.profileImage,
        UserKeys.loginType: LoginTypeConst.LOGIN_TYPE_APPLE,
      };

      log('signInWithGoogle REQUEST: $request');

      /// Social Login Api
      await AuthServiceApis.loginUser(request: request, isSocialLogin: true).then((value) async {
        handleLoginResponse(loginResponse: value, isSocialLogin: true);
      }).catchError((e) {
        isLoading(false);
        toast(e.toString(), print: true);
      });
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }
}
