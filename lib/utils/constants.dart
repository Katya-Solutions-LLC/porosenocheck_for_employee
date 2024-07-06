// ignore_for_file: constant_identifier_names

import 'package:country_picker/country_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';

import '../generated/assets.dart';
import '../screens/auth/model/demo_login_data_model.dart';

class Constants {
  static const perPageItem = 20;
  static var labelTextSize = 16;
  static var mailTo = 'mailto:';
  static var tel = 'tel:';
  static var googleMapPrefix = 'https://www.google.com/maps/search/?api=1&query=';
  static var message = 'message';
  static const DEFAULT_EMAIL = 'felix@gmail.com';
  static const DEFAULT_PASS = '12345678';
  static const appLogoSize = 130.0;
  static const DECIMAL_POINT = 2;
}

//region DateFormats
class DateFormatConst {
  static const DD_MM_YY = "dd-MM-yy"; //TODO Use to show only in UI
  static const MMMM_D_yyyy = "MMMM d, y"; //TODO Use to show only in UI
  static const D_MMMM_yyyy = "d MMMM,y"; //TODO Use to show only in UI
  static const D_MMM_yyyy = "d MMM y"; //TODO Use to show only in UI
  static const MMMM_D_yyyy_At_HH_mm_a = "MMMM d, y @ hh:mm a"; //TODO Use to show only in UI
  static const EEEE_D_MMMM_At_HH_mm_a = "EEEE d MMMM @ hh:mm a"; //TODO Use to show only in UI
  static const dd_MMM_yyyy_HH_mm_a = "dd MMM y, hh:mm a"; //TODO Use to show only in UI
  static const yyyy_MM_dd_HH_mm = 'yyyy-MM-dd HH:mm';
  static const yyyy_MM_dd = 'yyyy-MM-dd';
  static const HH_mm12Hour = 'hh:mm a';
  static const HH_mm24Hour = 'HH:mm';
  static const DATE_FORMAT_1 = 'dd-MMM-yyyy hh:mm a';
}
//endregion

//region THEME MODE TYPE
const THEME_MODE_LIGHT = 0;
const THEME_MODE_DARK = 1;
const THEME_MODE_SYSTEM = 2;
//endregion

const PER_PAGE_ALL = 'all';
const APP_BAR_TEXT_SIZE = 18;

//region CONFIGURATION KEYS
class ConfigurationKeyConst {
  static const CURRENCY_COUNTRY_CODE = 'CURRENCY_COUNTRY_CODE';
  static const CURRENCY_COUNTRY_ID = 'CURRENCY_COUNTRY_ID';
  static const CURRENCY_COUNTRY_SYMBOL = 'CURRENCY_COUNTRY_SYMBOL';
  static const APP_NAME = 'APP_NAME';
  static const FOOTER_TEXT = 'FOOTER_TEXT';
  static const HELPLINE_NUMBER = 'HELPLINE_NUMBER';
  static const COPYRIGHT = 'COPYRIGHT';
  static const INQUIRY_EMAIL = 'INQUIRY_EMAIL';
  static const SITE_DESCRIPTION = 'SITE_DESCRIPTION';
  static const PRIMARY = 'PRIMARY';
  static const GOOGLE_MAPS_KEY = 'GOOGLE_MAPS_KEY';
  static const CUSTOMER_APP_PLAY_STORE = 'CUSTOMER_APP_PLAY_STORE';
  static const CUSTOMER_APP_APP_STORE = 'CUSTOMER_APP_APP_STORE';
  static const GOOGLE_LOGIN_STATUS = 'GOOGLE_LOGIN_STATUS';
  static const APPLE_LOGIN_STATUS = 'APPLE_LOGIN_STATUS';
  static const OTP_LOGIN_STATUS = 'OTP_LOGIN_STATUS';
  static const APPLICATION_LANGUAGE = 'APPLICATION_LANGUAGE';
  static const CURRENCY_NAME = 'CURRENCY_NAME';
  static const CURRENCY_SYMBOL = 'CURRENCY_SYMBOL';
  static const CURRENCY_CODE = 'CURRENCY_CODE';
  static const CURRENCY_POSITION = 'CURRENCY_POSITION';
  static const NO_OF_DECIMAL = 'NO_OF_DECIMAL';
  static const THOUSAND_SEPARATOR = 'THOUSAND_SEPARATOR';
  static const DECIMAL_SEPARATOR = 'DECIMAL_SEPARATOR';
}
//endregion

//region LOGIN TYPE
class LoginTypeConst {
  static const LOGIN_TYPE_USER = 'user';
  static const LOGIN_TYPE_GOOGLE = 'google';
  static const LOGIN_TYPE_APPLE = 'apple';
  static const LOGIN_TYPE_OTP = 'mobile';
}
//endregion

//region SharedPreference Keys
class SharedPreferenceConst {
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const USER_DATA = 'USER_LOGIN_DATA';
  static const USER_EMAIL = 'USER_EMAIL';
  static const USER_PASSWORD = 'USER_PASSWORD';
  static const FIRST_TIME = 'FIRST_TIME';
  static const IS_REMEMBER_ME = 'IS_REMEMBER_ME';
  static const USER_NAME = 'USER_NAME';
}
//endregion

const USER_NOT_CREATED = "User not created";

class UserKeys {
  static String firstName = 'first_name';
  static String lastName = 'last_name';
  static String username = 'username';
  static String email = 'email';
  static String password = 'password';
  static String mobile = 'mobile';
  static String address = 'address';
  static String aboutSelf = 'about_self';
  static String expert = 'expert';
  static String facebookLink = 'facebook_link';
  static String instagramLink = 'instagram_link';
  static String twitterLink = 'twitter_link';
  static String dribbbleLink = 'dribbble_link';
  static String gender = 'gender';
  static String displayName = 'display_name';
  static String profileImage = 'profile_image';
  static String oldPassword = 'old_password';
  static String newPassword = 'new_password';
  static String playerId = 'player_id';
  static String userType = 'user_type';
  static String latitude = 'latitude';
  static String longitude = 'longitude';
  static String loginType = 'login_type';
  static String contactNumber = 'contact_number';

  static String enableStore='enable_store';
}

class FirebaseTopicConst{
//region Firebase Notification
  static const additionalDataKey = 'additional_data';
  static const notificationGroupKey = 'notification_group';
  static const shopKey = 'shop';
  static const orderCodeKey = 'order_code';
  static const bookingServicesNameKey = 'booking_services_names';
  static const idKey = 'id';
  static const itemIdKey = 'item_id';

  static const notificationKey = 'Notification';

  static const onMessageListen= "Error On Message Listen";
  static const onMessageOpened="Error On Message Opened App";
  static const onGetInitialMessage='Error On Get Initial Message';

  static const messageDataCollapseKey='MessageData Collapse Key';

  static const messageDataMessageIdKey='MessageData Message Id';

  static const messageDataMessageTypeKey='MessageData Type';
  static const userWithUnderscoreKey = 'user_';
  static const notificationDataKey = 'Notification Data';

  static const fcmNotificationTokenKey = 'FCM Notification Token';
  static const apnsNotificationTokenKey = 'APNS Notification Token';
  static const notificationErrorKey = 'Notification Error';
  static const notificationTitleKey = 'Notification Title';
  static const notificationBodyKey = 'Notification Body';
  static const backgroundChannelIdKey='background_channel';
  static const backgroundChannelNameKey='background_channel';

  static const notificationChannelIdKey='notification';
  static const notificationChannelNameKey='Notification';

  static const topicSubscribed='topic-----subscribed---->';

  static const topicUnSubscribed='topic-----UnSubscribed---->';

//endregion
}

//region CacheConst Keys
class APICacheConst {
  static const MY_PETS = 'MY_PETS';
  static const DASHBOARD_RESPONSE = 'HOME_SCREEN_RESPONSE';
  static const STATUS_RESPONSE = 'STATUS_RESPONSE';
  static const ABOUT_RESPONSE = 'ABOUT_RESPONSE';
  static const APP_CONFIGURATION_RESPONSE = 'APP_CONFIGURATION_RESPONSE';
  static const NOTIFICATION_RES = 'NOTIFICATION_RES';
  static const PET_TYPES = 'PET_TYPES';
  static const PET_CENTER_RESPONSE = 'PET_CENTER_RESPONSE';
}

//set Them

class SettingsLocalConst {
  static const THEME_MODE = 'THEME_MODE';
}

//endregion
const PERMISSION_STATUS = 'permissionStatus';

//region CacheConst Keys
class ServicesKeyConst {
  static const boarding = 'boarding';
  static const veterinary = 'veterinary';
  static const grooming = 'grooming';
  static const walking = 'walking';
  static const training = 'training';
  static const dayCare = 'daycare';
}

const LATITUDE = 'LATITUDE';
const LONGITUDE = 'LONGITUDE';
const CURRENT_ADDRESS = 'CURRENT_ADDRESS';

//region CacheConst Keys
class EmployeeKeyConst {
  static const boarding = 'boarder';
  static const veterinary = 'vet';
  static const grooming = 'groomer';
  static const walking = 'walker';
  static const training = 'trainer';
  static const dayCare = 'day_taker';
  static const petSitter = 'pet_sitter';
  static const petStore = 'pet_store';
}
//endregion

//region Status
class StatusConst {
  static const pending = 'pending';
  static const upcoming = 'upcoming';
  static const confirmed = 'confirmed';
  static const completed = 'completed';
  static const cancel = 'cancel';
  static const reject = 'reject';
  static const inprogress = 'inprogress';
}
//endregion

//region Status
class ServiceFilterStatusConst {
  static const all = 'all';
  static const addedByMe = 'added_by_me';
  static const assignByAdmin = 'assign_by_admin';
  static const createdByAdmin = 'created_by_admin';
}
//endregion

//region BOOKING STATUS
class BookingStatusConst {
  static const COMPLETED = 'completed';
  static const PENDING = 'pending';
  static const CONFIRMED = 'confirmed';
  static const CHECK_IN = 'check_in';
  static const CHECKOUT = 'checkout';
  static const CANCELLED = 'cancelled';
  static const REJECTED = 'rejected';
  static const INPROGRESS = 'inprogress';
}
//endregion

//region Status
class PriceStatusConst {
  static const pending = 'pending';
  static const upcoming = 'upcoming';
  static const confirmed = 'confirmed';
  static const cancel = 'cancel';
}
//endregion

//region TaxType Keys
class TaxType {
  static const FIXED = 'fixed';
  static const PERCENT = 'percent';
}
//endregion

//region Product Discount Types
class ProductDiscountTypes {
  static const FIXED = 'fixed';
  static const PERCENT = 'percent';
}
//endregion

//region PaymentStatus
class PaymentStatus {
  static const PAID = 'paid';
  static const pending = 'pending';
  static const failed = 'failed';
}

//endregion

//region OrderStatus
class OrderStatus {
  static const OrderPlaced = 'order_placed';
  static const Pending = 'pending';
  static const Processing = 'processing';
  static const Delivered = 'delivered';
  static const Cancelled = 'cancelled';
  static const Accepted = 'accepted';
  static const Accept = 'accept';
}

//region ReviewStatus
class ReviewStatus {
  static const ByService = 'by_service';
  static const ByOrder = 'by_order';
}

//region Status
class NotificationConst {
  static const newBooking = 'new_booking';
  static const completeBooking = 'complete_booking';
  static const rejectBooking = 'reject_booking';
  static const acceptBooking = 'accept_booking';
  static const cancelBooking = 'cancel_booking';
  static const changePassword = 'change_password';
  static const forgetEmailPassword = 'forget_email_password';
  static const orderPlaced = 'order_placed';
  static const orderPending = 'order_pending';
  static const orderAccepted = 'order_accepted';
  static const orderProcessing = 'order_processing';
  static const orderDelivered = 'order_delivered';
  static const orderCancelled = 'order_cancelled';
  static const booking = 'booking';
  static const shop = 'shop';
}

//endregion
//region Gender TYPE
class GenderTypeConst {
  static const MALE = 'male';
  static const FEMALE = 'female';
}
//endregion

//region PaymentMethods Keys
class PaymentMethods {
  static const PAYMENT_METHOD_CASH = 'cash';
  static const PAYMENT_METHOD_STRIPE = 'stripe';
  static const PAYMENT_METHOD_RAZORPAY = 'razorpay';
  static const PAYMENT_METHOD_PAYPAL = 'paypal';
  static const PAYMENT_METHOD_PAYSTACK = 'paystack';
}
//endregion

Country defaultCountry() {
  return Country(
    phoneCode: '91',
    countryCode: 'IN',
    e164Sc: 91,
    geographic: true,
    level: 1,
    name: 'India',
    example: '23456789',
    displayName: 'India (IN) [+91]',
    displayNameNoCountryCode: 'India (IN)',
    e164Key: '91-IN-0',
    fullExampleWithPlusSign: '+919123456789',
  );
}

// Currency position

//endregion

//region Currency position
class CurrencyPosition {
  static const CURRENCY_POSITION_LEFT = 'left';
  static const CURRENCY_POSITION_RIGHT = 'right';
  static const CURRENCY_POSITION_LEFT_WITH_SPACE = 'left_with_space';
  static const CURRENCY_POSITION_RIGHT_WITH_SPACE = 'right_with_space';
}

//endregion
class ServiceConst {
  static const id = 'id';
  static const name = 'name';
  static const durationMin = 'duration_min';
  static const defaultPrice = 'default_price';
  static const type = 'type';
  static const description = 'description';
  static const categoryId = 'category_id';
  static const featureImage = 'feature_image';
}

List<DemoLoginData> demoUsers = [
  DemoLoginData(id: 1, icon: Assets.serviceIconsIcBoarding, userType: EmployeeKeyConst.boarding, serviceName: "Boarder", email: "miles@gmail.com", password: "12345678"),
  DemoLoginData(id: 2, icon: Assets.serviceIconsIcVeterinary, userType: EmployeeKeyConst.veterinary, serviceName: "Veterinarian", email: "felix@gmail.com", password: "12345678"),
  DemoLoginData(id: 3, icon: Assets.serviceIconsIcGrooming, userType: EmployeeKeyConst.grooming, serviceName: "Groomer", email: "richard@gmail.com", password: "12345678"),
  DemoLoginData(id: 4, icon: Assets.serviceIconsIcTraining, userType: EmployeeKeyConst.training, serviceName: "Trainer", email: "tristan@gmail.com", password: "12345678"),
  DemoLoginData(id: 5, icon: Assets.serviceIconsIcWalking, userType: EmployeeKeyConst.walking, serviceName: "Walker", email: "pedro@gmail.com", password: "12345678"),
  DemoLoginData(id: 6, icon: Assets.serviceIconsIcDaycare, userType: EmployeeKeyConst.dayCare, serviceName: "Daycare Taker", email: "justin@gmail.com", password: "12345678"),
  DemoLoginData(id: 7, icon: Assets.profileIconsIcUserOutlined, userType: EmployeeKeyConst.petSitter, serviceName: "Pet Sitter", email: "harry@gmail.com", password: "12345678"),
  if (appConfigs.value.isMultiVendorEnable.getBoolInt())
    DemoLoginData(
      id: 8,
      icon: Assets.serviceIconsIcPetStore,
      userType: EmployeeKeyConst.petStore,
      serviceName: "Pet Store",
      email: "mario@gmail.com",
      password: "12345678",
    ),
];
