import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/review_data.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../home/home_controller.dart';
import '../model/bookings_model.dart';
import '../model/save_payment_req.dart';
import '../services/booking_api.dart';

class BookingDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool hasReview = false.obs;
  RxBool showWriteReview = false.obs;
  Rx<ReviewData> yourReview = ReviewData().obs;

  TextEditingController paymentMethod = TextEditingController();
  RxDouble selectedRating = (0.0).obs;
  TextEditingController reviewCont = TextEditingController();
  Rx<BookingDataModel> bookingArgumentData = BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training()).obs;
  Rx<BookingDataModel> bookingDetail = BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training()).obs;

  //Get Facility List
  RxList<FacilityModel> facilities = RxList();

  int rating = 0;

  @override
  void onInit() {
    // getFacilityList();
    if (Get.arguments is BookingDataModel) {
      bookingArgumentData(Get.arguments as BookingDataModel);
      bookingDetail(bookingArgumentData.value);
    }
    getBookingDetail(bookingId: bookingArgumentData.value.id);
    super.onInit();
  }

  updateBooking({required int bookingId, required String status, VoidCallback? onUpdateBooking}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      "id": bookingId,
      "status": status,
    };

    await BookingApi.updateBooking(request: req).then((value) async {
      if (onUpdateBooking != null) {
        onUpdateBooking.call();
      }
      try {
        HomeController hCont = Get.find();
        hCont.init();
      } catch (e) {
        log('onItemSelected Err: $e');
      }
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  savePaymentApi() {
    isLoading(true);
    hideKeyBoardWithoutContext();

    BookingApi.savePayment(
      request: SavePaymentReq(
        bookingId: bookingDetail.value.id,
        externalTransactionId: "",
        paymentID: bookingDetail.value.payment.id,
        transactionType: PaymentMethods.PAYMENT_METHOD_CASH,
        paymentStatus: 1,
        totalAmount: bookingDetail.value.payment.totalAmount,
      ).toJson(),
    ).then((value) async {
      getBookingDetail(bookingId: bookingArgumentData.value.id);
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    }); //
  }

  ///Get Booking Detail
  getBookingDetail({required int bookingId}) {
    isLoading(true);
    BookingApi.getBookingDetail(bookingId: bookingId, noteId: bookingDetail.value.notificationId).then((value) {
      isLoading(false);
      bookingDetail(value.data);
      bookingDetail.value.id = bookingArgumentData.value.id;
      facilities(bookingDetail.value.additionalFacility);
      hasReview(value.customerReview != null);
      if (value.customerReview != null) {
        yourReview(value.customerReview);
      }
    }).onError((error, stackTrace) {
      isLoading(false);
      // toast(error.toString());
    });
  }

  saveReview() async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      "id": yourReview.value.id.isNegative ? "" : yourReview.value.id,
      "employee_id": bookingDetail.value.employeeId,
      "rating": selectedRating.value,
      "review_msg": reviewCont.text.trim(),
    };

    await BookingApi.updateReview(request: req).then((value) async {
      log('updateReview: ${value.toJson()}');
      showWriteReview(false);
      yourReview(ReviewData(
        rating: selectedRating.value,
        userId: loginUserData.value.id,
        reviewMsg: reviewCont.text.trim(),
        username: loginUserData.value.userName,
        employeeId: bookingDetail.value.employeeId,
      ));
      getBookingDetail(bookingId: bookingArgumentData.value.id);
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  void handleEditReview() {
    showWriteReview(true);
    reviewCont.text = yourReview.value.reviewMsg;
    selectedRating(yourReview.value.rating.toDouble());
  }

  deleteReview() async {
    isLoading(true);
    await BookingApi.deleteReview(id: yourReview.value.id).then((value) async {
      log('updateReview: ${value.toJson()}');
      showWriteReview(false);
      hasReview(false);
      reviewCont.text = "";
      selectedRating(0);
      yourReview(ReviewData());
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      // toast(e.toString(), print: true);
    });
  }
}

Color getRatingBarColor(num starNumber) {
  // if (starNumber <= rating) {
  /* if (starNumber == 5) {
    return ratingFirstColor;
  } else if (starNumber >= 3 || starNumber >= 4) {
    return ratingSecondColor;
  } else if (starNumber >= 2 || starNumber >= 1) {
    return ratingThirdColor;
  }
  return ratingFourthColor;*/
  if (starNumber >= 4 || starNumber >= 5) {
    return ratingFirstColor;
  } else if (starNumber >= 3) {
    return ratingSecondColor;
  } else if (starNumber >= 2) {
    return ratingFifthColor;
  } else if (starNumber >= 1) {
    return ratingThirdColor;
  }
  return ratingFourthColor;
}
