import '../../../configs.dart';
import '../../../utils/constants.dart';

class ConfigurationResponse {
  OnesignalEmployeeApp onesignalEmployeeApp;
  EmployeeAppUrl employeeAppUrl;
  Currency currency;
  int isForceUpdateEmployee;
  int isMultiVendorEnable;
  int employeeMinimumForceUpdateCode;
  int employeeLatestVersionUpdateCode;
  ZoomConfig zoom;
  String googleLoginStatus;
  String appleLoginStatus;
  String otpLoginStatus;
  dynamic siteDescription;
  String applicationLanguage;
  bool status;
  bool isUserPushNotification;
  bool enableChatGpt;
  bool testWithoutKey;
  String chatgptKey;

  ConfigurationResponse({
    required this.onesignalEmployeeApp,
    required this.employeeAppUrl,
    required this.currency,
    this.isForceUpdateEmployee = -1,
    this.employeeMinimumForceUpdateCode = -1,
    this.employeeLatestVersionUpdateCode = -1,
    required this.zoom,
    this.googleLoginStatus = "",
    this.appleLoginStatus = "",
    this.otpLoginStatus = "",
    this.siteDescription,
    this.applicationLanguage = DEFAULT_LANGUAGE,
    this.status = false,
    this.isUserPushNotification = false,
    this.enableChatGpt = false,
    this.testWithoutKey = false,
    this.chatgptKey = "",
    this.isMultiVendorEnable = 0,
  });

  factory ConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return ConfigurationResponse(
      onesignalEmployeeApp: json['onesignal_employee_app'] is Map ? OnesignalEmployeeApp.fromJson(json['onesignal_employee_app']) : OnesignalEmployeeApp(),
      employeeAppUrl: json['employee_app_url'] is Map ? EmployeeAppUrl.fromJson(json['employee_app_url']) : EmployeeAppUrl(),
      currency: json['currency'] is Map ? Currency.fromJson(json['currency']) : Currency(),
      isForceUpdateEmployee: json['isForceUpdateEmployee'] is int ? json['isForceUpdateEmployee'] : -1,
      employeeMinimumForceUpdateCode: json['employee_minimum_force_update_code'] is int ? json['employee_minimum_force_update_code'] : -1,
      employeeLatestVersionUpdateCode: json['employee_latest_version_update_code'] is int ? json['employee_latest_version_update_code'] : -1,
      zoom: json['zoom'] is Map ? ZoomConfig.fromJson(json['zoom']) : ZoomConfig(),
      googleLoginStatus: json['google_login_status'] is String ? json['google_login_status'] : "",
      appleLoginStatus: json['apple_login_status'] is String ? json['apple_login_status'] : "",
      otpLoginStatus: json['otp_login_status'] is String ? json['otp_login_status'] : "",
      siteDescription: json['site_description'],
      applicationLanguage: json['application_language'] is String ? json['application_language'] : DEFAULT_LANGUAGE,
      status: json['status'] is bool ? json['status'] : false,
      isUserPushNotification: json['is_user_push_notification'] == 1,
      enableChatGpt: json['enable_chat_gpt'] == 1,
      testWithoutKey: json['test_without_key'] == 1,
      isMultiVendorEnable: json['enable_multi_vendor'],
      chatgptKey: json['chatgpt_key'] is String ? json['chatgpt_key'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'onesignal_employee_app': onesignalEmployeeApp.toJson(),
      'employee_app_url': employeeAppUrl.toJson(),
      'currency': currency.toJson(),
      'isForceUpdateEmployee': isForceUpdateEmployee,
      'employee_minimum_force_update_code': employeeMinimumForceUpdateCode,
      'employee_latest_version_update_code': employeeLatestVersionUpdateCode,
      'zoom': zoom.toJson(),
      'google_login_status': googleLoginStatus,
      'apple_login_status': appleLoginStatus,
      'otp_login_status': otpLoginStatus,
      'site_description': siteDescription,
      'application_language': applicationLanguage,
      'status': status,
      'is_user_push_notification': isUserPushNotification,
      'enable_chat_gpt': enableChatGpt,
      'test_without_key': testWithoutKey,
      'chatgpt_key': chatgptKey,
      'enable_multi_vendor': isMultiVendorEnable,
    };
  }
}

class OnesignalEmployeeApp {
  String employeeOnesignalAppId;
  String employeeOnesignalRestApiKey;
  String employeeOnesignalChannelId;

  OnesignalEmployeeApp({
    this.employeeOnesignalAppId = "",
    this.employeeOnesignalRestApiKey = "",
    this.employeeOnesignalChannelId = "",
  });

  factory OnesignalEmployeeApp.fromJson(Map<String, dynamic> json) {
    return OnesignalEmployeeApp(
      employeeOnesignalAppId: json['employee_onesignal_app_id'] is String ? json['employee_onesignal_app_id'] : "",
      employeeOnesignalRestApiKey: json['employee_onesignal_rest_api_key'] is String ? json['employee_onesignal_rest_api_key'] : "",
      employeeOnesignalChannelId: json['employee_onesignal_channel_id'] is String ? json['employee_onesignal_channel_id'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_onesignal_app_id': employeeOnesignalAppId,
      'employee_onesignal_rest_api_key': employeeOnesignalRestApiKey,
      'employee_onesignal_channel_id': employeeOnesignalChannelId,
    };
  }
}

class EmployeeAppUrl {
  String employeeAppPlayStore;
  String employeeAppAppStore;

  EmployeeAppUrl({
    this.employeeAppPlayStore = "",
    this.employeeAppAppStore = "",
  });

  factory EmployeeAppUrl.fromJson(Map<String, dynamic> json) {
    return EmployeeAppUrl(
      employeeAppPlayStore: json['employee_app_play_store'] is String ? json['employee_app_play_store'] : "",
      employeeAppAppStore: json['employee_app_app_store'] is String ? json['employee_app_app_store'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employee_app_play_store': employeeAppPlayStore,
      'employee_app_app_store': employeeAppAppStore,
    };
  }
}

class Currency {
  String currencyName;
  String currencySymbol;
  String currencyCode;
  String currencyPosition;
  int noOfDecimal;
  String thousandSeparator;
  String decimalSeparator;

  Currency({
    this.currencyName = "Doller",
    this.currencySymbol = "\$",
    this.currencyCode = "USD",
    this.currencyPosition = CurrencyPosition.CURRENCY_POSITION_LEFT,
    this.noOfDecimal = 2,
    this.thousandSeparator = ",",
    this.decimalSeparator = ".",
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      currencyName: json['currency_name'] is String ? json['currency_name'] : "Doller",
      currencySymbol: json['currency_symbol'] is String ? json['currency_symbol'] : "\$",
      currencyCode: json['currency_code'] is String ? json['currency_code'] : "USD",
      currencyPosition: json['currency_position'] is String ? json['currency_position'] : "left",
      noOfDecimal: json['no_of_decimal'] is int ? json['no_of_decimal'] : 2,
      thousandSeparator: json['thousand_separator'] is String ? json['thousand_separator'] : ",",
      decimalSeparator: json['decimal_separator'] is String ? json['decimal_separator'] : ".",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency_name': currencyName,
      'currency_symbol': currencySymbol,
      'currency_code': currencyCode,
      'currency_position': currencyPosition,
      'no_of_decimal': noOfDecimal,
      'thousand_separator': thousandSeparator,
      'decimal_separator': decimalSeparator,
    };
  }
}

class ZoomConfig {
  String accountId;
  String clientId;
  String clientSecret;

  ZoomConfig({
    this.accountId = "",
    this.clientId = "",
    this.clientSecret = "",
  });

  factory ZoomConfig.fromJson(Map<String, dynamic> json) {
    return ZoomConfig(
      accountId: json['account_id'] is String ? json['account_id'] : "",
      clientId: json['client_id'] is String ? json['client_id'] : "",
      clientSecret: json['client_secret'] is String ? json['client_secret'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'client_id': clientId,
      'client_secret': clientSecret,
    };
  }
}
