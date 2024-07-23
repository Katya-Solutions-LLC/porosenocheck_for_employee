import 'package:get/get.dart';
import 'package:porosenocheckemployee/screens/auth/model/app_configuration_res.dart';

import '../configs.dart';
import '../screens/auth/model/login_response.dart';
import '../screens/home/model/about_page_res.dart';
import '../screens/home/model/pet_center_detail.dart';
import '../screens/home/model/status_list_res.dart';
import '../screens/shop/orders/model/order_status_model.dart';
import '../screens/shop/shop_product/model/product_discount_data_response.dart';
import 'constants.dart';

RxString selectedLanguageCode = DEFAULT_LANGUAGE.obs;
RxBool isLoggedIn = false.obs;
RxString playerId = "".obs;
Rx<UserData> loginUserData = UserData().obs;
RxBool isDarkMode = false.obs;
Rx<Currency> appCurrency = Currency().obs;
Rx<ConfigurationResponse> appConfigs = ConfigurationResponse(currency: Currency(), onesignalEmployeeApp: OnesignalEmployeeApp(), employeeAppUrl: EmployeeAppUrl(), zoom: ZoomConfig()).obs;

//DashBoard var

RxList<StatusModel> allStatus = RxList();
RxList<AboutDataModel> aboutPages = RxList();
Rx<PetCenterDetail> petCenterDetail = PetCenterDetail().obs;
RxList<OrderStatusData> allOrderStatus = RxList();

// Currency position common
bool get isCurrencyPositionLeft => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_LEFT;

bool get isCurrencyPositionRight => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_RIGHT;

bool get isCurrencyPositionLeftWithSpace => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_LEFT_WITH_SPACE;

bool get isCurrencyPositionRightWithSpace => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_RIGHT_WITH_SPACE;
//endregion

RxBool updateUi = false.obs;

String get getTopicName => APP_NAME.replaceAll(' ', '_');

String getUserRoleTopic(String userRole) {
  return userRole.toLowerCase().replaceAll(' ', '_');
}

List<ProductDiscountData> productDiscountTypes = [
  ProductDiscountData(id: 1, productDiscountName: "Percent(%)", productDiscountType: ProductDiscountTypes.PERCENT, isSelected: false),
  ProductDiscountData(id: 2, productDiscountName: "Fixed", productDiscountType: ProductDiscountTypes.FIXED, isSelected: false),
];
