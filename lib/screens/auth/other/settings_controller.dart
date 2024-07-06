import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../configs.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/local_storage.dart';
import '../services/auth_services.dart';
import '../sign_in_sign_up/signin_screen.dart';

class SettingsController extends GetxController {
  RxBool isDark = false.obs;
  RxBool isLoading = false.obs;
  Rx<LanguageDataModel> selectedLang = LanguageDataModel().obs;

  List<ThemeModeData> themeModes = [ThemeModeData(id: THEME_MODE_SYSTEM, mode: "System"), ThemeModeData(id: THEME_MODE_LIGHT, mode: "Light"), ThemeModeData(id: THEME_MODE_DARK, mode: "Dark")];
  Rx<ThemeModeData> dropdownValue = ThemeModeData().obs;
  void toggleDarkLightSwitch() {
    isDark.value = !isDark.value;
    setValueToLocal(SettingsLocalConst.THEME_MODE, isDark.value);
    log('toggleDarkLightSwitch: $isDark');
    if (isDark.value) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = Colors.white70;
    } else {
      textPrimaryColorGlobal = primaryTextColor;
      textSecondaryColorGlobal = secondaryTextColor;
    }

    Get.changeThemeMode(
      isDark.value ? ThemeMode.dark : ThemeMode.light,
    );
    updateUi(true);
    updateUi(false);
  }

  void handleDeleteAccountClick() {
    ifNotTester(() {
      isLoading(true);
      AuthServiceApis.deleteAccountCompletely().then((value) async {
        AuthServiceApis.clearData(isFromDeleteAcc: true);
        isLoading(false);
        toast(value.message);
        Get.offAll(() => SignInScreen());
      }).catchError((e) {
        isLoading(false);
        toast(e.toString());
      });
    });
  }

  @override
  void onReady() {
    try {
      final getThemFromLocal = getValueFromLocal(SettingsLocalConst.THEME_MODE);
      if (getThemFromLocal is int) {
        dropdownValue(themeModes.firstWhere(
          (element) => element.id == getThemFromLocal,
          orElse: () => ThemeModeData(),
        ));
        toggleThemeMode(themeId: getThemFromLocal);
      }
    } catch (e) {
      log('getThemFromLocal from cache E: $e');
    }
    if (localeLanguageList.isNotEmpty) {
      selectedLanguageCode(getValueFromLocal(SELECTED_LANGUAGE_CODE) ?? DEFAULT_LANGUAGE);
      selectedLang(localeLanguageList.firstWhere(
        (element) => element.languageCode == selectedLanguageCode.value,
        orElse: () => LanguageDataModel(id: -1),
      ));
    }
    log('ISDARK: $isDark');

    super.onReady();
  }
}

class ThemeModeData {
  int id;
  String mode;

  ThemeModeData({
    this.id = -1,
    this.mode = "",
  });

  factory ThemeModeData.fromJson(Map<String, dynamic> json) {
    return ThemeModeData(
      id: json['id'] is int ? json['id'] : -1,
      mode: json['mode'] is String ? json['mode'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mode': mode,
    };
  }
}
