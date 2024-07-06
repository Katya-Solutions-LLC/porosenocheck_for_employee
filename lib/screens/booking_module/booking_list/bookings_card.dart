import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../booking_detail/booking_detail_screen.dart';
import '../model/bookings_model.dart';
import 'bookings_controller.dart';

class BookingsCard extends StatelessWidget {
  final BookingDataModel booking;
  final VoidCallback? onUpdateBooking;

  BookingsCard({super.key, this.onUpdateBooking, required this.booking});

  final BookingsController bookingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
        Get.to(() => BookingDetailScreen(), arguments: booking, duration: const Duration(milliseconds: 200));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.rectangle),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(tag: '#${booking.id}', child: Text('#${booking.id} - ${booking.service.name}', style: primaryTextStyle(decoration: TextDecoration.none))),
                ],
              ).paddingSymmetric(horizontal: 16),
              8.height,
              Row(
                children: [
                  Text(locale.value.bookingStatus, style: secondaryTextStyle()),
                  const Spacer(),
                  Text(
                    getBookingStatusEmployee(status: booking.status.capitalizeFirstLetter()),
                    style: primaryTextStyle(size: 12, color: getBookingStatusColor(status: booking.status)),
                  ),
                  // Text(appointment.status.capitalizeFirstLetter(), style: primaryTextStyle(size: 12, color: appointment.status.toLowerCase().contains(StatusConst.pending) ? pendingStatusColor : defaultStatusColor)),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              commonDivider,
              16.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(booking.customerName, style: primaryTextStyle()).expand(),
                  CachedImageWidget(
                    url: booking.customerImage,
                    height: 38,
                    width: 38,
                    fit: BoxFit.cover,
                    circle: true,
                  ),
                ],
              ).paddingSymmetric(horizontal: 16),
              8.height,
              Column(
                children: [
                  detailWidget(image: Assets.navigationIcCalendarOutlined, title: locale.value.dateAndTime, value: scheduleDate).visible(booking.startDateTime.isNotEmpty),
                  detailWidget(image: Assets.iconsIcDuration, title: locale.value.duration, value: booking.duration.toFormattedDuration(showFullTitleHoursMinutes: true)),
                  Row(
                    children: [
                      4.width,
                      Image.asset(
                        Assets.profileIconsIcMyPets,
                        width: 15,
                        height: 15,
                        color: switchColor,
                      ),
                      4.width,
                      Marquee(child: Text(locale.value.pet, style: secondaryTextStyle(), textAlign: TextAlign.left)).expand(flex: 3),
                      12.width,
                      Text(":", style: secondaryTextStyle()),
                      10.width,
                      CachedImageWidget(
                        url: booking.petImage,
                        height: 20,
                        width: 20,
                        circle: true,
                        radius: 20,
                        fit: BoxFit.cover,
                      ),
                      4.width,
                      Marquee(child: Text('${booking.petName} (${booking.breed})', style: primaryTextStyle(size: 12), textAlign: TextAlign.right)).expand(flex: 6),
                    ],
                  ),
                  8.height,
                  detailWidgetPrice(title: locale.value.totalAmount, value: booking.payment.totalAmount, textColor: getPriceStatusColor(appointment: booking), isBoldText: true, image: Assets.iconsIcPrice),
                  detailWidget(image: Assets.iconsIcAddress, title: locale.value.location, value: getAddressByServiceElement(appointment: booking)),
                  detailWidget(image: Assets.iconsIcReason, title: locale.value.reason, value: booking.veterinaryReason).visible(booking.veterinaryReason.isNotEmpty),
                ],
              ).paddingSymmetric(horizontal: 8),
              if (booking.employeeId.isNegative && booking.status.contains(BookingStatusConst.PENDING))
                Row(
                  children: [
                    AppButton(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.only(right: 8, left: 8),
                        color: primaryColor,
                        textStyle: appButtonTextStyleWhite,
                        text: locale.value.accept,
                        onTap: () {
                          showConfirmDialogCustom(
                            getContext,
                            primaryColor: primaryColor,
                            negativeText: locale.value.cancel,
                            positiveText: locale.value.yes,
                            onAccept: (_) {
                              bookingController.acceptPublicBooking(bookingId: booking.id, onUpdateBooking: onUpdateBooking);
                            },
                            dialogType: DialogType.ACCEPT,
                            title: locale.value.doYouWantToAcceptBooking,
                          );
                        }).expand(),
                  ],
                )
              else if ((booking.status.contains(BookingStatusConst.PENDING) || booking.status.contains(BookingStatusConst.CONFIRMED) || booking.status.contains(BookingStatusConst.INPROGRESS))) ...[
                8.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (booking.status.contains(BookingStatusConst.PENDING))
                      AppButton(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          margin: const EdgeInsets.only(right: 8, left: 8),
                          color: primaryColor,
                          textStyle: appButtonTextStyleWhite,
                          text: locale.value.confirm,
                          onTap: () {
                            showConfirmDialogCustom(
                              getContext,
                              primaryColor: primaryColor,
                              negativeText: locale.value.cancel,
                              positiveText: locale.value.yes,
                              onAccept: (_) {
                                bookingController.updateBooking(
                                  bookingId: booking.id,
                                  status: BookingStatusConst.CONFIRMED,
                                  onUpdateBooking: onUpdateBooking,
                                );
                              },
                              dialogType: DialogType.ACCEPT,
                              title: "${locale.value.doYouWantToConfirmBooking}?",
                            );
                          }).expand(),
                    if (booking.status.contains(BookingStatusConst.PENDING) && !booking.payment.paymentStatus.toLowerCase().contains(PaymentStatus.PAID))
                      AppButton(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.only(right: 8, left: 8),
                        textStyle: appButtonTextStyleGray,
                        color: isDarkMode.value ? lightPrimaryColor2 : buttonLightColor,
                        text: locale.value.reject,
                        onTap: () {
                          showConfirmDialogCustom(getContext, primaryColor: primaryColor, negativeText: locale.value.cancel, positiveText: locale.value.yes, onAccept: (_) {
                            bookingController.updateBooking(
                              bookingId: booking.id,
                              status: BookingStatusConst.REJECTED,
                              onUpdateBooking: onUpdateBooking,
                            );
                          }, dialogType: DialogType.DELETE, title: "${locale.value.doYouWantToRejectBooking}?");
                        },
                      ).expand(),
                    AppButton(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(right: 8, left: 8),
                      text: locale.value.start,
                      width: Get.width,
                      color: primaryColor,
                      textStyle: appButtonTextStyleWhite,
                      onTap: () {
                        showConfirmDialogCustom(getContext, primaryColor: primaryColor, negativeText: locale.value.cancel, positiveText: locale.value.yes, onAccept: (_) {
                          bookingController.updateBooking(
                            bookingId: booking.id,
                            status: BookingStatusConst.INPROGRESS,
                            onUpdateBooking: onUpdateBooking,
                          );
                        }, dialogType: DialogType.ACCEPT, title: locale.value.doYouWantToStartBooking);
                      },
                    ).expand().visible(booking.status.contains(BookingStatusConst.CONFIRMED)),
                    AppButton(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(right: 8, left: 8),
                      text: locale.value.complete,
                      width: Get.width,
                      color: primaryColor,
                      textStyle: appButtonTextStyleWhite,
                      onTap: () {
                        showConfirmDialogCustom(getContext, primaryColor: primaryColor, negativeText: locale.value.cancel, positiveText: locale.value.yes, onAccept: (_) {
                          bookingController.updateBooking(
                            bookingId: booking.id,
                            status: BookingStatusConst.COMPLETED,
                            onUpdateBooking: onUpdateBooking,
                          );
                        }, dialogType: DialogType.ACCEPT, title: locale.value.doYouWantToCompleteBooking);
                      },
                    ).expand().visible(booking.status.contains(BookingStatusConst.INPROGRESS)),
                    AppButton(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(right: 8, left: 8),
                      text: locale.value.call,
                      width: Get.width,
                      color: lightPrimaryColor,
                      textStyle: appButtonPrimaryColorText,
                      onTap: () {
                        launchCall((booking.customerContact));
                      },
                    ).expand(),
                  ],
                ),
              ],
              16.height,
            ]),
          ),
        ],
      ),
    );
  }

  String get scheduleDate {
    try {
      return booking.startDateTime.isValidDateTime ? booking.startDateTime.dateInddMMMyyyyHHmmAmPmFormat : " - ";
    } catch (e) {
      log('get scheduleDate E: $e');
      return " - ";
    }
  }

  Widget detailWidget({required String image, required String title, required String value, Color? textColor}) {
    return Row(
      children: [
        4.width,
        Image.asset(
          image,
          width: 15,
          height: 15,
          color: switchColor,
        ),
        4.width,
        Marquee(child: Text(title, style: secondaryTextStyle(), textAlign: TextAlign.left)).expand(flex: 3),
        Text(":", style: secondaryTextStyle()),
        10.width,
        Marquee(child: Text(value, style: primaryTextStyle(size: 12, color: textColor), textAlign: TextAlign.right)).expand(flex: 6),
      ],
    ).paddingBottom(8).visible(value.isNotEmpty);
  }

  Widget detailWidgetPrice({required String image, required String title, required num value, Color? textColor, bool isBoldText = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        4.width,
        Image.asset(
          image,
          width: 15,
          height: 15,
          color: switchColor,
        ),
        4.width,
        Marquee(child: Text(title, style: secondaryTextStyle(), textAlign: TextAlign.left)).expand(flex: 3),
        Text(":", style: secondaryTextStyle()),
        10.width,
        PriceWidget(
          price: value,
          color: textColor ?? black,
          size: 12,
          isBoldText: isBoldText,
        ).expand(flex: 6)
      ],
    ).paddingBottom(10);
  }
}
