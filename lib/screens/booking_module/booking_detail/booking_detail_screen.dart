import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/utils/app_common.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../../auth/model/pet_note_model.dart';
import '../../auth/other/pet_profile/pet_profile_screen.dart';
import 'booking_detail_controller.dart';

class BookingDetailScreen extends StatelessWidget {
  final VoidCallback? onUpdateBooking;
  BookingDetailScreen({super.key, this.onUpdateBooking});

  final BookingDetailsController bookingController = Get.put(BookingDetailsController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: Hero(
        tag: '#${bookingController.bookingArgumentData.value.id}',
        child: Text(
          '#${bookingController.bookingArgumentData.value.id} - ${bookingController.bookingDetail.value.service.name}',
          style: primaryTextStyle(size: 16, decoration: TextDecoration.none),
        ),
      ),
      isLoading: bookingController.isLoading,
      body: RefreshIndicator(
        onRefresh: () async {
          bookingController.getBookingDetail(bookingId: bookingController.bookingArgumentData.value.id);
          return await Future.delayed(const Duration(seconds: 2));
        },
        child: AnimatedScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          children: [
            Obx(
              () => bookingController.isLoading.value
                  ? const SizedBox()
                  : bookingController.bookingDetail.value.service.id.isNegative
                      ? NoDataWidget(
                          title: locale.value.noBookingDetailsFound,
                          imageWidget: const EmptyStateWidget(),
                          subTitle: "${locale.value.thereAreCurrentlyNoDetails} \n${locale.value.bookingId} ${bookingController.bookingDetail.value.id}. ${locale.value.tryReloadOrCheckingLater}.",
                          retryText: locale.value.reload,
                          onRetry: () {
                            bookingController.getBookingDetail(bookingId: bookingController.bookingDetail.value.id);
                          },
                        ).paddingSymmetric(horizontal: 32).paddingTop(Get.height * 0.20)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            Text(locale.value.bookingInformation, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                            8.height,
                            Container(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: boxDecorationDefault(
                                shape: BoxShape.rectangle,
                                color: context.cardColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.boarding)) ...[
                                    detailWidget(title: locale.value.arrivalDate, value: bookingController.bookingDetail.value.dropoffDateTime.isValidDateTime ? bookingController.bookingDetail.value.dropoffDateTime.dateInDMMMMyyyyFormat : ""),
                                    detailWidget(title: locale.value.arrivalTime, value: bookingController.bookingDetail.value.dropoffDateTime.isValidDateTime ? "At ${bookingController.bookingDetail.value.dropoffDateTime.timeInHHmmAmPmFormat}" : ""),
                                    detailWidget(title: locale.value.leaveDate, value: bookingController.bookingDetail.value.pickupDateTime.isValidDateTime ? bookingController.bookingDetail.value.pickupDateTime.dateInDMMMMyyyyFormat : ""),
                                    detailWidget(title: locale.value.leaveTime, value: bookingController.bookingDetail.value.pickupDateTime.isValidDateTime ? "At ${bookingController.bookingDetail.value.pickupDateTime.timeInHHmmAmPmFormat}" : ""),
                                  ],
                                  if (bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.dayCare)) ...[
                                    detailWidget(title: locale.value.date, value: bookingController.bookingDetail.value.dayCareDate.isValidDateTime ? bookingController.bookingDetail.value.dayCareDate.dateInDMMMMyyyyFormat : ""),
                                    detailWidget(
                                      title: locale.value.time,
                                      value: bookingController.bookingDetail.value.dropoffTime.isValidTime ? "At ${"1970-01-01 ${bookingController.bookingDetail.value.dropoffTime}".timeInHHmmAmPmFormat}" : "",
                                    ),
                                    detailWidget(
                                      title: locale.value.leaveTime,
                                      value: bookingController.bookingDetail.value.pickupTime.isValidTime ? "At ${"1970-01-01 ${bookingController.bookingDetail.value.pickupTime}".timeInHHmmAmPmFormat}" : "",
                                    ),
                                  ],
                                  if (!(bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.boarding) || bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.dayCare))) ...[
                                    detailWidget(title: locale.value.date, value: bookingController.bookingDetail.value.serviceDateTime.isValidDateTime ? bookingController.bookingDetail.value.serviceDateTime.dateInDMMMMyyyyFormat : ""),
                                    detailWidget(title: locale.value.time, value: bookingController.bookingDetail.value.serviceDateTime.isValidDateTime ? "At ${bookingController.bookingDetail.value.serviceDateTime.timeInHHmmAmPmFormat}" : ""),
                                  ],
                                  detailServiceWidget(title: locale.value.service, value: bookingController.bookingDetail.value.veterinaryServiceName),
                                  detailWidget(title: locale.value.duration, value: bookingController.bookingDetail.value.duration.toFormattedDuration(showFullTitleHoursMinutes: true)),
                                  detailWidget(
                                      title: locale.value.bookingStatus,
                                      value: getBookingStatusEmployee(status: bookingController.bookingDetail.value.status.capitalizeFirstLetter()),
                                      textColor: getBookingStatusColor(status: bookingController.bookingDetail.value.status)),
                                  detailWidget(
                                      title: locale.value.paymentStatus,
                                      value: getBookingPaymentStatus(status: bookingController.bookingDetail.value.payment.paymentStatus.capitalizeFirstLetter()),
                                      textColor: getPriceStatusColor(appointment: bookingController.bookingDetail.value)),
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 16),
                            32.height,
                            Text(locale.value.customerInformation, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                            8.height,
                            Container(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: boxDecorationDefault(
                                shape: BoxShape.rectangle,
                                color: context.cardColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(locale.value.customerName, style: secondaryTextStyle()),
                                      const Spacer(),
                                      CachedImageWidget(
                                        url: bookingController.bookingDetail.value.customerImage,
                                        height: 20,
                                        width: 20,
                                        circle: true,
                                        radius: 20,
                                        fit: BoxFit.cover,
                                      ),
                                      8.width,
                                      Text(bookingController.bookingDetail.value.customerName, style: primaryTextStyle(size: 12)),
                                    ],
                                  ),
                                  10.height,
                                  detailWidget(title: locale.value.favoriteFood, value: bookingController.bookingDetail.value.food.isNotEmpty ? bookingController.bookingDetail.value.food.first : ""),
                                  detailWidget(title: locale.value.favoriteActivity, value: bookingController.bookingDetail.value.activity.isNotEmpty ? bookingController.bookingDetail.value.activity.first : ""),
                                  detailWidget(title: locale.value.contactNumber, value: bookingController.bookingDetail.value.customerContact),
                                  detailWidget(title: locale.value.reason, value: bookingController.bookingDetail.value.veterinaryReason).visible(bookingController.bookingDetail.value.veterinaryReason.isNotEmpty),
                                  4.height.visible(getAddressByServiceElement(appointment: bookingController.bookingDetail.value).isNotEmpty && bookingController.bookingDetail.value.customerName.trim().isNotEmpty),
                                  detailWidget(title: locale.value.address, value: getAddressByServiceElement(appointment: bookingController.bookingDetail.value)),
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 16),
                            Obx(() => bookingController.bookingDetail.value.petDetails != null ? petInfoWidget(context) : const Offstage()),
                            32.height,
                            Text(locale.value.paymentDetails, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                            8.height,
                            Container(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: boxDecorationDefault(
                                shape: BoxShape.rectangle,
                                color: context.cardColor,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  detailWidgetPrice(title: locale.value.price, value: bookingController.bookingDetail.value.price, textColor: textPrimaryColorGlobal),
                                  ...List.generate(
                                    bookingController.bookingDetail.value.payment.taxs.length,
                                    (index) => detailWidgetPrice(
                                      title: bookingController.bookingDetail.value.payment.taxs[index].title,
                                      value: bookingController.bookingDetail.value.payment.taxs[index].value,
                                      textColor: isDarkMode.value ? textPrimaryColorGlobal : primaryColor,
                                    ),
                                  ),
                                  detailWidgetPrice(
                                      title: locale.value.totalAmount, value: bookingController.bookingDetail.value.payment.totalAmount, textColor: getPriceStatusColor(appointment: bookingController.bookingDetail.value), isBoldText: true),
                                  6.height,
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 16),
                            serviceInfoWidget(context).visible(bookingController.bookingDetail.value.service.slug.contains(ServicesKeyConst.training)),
                            Obx(() => bookingController.bookingDetail.value.petDetails != null && bookingController.bookingDetail.value.petDetails!.petNotes.isNotEmpty ? petNotes(context) : const Offstage()),
                            Obx(() => zoomVideoCallBtn(context).visible(
                                  bookingController.bookingDetail.value.joinVideoLink.isNotEmpty &&
                                      bookingController.bookingDetail.value.startVideoLink.isNotEmpty &&
                                      bookingController.bookingDetail.value.status.toLowerCase().contains(StatusConst.confirmed.toLowerCase()),
                                )),
                            if (bookingController.bookingDetail.value.status.contains(BookingStatusConst.INPROGRESS)) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  32.height,
                                  AppButton(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      margin: const EdgeInsets.only(right: 8, left: 8),
                                      text: locale.value.complete,
                                      width: Get.width,
                                      color: primaryColor,
                                      textStyle: appButtonTextStyleWhite,
                                      onTap: () {
                                        bookingController.updateBooking(
                                          bookingId: bookingController.bookingDetail.value.id,
                                          status: BookingStatusConst.COMPLETED,
                                          onUpdateBooking: onUpdateBooking,
                                        );
                                      }),
                                ],
                              ).paddingSymmetric(horizontal: 8).visible(bookingController.bookingDetail.value.status.contains(BookingStatusConst.INPROGRESS)),
                            ],
                            Obx(() => confirmPaymentBtn(context)
                                .visible(!bookingController.bookingDetail.value.payment.paymentStatus.contains(PaymentStatus.PAID) && bookingController.bookingDetail.value.status.toLowerCase().contains(StatusConst.completed.toLowerCase()))),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget petInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Text(locale.value.petInformation, style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
        8.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => PetProfileScreen(petData: bookingController.bookingDetail.value.petDetails!), arguments: bookingController.bookingDetail.value.petDetails!.id);
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.value.petName, style: secondaryTextStyle()),
                    const Spacer(),
                    Row(
                      children: [
                        CachedImageWidget(
                          url: bookingController.bookingDetail.value.petImage,
                          height: 20,
                          width: 20,
                          circle: true,
                          radius: 20,
                          fit: BoxFit.cover,
                        ),
                        8.width,
                      ],
                    ),
                    Text(bookingController.bookingDetail.value.petName, textAlign: TextAlign.right, style: primaryTextStyle(size: 12)),
                  ],
                ),
              ),
              8.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  detailWidget(title: locale.value.breed, value: bookingController.bookingDetail.value.petDetails!.breed),
                  detailWidget(title: locale.value.gender, value: bookingController.bookingDetail.value.petDetails!.gender.capitalizeFirstLetter()),
                  detailWidget(title: locale.value.weight, value: "${bookingController.bookingDetail.value.petDetails!.weight} ${bookingController.bookingDetail.value.petDetails!.weightUnit}"),
                  detailWidget(title: locale.value.height, value: "${bookingController.bookingDetail.value.petDetails!.height} ${bookingController.bookingDetail.value.petDetails!.heightUnit}"),
                ],
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget petNotes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(locale.value.petNotes, style: primaryTextStyle()),
            SizedBox(
              height: 23,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(lightPrimaryColor2), padding: const MaterialStatePropertyAll(EdgeInsets.zero)),
                onPressed: () {
                  Get.to(() => PetProfileScreen(petData: bookingController.bookingDetail.value.petDetails!), arguments: bookingController.bookingDetail.value.petDetails!.id);
                },
                child: Text(locale.value.seePetProfile, style: secondaryTextStyle(color: primaryColor)).paddingSymmetric(horizontal: 8, vertical: 2),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
        8.height,
        Obx(
          () => AnimatedListView(
            shrinkWrap: true,
            itemCount: bookingController.bookingDetail.value.petDetails!.petNotes.reversed.take(2).length,
            listAnimationType: ListAnimationType.FadeIn,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext contex, index) {
              NotePetModel notePetModel = bookingController.bookingDetail.value.petDetails!.petNotes.reversed.toList()[index];
              return Container(
                decoration: boxDecorationDefault(color: context.cardColor),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CachedImageWidget(
                                  url: notePetModel.createdbyUser.profileImage,
                                  height: 22,
                                  width: 22,
                                  circle: true,
                                  radius: 22,
                                  fit: BoxFit.cover,
                                ),
                                12.width,
                                Text(notePetModel.createdbyUser.userName, style: secondaryTextStyle()),
                              ],
                            ),
                          ],
                        ).paddingBottom(16),
                        Text(notePetModel.title, textAlign: TextAlign.left, style: primaryTextStyle()),
                        8.height,
                        Text(notePetModel.description, textAlign: TextAlign.left, style: secondaryTextStyle()),
                      ],
                    ).paddingAll(16).expand(),
                  ],
                ),
              ).paddingTop(index == 0 ? 0 : 12);
            },
          ).paddingSymmetric(horizontal: 16),
        )
      ],
    );
  }

  bool get showBookingDetail => bookingController.bookingDetail.value.duration.toFormattedDuration(showFullTitleHoursMinutes: true).isNotEmpty || getAddressByServiceElement(appointment: bookingController.bookingDetail.value).isNotEmpty;

  Widget detailWidget({required String title, required String value, Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: secondaryTextStyle()).expand(),
        Text(value, textAlign: TextAlign.right, style: primaryTextStyle(size: 12, color: textColor)).expand(),
      ],
    ).paddingBottom(10).visible(value.isNotEmpty);
  }

  Widget detailServiceWidget({required String title, required String value, Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: secondaryTextStyle()).expand(),
        Text(value, textAlign: TextAlign.right, style: primaryTextStyle(size: 12, color: textColor)).expand(),
      ],
    ).paddingBottom(10).visible(value.isNotEmpty);
  }

  Widget detailWidgetPrice({required String title, required num value, Color? textColor, bool isBoldText = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: secondaryTextStyle()),
        PriceWidget(
          price: value,
          color: textColor ?? black,
          size: 12,
          isBoldText: isBoldText,
        )
      ],
    ).paddingBottom(10);
  }

  Widget confirmPaymentBtn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        AppButton(
          width: Get.width,
          text: locale.value.confirmCashPayment,
          textStyle: appButtonTextStyleWhite,
          color: completedStatusColor,
          onTap: () {
            showConfirmDialogCustom(getContext, primaryColor: primaryColor, negativeText: locale.value.cancel, positiveText: locale.value.yes, onAccept: (_) {
              bookingController.savePaymentApi();
            }, dialogType: DialogType.ACCEPT, title: "${locale.value.doYouWantToConfirmPayment}?");
          },
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget zoomVideoCallBtn(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          AppButton(
            width: Get.width,
            text: locale.value.zoomVideoCall,
            textStyle: appButtonTextStyleGray,
            color: isDarkMode.value ? context.cardColor : buttonLightColor,
            onTap: () {
              commonLaunchUrl(bookingController.bookingDetail.value.startVideoLink, launchMode: LaunchMode.externalApplication);
            },
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  Widget serviceInfoWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        32.height,
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: boxDecorationDefault(
            shape: BoxShape.rectangle,
            color: context.cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bookingController.bookingDetail.value.training.name, style: primaryTextStyle()).visible(bookingController.bookingDetail.value.training.name.isNotEmpty),
              4.height,
              Text(bookingController.bookingDetail.value.training.description, style: secondaryTextStyle()).visible(bookingController.bookingDetail.value.training.description.isNotEmpty),
              4.height,
            ],
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
