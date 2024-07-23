// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:porosenocheckemployee/utils/local_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/new_update_dialog.dart';
import '../components/price_widget.dart';
import '../configs.dart';
import '../generated/assets.dart';
import '../main.dart';
import '../screens/auth/sign_in_sign_up/signin_screen.dart';
import '../screens/booking_module/model/bookings_model.dart';
import 'app_common.dart';
import 'colors.dart';
import 'constants.dart';

ThemeMode get appThemeMode => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

String? get fontFamilyFontWeight600 => GoogleFonts.beVietnamPro(fontWeight: FontWeight.w600).fontFamily;

String? get fontFamilyFontBold => GoogleFonts.beVietnamPro(fontWeight: FontWeight.bold).fontFamily;

String? get fontFamilyFontWeight300 => GoogleFonts.beVietnamPro(fontWeight: FontWeight.w300).fontFamily;

String? get fontFamilyFontWeight400 => GoogleFonts.beVietnamPro(fontWeight: FontWeight.w400).fontFamily;

Widget get commonDivider => Column(
      children: [
        Divider(indent: 3, height: 1, color: isDarkMode.value ? borderColor.withOpacity(0.1) : borderColor.withOpacity(0.5)).paddingSymmetric(horizontal: 16),
      ],
    );

Widget get bottomSheetDivider => Column(
      children: [
        20.height,
        Divider(
          indent: 3,
          height: 0,
          color: Get.isDarkMode ? borderColor.withOpacity(0.2) : borderColor.withOpacity(0.5),
        ),
        20.height,
      ],
    );

hideKeyBoardWithoutContext() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: Assets.flagsIcUs),
    LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'hi-IN', flag: Assets.flagsIcIn),
    LanguageDataModel(id: 3, name: 'Arabic', languageCode: 'ar', fullLanguageCode: 'ar-AR', flag: Assets.flagsIcAr),
    LanguageDataModel(id: 4, name: 'French', languageCode: 'fr', fullLanguageCode: 'fr-FR', flag: Assets.flagsIcFr),
    LanguageDataModel(id: 4, name: 'German', languageCode: 'de', fullLanguageCode: 'de-DE', flag: Assets.flagsIcDe),
  ];
}

void toggleThemeMode({required int themeId}) {
  if (themeId == THEME_MODE_SYSTEM) {
    Get.changeThemeMode(ThemeMode.system);
    isDarkMode(Get.isPlatformDarkMode);
  } else if (themeId == THEME_MODE_LIGHT) {
    Get.changeThemeMode(ThemeMode.light);
    isDarkMode(false);
  } else if (themeId == THEME_MODE_DARK) {
    Get.changeThemeMode(ThemeMode.dark);
    isDarkMode(true);
  }
  setValueToLocal(SettingsLocalConst.THEME_MODE, themeId);
  log('toggleDarkLightSwitch: $themeId');
  if (isDarkMode.value) {
    textPrimaryColorGlobal = Colors.white;
    textSecondaryColorGlobal = Colors.white70;
  } else {
    textPrimaryColorGlobal = primaryTextColor;
    textSecondaryColorGlobal = secondaryTextColor;
  }
  updateUi(true);
  updateUi(false);
}

Widget appCloseIconButton(BuildContext context, {required void Function() onPressed, double size = 12}) {
  return IconButton(
    iconSize: size,
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    icon: Container(
      padding: EdgeInsets.all(size - 8),
      decoration: boxDecorationDefault(color: context.cardColor, borderRadius: BorderRadius.circular(size - 4), border: Border.all(color: secondaryTextColor)),
      child: Icon(
        Icons.close_rounded,
        size: size,
      ),
    ),
  );
}

Widget commonLeadingWid({required String imgPath, required IconData icon, Color? color, double size = 20}) {
  return Image.asset(
    imgPath,
    width: size,
    height: size,
    color: color,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) => Icon(
      icon,
      size: size,
      color: color ?? secondaryColor,
    ),
  );
}

Future<void> commonLaunchUrl(String address, {LaunchMode launchMode = LaunchMode.inAppWebView}) async {
  await launchUrl(Uri.parse(address), mode: launchMode).catchError((e) {
    toast('${locale.value.invalidUrl}: $address');
  });
}

void viewFiles(String url) {
  if (url.isNotEmpty) {
    commonLaunchUrl(url, launchMode: LaunchMode.externalApplication);
  }
}

void launchCall(String? url) {
  if (url.validate().isNotEmpty) {
    if (isIOS) {
      commonLaunchUrl('tel://${url!}', launchMode: LaunchMode.externalApplication);
    } else {
      commonLaunchUrl('tel:${url!}', launchMode: LaunchMode.externalApplication);
    }
  }
}

void launchMap(String? url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl(Constants.googleMapPrefix + url!, launchMode: LaunchMode.externalApplication);
  }
}

void launchMail(String url) {
  if (url.validate().isNotEmpty) {
    launchUrl(mailTo(to: []), mode: LaunchMode.externalApplication);
  }
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

/* String formatDate(String? dateTime, {String format = DateFormatConst.yyyy_MM_dd}) {
  return DateFormat(format).format(DateTime.parse(dateTime.validate()));
} */

///
/// Date format extension for format datetime in different formats,
/// e.g. 1) dd-MM-yyyy, 2) yyyy-MM-dd, etc...
///
extension DateData on String {
  /// Formats the given [DateTime] object in the [dd-MM-yy] format.
  ///
  /// Returns a string representing the formatted date.
  DateTime get dateInyyyyMMddFormat {
    try {
      return DateFormat(DateFormatConst.yyyy_MM_dd).parse(this);
    } catch (e) {
      return DateTime.now();
    }
  }

  String get dateInMMMMDyyyyFormat {
    try {
      return DateFormat(DateFormatConst.MMMM_D_yyyy).format(dateInyyyyMMddHHmmFormat);
    } catch (e) {
      return this;
    }
  }

  String get dateInEEEEDMMMMAtHHmmAmPmFormat {
    try {
      return DateFormat(DateFormatConst.EEEE_D_MMMM_At_HH_mm_a).format(dateInyyyyMMddHHmmFormat);
    } catch (e) {
      return this;
    }
  }

  bool get isValidTime {
    return DateTime.tryParse("1970-01-01 $this") != null;
  }

  String get dateInDMMMMyyyyFormat {
    try {
      return DateFormat(DateFormatConst.D_MMMM_yyyy).format(dateInyyyyMMddHHmmFormat);
    } catch (e) {
      return this;
    }
  }

  String get dateInDMMMyyyyFormat {
    try {
      return DateFormat(DateFormatConst.D_MMM_yyyy).format(dateInyyyyMMddHHmmFormat);
    } catch (e) {
      return this;
    }
  }

  String get dayFromDate {
    try {
      return dateInyyyyMMddHHmmFormat.day.toString();
    } catch (e) {
      return "";
    }
  }

  String get monthMMMFormat {
    try {
      return dateInyyyyMMddHHmmFormat.month.toMonthName(isHalfName: true);
    } catch (e) {
      return "";
    }
  }

  String get dateInMMMMDyyyyAtHHmmAmPmFormat {
    try {
      return DateFormat(DateFormatConst.MMMM_D_yyyy_At_HH_mm_a).format(dateInyyyyMMddHHmmFormat);
    } catch (e) {
      return this;
    }
  }

  String get dateInddMMMyyyyHHmmAmPmFormat {
    try {
      return DateFormat(DateFormatConst.dd_MMM_yyyy_HH_mm_a).format(dateInyyyyMMddHHmmFormat);
    } catch (e) {
      try {
        return "$dateInyyyyMMddHHmmFormat";
      } catch (e) {
        return this;
      }
    }
  }

  String get formattedDateInddMMMyyyyHHmmAmPmFormat {
    try {
      return DateFormat(DateFormatConst.dd_MMM_yyyy_HH_mm_a).format(formattedDateInyyyyMMddHHmmFormat);
    } catch (e) {
      try {
        return "$formattedDateInyyyyMMddHHmmFormat";
      } catch (e) {
        return this;
      }
    }
  }

  DateTime get formattedDateInyyyyMMddHHmmFormat {
    try {
      return DateFormat(DateFormatConst.yyyy_MM_dd_HH_mm).parse(this);
    } catch (e) {
      try {
        return DateFormat(DateFormatConst.yyyy_MM_dd_HH_mm).parse(DateTime.parse(this).toString());
      } catch (e) {
        log('formattedDateInyyyyMMddHHmmFormat E: $e');
        return DateTime.now();
      }
    }
  }

  DateTime get dateInyyyyMMddHHmmFormat {
    try {
      return DateFormat(DateFormatConst.yyyy_MM_dd_HH_mm).parse(this);
    } catch (e) {
      try {
        return DateFormat(DateFormatConst.yyyy_MM_dd_HH_mm).parse(DateTime.parse(this).toLocal().toString());
      } catch (e) {
        log('dateInyyyyMMddHHmmFormat E: $e');
        return DateTime.now();
      }
    }
  }

  DateTime get dateInHHmm24HourFormat {
    return DateFormat(DateFormatConst.HH_mm24Hour).parse(this);
  }

  String get timeInHHmmAmPmFormat {
    try {
      return DateFormat(DateFormatConst.HH_mm12Hour).format(dateInyyyyMMddHHmmFormat);
    } catch (e) {
      return this;
    }
  }

  TimeOfDay get timeOfDay24Format {
    return TimeOfDay.fromDateTime(DateFormat(DateFormatConst.yyyy_MM_dd_HH_mm).parse(this));
  }

  /* String get dateIndmmyhmaFormat {
    return DateFormat(DateFormatConst.yyyy_MM_dd).format(DateFormat(DateFormatConst.MMMM_D_yyyy).parse(this));
  } */

  bool get isValidDateTime {
    return DateTime.tryParse(this) != null;
  }

  bool get isAfterCurrentDateTime {
    return dateInyyyyMMddHHmmFormat.isAfter(DateTime.now());
  }

  bool get isToday {
    try {
      return "$dateInyyyyMMddFormat" == DateTime.now().formatDateYYYYmmdd();
    } catch (e) {
      return false;
    }
  }

  Duration toDuration() {
    final parts = split(':');
    try {
      if (parts.length == 2) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        return Duration(hours: hours, minutes: minutes);
      } else {
        return Duration.zero;
      }
    } catch (e) {
      return Duration.zero;
    }
  }

  String toFormattedDuration({bool showFullTitleHoursMinutes = false}) {
    try {
      final duration = toDuration();
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);

      String formattedDuration = '';
      if (hours > 0) {
        formattedDuration += "$hours ${showFullTitleHoursMinutes ? 'hour' : 'hr'} ";
      }
      if (minutes > 0) {
        formattedDuration += '$minutes ${showFullTitleHoursMinutes ? 'minute' : 'min'}';
      }
      return formattedDuration.trim();
    } catch (e) {
      return "";
    }
  }
}

extension DateExtension on DateTime {
  /// Formats the given [DateTime] object in the [dd-MM-yy] format.
  ///
  /// Returns a string representing the formatted date.
  String formatDateDDMMYY() {
    final formatter = DateFormat(DateFormatConst.DD_MM_YY);
    return formatter.format(this);
  }

  /// Formats the given [DateTime] object in the [DateFormatConst.yyyy_MM_dd] format.
  ///
  /// Returns a string representing the formatted date.
  String formatDateYYYYmmdd() {
    final formatter = DateFormat(DateFormatConst.yyyy_MM_dd);
    return formatter.format(this);
  }

  /// Formats the given [DateTime] object in the [DateFormatConst.yyyy_MM_dd_HH_mm] format.
  ///
  /// Returns a string representing the formatted date.
  String formatDateYYYYmmddHHmm() {
    final formatter = DateFormat(DateFormatConst.yyyy_MM_dd_HH_mm);
    return formatter.format(this);
  }

  /// Formats the given [DateTime] object in the [DateFormatConst.yyyy_MM_dd]+[DateFormatConst.HH_mm12Hour] format.
  ///
  /// Returns a string representing the formatted date.
  String formatDateddmmYYYYHHmmAMPM() {
    final formatter = DateFormat(DateFormatConst.DD_MM_YY);
    final timeInAMPM = DateFormat(DateFormatConst.HH_mm12Hour);
    return "${formatter.format(this)} ${timeInAMPM.format(this)}";
  }

  /*  /// Formats the given [DateTime] object in the [DateFormatConst.yyyy_MM_dd]+[DateFormatConst.HH_mm_a] format.
  ///
  /// Returns a string representing the formatted date.
  String formatDateddmmYYYYHHmmAMPM() {
    final formatter = DateFormat("dd-MM-yyyy");
    final timeInAMPM = DateFormat(DateFormatConst.HH_mm_a);
    return "${formatter.format(this)} ${timeInAMPM.format(this)}";
  } */

  /// Formats the given [DateTime] object in the [DateFormatConst.HH_mm12Hour] format.
  ///
  /// Returns a string representing the formatted date.
  String formatTimeHHmmAMPM() {
    final formatter = DateFormat(DateFormatConst.HH_mm12Hour);
    return formatter.format(this);
  }

  /// Returns Time Ago
  String get timeAgoWithLocalization => formatTime(millisecondsSinceEpoch);
}

/// Splits a date string in the format "dd/mm/yyyy" into its constituent parts and returns a [DateTime] object.
///
/// If the input string is not a valid date format, this method returns `null`.
///
/// Example usage:
///
/// ```dart
/// DateTime? myDate = getDateTimeFromAboveFormat('27/04/2023');
/// if (myDate != null) {
///   print(myDate); // Output: 2023-04-27 00:00:00.000
/// }
/// ```
///
DateTime? getDateTimeFromAboveFormat(String date) {
  if (date.isValidDateTime) {
    return DateTime.tryParse(date);
  } else {
    List<String> dateParts = date.split('/');
    if (dateParts.length != 3) {
      log('getDateTimeFromAboveFormat => Invalid date format => DATE: $date');
      return null;
    }
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);
    return DateTime.tryParse('$year-$month-$day');
  }
}

extension TimeExtension on TimeOfDay {
  /// Formats the given [TimeOfDay] object in the [DateFormatConst.HH_mm24Hour] format.
  ///
  /// Returns a string representing the formatted time.
  String formatTimeHHmm24Hour() {
    final timeIn24Hour = DateFormat(DateFormatConst.HH_mm24Hour);
    final tempDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
    return timeIn24Hour.format(tempDateTime);
  }

  /// Formats the given [TimeOfDay] object in the [DateFormatConst.yyyy_MM_dd]+[DateFormatConst.HH_mm12Hour] format.
  ///
  /// Returns a string representing the formatted time.
  String formatTimeHHmmAMPM() {
    final timeInAMPM = DateFormat(DateFormatConst.HH_mm12Hour);
    final tempDateTime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, hour, minute);
    return timeInAMPM.format(tempDateTime);
  }
}

TextStyle get appButtonTextStyleGray => secondaryTextStyle(color: secondaryColor, size: 14, fontFamily: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w500).fontFamily);

TextStyle get appButtonTextStyleWhite => secondaryTextStyle(color: Colors.white, size: 14, fontFamily: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w600).fontFamily);

TextStyle get appButtonPrimaryColorText => secondaryTextStyle(color: primaryColor, fontFamily: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w500).fontFamily);

TextStyle get appButtonFontColorText => secondaryTextStyle(color: Colors.grey, fontFamily: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w500).fontFamily);

InputDecoration inputDecoration(BuildContext context,
    {Widget? prefixIcon, Widget? prefix, Widget? suffix, BoxConstraints? prefixIconConstraints, Widget? suffixIcon, String? labelText, String? hintText, double? borderRadius, bool? filled, Color? fillColor}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    hintText: hintText,
    prefix: prefix,
    suffix: suffix,
    hintStyle: secondaryTextStyle(size: 12, fontFamily: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w300).fontFamily),
    labelStyle: secondaryTextStyle(size: 12),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    prefixIconConstraints: prefixIconConstraints,
    suffixIcon: suffixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: borderColor, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    border: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: borderColor, width: 0.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: borderColor, width: 0.0),
    ),
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: primaryColor, width: 0.0),
    ),
    filled: filled,
    fillColor: fillColor,
  );
}

InputDecoration inputDecorationWithOutBorder(BuildContext context, {Widget? prefixIcon, Widget? suffixIcon, String? labelText, String? hintText, double? borderRadius, bool? filled, Color? fillColor}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    hintText: hintText,
    hintStyle: secondaryTextStyle(size: 12, fontFamily: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w300).fontFamily),
    labelStyle: secondaryTextStyle(size: 12),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    border: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    ),
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: const BorderSide(color: primaryColor, width: 0.0),
    ),
    filled: filled,
    fillColor: fillColor,
  );
}

Future<List<PlatformFile>> pickFiles({FileType type = FileType.any}) async {
  List<PlatformFile> filePath0 = [];
  try {
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: true,
      withData: true,
      onFileLoading: (FilePickerStatus status) => log(status),
    );
    if (filePickerResult != null) {
      if (Platform.isAndroid) {
        filePath0 = filePickerResult.files;
      } else {
        Directory cacheDir = await getTemporaryDirectory();
        for (PlatformFile file in filePickerResult.files) {
          if (file.bytes != null) {
            String filePath = '${cacheDir.path}/${file.name}';
            File cacheFile = File(filePath);
            await cacheFile.writeAsBytes(file.bytes!.toList());
            PlatformFile cachedFile = PlatformFile(
              path: cacheFile.path,
              name: file.name,
              size: cacheFile.lengthSync(),
              bytes: Uint8List.fromList(cacheFile.readAsBytesSync()),
            );
            filePath0.add(cachedFile);
          }
        }
      }
    }
  } on PlatformException catch (e) {
    log('Unsupported operation$e');
  } catch (e) {
    log(e.toString());
  }
  return filePath0;
}

Widget backButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      finish(context);
    },
    icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.grey, size: 20),
  );
}

class CommonAppBar extends StatelessWidget {
  final String title;
  final Widget? action;
  final bool hasLeadingWidget;
  final Widget? leadingWidget;

  const CommonAppBar({
    super.key,
    required this.title,
    this.hasLeadingWidget = true,
    this.leadingWidget,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        leadingWidget ??
            (hasLeadingWidget
                ? backButton(context)
                : const SizedBox(
                    height: 48,
                    width: 16,
                  )),
        8.width,
        Text(
          title,
          style: primaryTextStyle(size: 18),
        ),
        const Spacer(),
        action ?? const SizedBox(),
        8.width,
      ],
    );
  }
}

extension WidgetExt on Widget? {
  Container shadow() {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: this);
  }
}

extension StrEtx on String {
  Widget iconImage({double? size, Color? color, BoxFit? fit}) {
    return Image.asset(
      this,
      height: size ?? 14,
      width: size ?? 14,
      fit: fit ?? BoxFit.cover,
      color: color ?? (Get.isDarkMode ? Colors.white : darkGray),
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(Assets.iconsIcNoPhoto, height: size ?? 14, width: size ?? 14);
      },
    );
  }

  String get firstLetter => isNotEmpty ? this[0] : '';
}

void ifNotTester(VoidCallback callback) {
  if (!demoUsers.map((e) => e.email).toList().contains(loginUserData.value.email)) {
    callback.call();
  } else {
    toast(locale.value.demoUserCannotBeGrantedForThis);
  }
}

Color getBookingStatusColor({required String status}) {
  if (status.toLowerCase().contains(StatusConst.pending)) {
    return pendingStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.upcoming)) {
    return upcomingStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.completed)) {
    return completedStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.confirmed)) {
    return confirmedStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.cancel)) {
    return cancelStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.reject)) {
    return cancelStatusColor;
  } else {
    return defaultStatusColor;
  }
}

Color getPriceStatusColor({required BookingDataModel appointment}) {
  if (appointment.payment.paymentStatus.toLowerCase().contains(PaymentStatus.pending)) {
    return pricependingStatusColor;
  } else if (appointment.payment.paymentStatus.toLowerCase().contains(PaymentStatus.PAID)) {
    return completedStatusColor;
  } else {
    return pricedefaultStatusColor;
  }
}

String getAddressByServiceElement({required BookingDataModel appointment}) {
  if (appointment.service.slug.contains(ServicesKeyConst.boarding)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.veterinary)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.grooming)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.walking)) {
    return appointment.address;
  } else if (appointment.service.slug.contains(ServicesKeyConst.training)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.dayCare)) {
    return appointment.address;
  } else {
    return "";
  }
}

void handleRate() async {
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

void doIfLoggedIn(BuildContext context, VoidCallback callback) async {
  if (isLoggedIn.value) {
    callback.call();
  } else {
    bool? res = await Get.to(() => SignInScreen());
    log('doIfLoggedIn RES: $res');

    if (res ?? false) {
      callback.call();
    }
  }
}

void showNewUpdateDialog(BuildContext context, {required int currentAppVersionCode}) async {
  showInDialog(
    context,
    contentPadding: EdgeInsets.zero,
    barrierDismissible: currentAppVersionCode >= appConfigs.value.employeeMinimumForceUpdateCode,
    builder: (_) {
      return PopScope(
        canPop: currentAppVersionCode >= appConfigs.value.employeeMinimumForceUpdateCode,
        onPopInvoked: (p0) {},
        child: NewUpdateDialog(canClose: currentAppVersionCode >= appConfigs.value.employeeMinimumForceUpdateCode),
      );
    },
  );
}

Future<void> showForceUpdateDialog(BuildContext context) async {
  getPackageInfo().then((value) {
    if (isAndroid && appConfigs.value.employeeLatestVersionUpdateCode > value.versionCode.validate().toInt()) {
      showNewUpdateDialog(context, currentAppVersionCode: value.versionCode.validate().toInt());
    }
  });
}

String getEmployeeRoleByServiceElement({required BookingDataModel appointment}) {
  if (appointment.service.slug.contains(ServicesKeyConst.boarding)) {
    return locale.value.boarder;
  } else if (appointment.service.slug.contains(ServicesKeyConst.veterinary)) {
    return locale.value.veterinarian;
  } else if (appointment.service.slug.contains(ServicesKeyConst.grooming)) {
    return locale.value.groomer;
  } else if (appointment.service.slug.contains(ServicesKeyConst.walking)) {
    return locale.value.walker;
  } else if (appointment.service.slug.contains(ServicesKeyConst.training)) {
    return locale.value.trainer;
  } else if (appointment.service.slug.contains(ServicesKeyConst.dayCare)) {
    return "${locale.value.daycare} ${locale.value.taker}";
  } else {
    return "";
  }
}

String getBookingStatusEmployee({required String status}) {
  if (status.toLowerCase().contains(StatusConst.pending)) {
    return locale.value.pending;
  } else if (status.toLowerCase().contains(StatusConst.completed)) {
    return locale.value.completed;
  } else if (status.toLowerCase().contains(StatusConst.confirmed)) {
    return locale.value.confirmed;
  } else if (status.toLowerCase().contains(StatusConst.cancel)) {
    return locale.value.cancelled;
  } else if (status.toLowerCase().contains(StatusConst.inprogress)) {
    return locale.value.inProgress;
  } else if (status.toLowerCase().contains(StatusConst.reject)) {
    return locale.value.rejected;
  } else {
    return "";
  }
}

String getServiceFilterEmployee({required String status}) {
  if (status.toLowerCase().contains(ServiceFilterStatusConst.addedByMe)) {
    return locale.value.addedByMe;
  } else if (status.toLowerCase().contains(ServiceFilterStatusConst.assignByAdmin)) {
    return locale.value.assignedByAdmin;
  } else if (status.toLowerCase().contains(ServiceFilterStatusConst.all)) {
    return locale.value.all;
  } else if (status.toLowerCase().contains(ServiceFilterStatusConst.createdByAdmin)) {
    return locale.value.createdByAdmin;
  } else {
    return "";
  }
}

String getProductFilterEmployee({required String status}) {
  if (status.toLowerCase().contains(ServiceFilterStatusConst.all)) {
    return locale.value.all;
  } else if (status.toLowerCase().contains(ServiceFilterStatusConst.createdByAdmin)) {
    return locale.value.createdByAdmin;
  } else {
    return "";
  }
}

String getBookingPaymentStatus({required String status}) {
  if (status.toLowerCase().contains(PaymentStatus.pending)) {
    return locale.value.pending;
  } else if (status.toLowerCase().contains(PaymentStatus.PAID)) {
    return locale.value.paid;
  } else if (status.toLowerCase().contains(PaymentStatus.failed)) {
    return locale.value.failed;
  } else {
    return "";
  }
}

Widget buildIconWidget({required String icon, required VoidCallback onTap, Color? iconColor, double? height, double? weight}) {
  return SizedBox(
    height: height ?? 38,
    width: weight ?? 38,
    child: IconButton(padding: EdgeInsets.zero, icon: icon.iconImage(size: 18, color: iconColor), onPressed: onTap),
  );
}

String formatDate(String? dateTime, {String format = DateFormatConst.DATE_FORMAT_1, bool isFromMicrosecondsSinceEpoch = false, bool isLanguageNeeded = true}) {
  final languageCode = isLanguageNeeded ? selectedLanguageCode(getValueFromLocal(SELECTED_LANGUAGE_CODE) ?? DEFAULT_LANGUAGE) : null;
  final parsedDateTime = isFromMicrosecondsSinceEpoch ? DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000) : DateTime.parse(dateTime.validate());

  return DateFormat(format, languageCode).format(parsedDateTime);
}

Color getRatingColor(int rating) {
  if (rating == 1 || rating == 2) {
    return ratingBarColor;
  } else if (rating == 3) {
    return const Color(0xFFff6200);
  } else if (rating == 4 || rating == 5) {
    return const Color(0xFF73CB92);
  } else {
    return ratingBarColor;
  }
}

Widget detailWidget({required String title, required String value, Color? textColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: secondaryTextStyle()).expand(),
      Text(value, textAlign: TextAlign.right, style: boldTextStyle(size: 12, color: textColor)).expand(),
    ],
  ).paddingBottom(10).visible(value.isNotEmpty);
}

Widget detailWidgetPrice({required String title, required num value, Color? textColor, bool isSemiBoldText = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: secondaryTextStyle()),
      PriceWidget(
        price: value,
        color: textColor ?? black,
        size: 12,
        isBoldText: isSemiBoldText,
      )
    ],
  ).paddingBottom(10);
}

String getOrderStatus({required String status}) {
  if (status.toLowerCase().contains(OrderStatus.OrderPlaced)) {
    return locale.value.orderPlaced;
  } else if (status.toLowerCase().contains(OrderStatus.Accepted)) {
    return "Accepted"; //TODO: string
  }  else if (status.toLowerCase().contains(OrderStatus.Accept)) {
    return locale.value.accept;
  } else if (status.toLowerCase().contains(OrderStatus.Processing)) {
    return locale.value.processing;
  } else if (status.toLowerCase().contains(OrderStatus.Delivered)) {
    return locale.value.delivered;
  } else if (status.toLowerCase().contains(OrderStatus.Cancelled)) {
    return locale.value.cancelled;
  } else {
    return "";
  }
}

String getReviewStatus({required String status}) {
  if (status.toLowerCase().contains(ReviewStatus.ByService)) {
    return "By Service"; //TODO: string
  } else if (status.toLowerCase().contains(ReviewStatus.ByOrder)) {
    return "By Order"; //TODO: string
  } else {
    return "";
  }
}

Color getOrderStatusColor({required String status}) {
  if (status.toLowerCase().contains(OrderStatus.OrderPlaced)) {
    return upcomingStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Accepted)) {
    return confirmedStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Processing)) {
    return pendingStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Delivered)) {
    return completedStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Cancelled)) {
    return cancelStatusColor;
  } else {
    return defaultStatusColor;
  }
}

Color getOrderPriceStatusColor({required String paymentStatus}) {
  if (paymentStatus.toLowerCase().contains(PaymentStatus.pending)) {
    return pricependingStatusColor;
  } else if (paymentStatus.toLowerCase().contains(PaymentStatus.PAID)) {
    return completedStatusColor;
  } else {
    return pricedefaultStatusColor;
  }
}

String getBookingNotification({required String notification}) {
  if (notification.toLowerCase().contains(NotificationConst.newBooking)) {
    return locale.value.newBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.completeBooking)) {
    return locale.value.completeBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.rejectBooking)) {
    return locale.value.rejectBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.cancelBooking)) {
    return locale.value.cancelBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.acceptBooking)) {
    return locale.value.acceptBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.changePassword)) {
    return locale.value.changePassword;
  } else if (notification.toLowerCase().contains(NotificationConst.forgetEmailPassword)) {
    return locale.value.forgetEmailPassword;
  } else if (notification.toLowerCase().contains(NotificationConst.orderPlaced)) {
    return locale.value.orderPlaced;
  } else if (notification.toLowerCase().contains(NotificationConst.orderPending)) {
    return locale.value.orderPending;
  } else if (notification.toLowerCase().contains(NotificationConst.orderAccepted)) {
    return "Order Accepted"; //TODO: string
  } else if (notification.toLowerCase().contains(NotificationConst.orderProcessing)) {
    return locale.value.orderProcessing;
  } else if (notification.toLowerCase().contains(NotificationConst.orderDelivered)) {
    return locale.value.orderDelivered;
  } else if (notification.toLowerCase().contains(NotificationConst.orderCancelled)) {
    return locale.value.orderCancelled;
  } else {
    return "";
  }
}
