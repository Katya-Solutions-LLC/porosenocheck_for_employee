import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../home/home_controller.dart';
import '../model/bookings_model.dart';
import 'package:stream_transform/stream_transform.dart';
import '../services/booking_api.dart';

class BookingsController extends GetxController {
  Rx<Future<RxList<BookingDataModel>>> getBookingsFuture = Future(() => RxList<BookingDataModel>()).obs;
  RxList<BookingDataModel> bookings = RxList();
  RxBool isLoading = false.obs;
  RxBool isRefresh = false.obs;
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;

  TextEditingController searchCont = TextEditingController();
  RxSet<String> selectedStatus = RxSet();
  RxSet<String> selectedService = RxSet();
  RxBool isSearchText = false.obs;
  StreamController<String> searchStream = StreamController<String>();
  final _scrollController = ScrollController();
  RxBool isFromNearByBooking = false.obs;

  @override
  void onReady() {
    _scrollController.addListener(() => Get.context != null ? hideKeyboard(Get.context) : null);
    searchStream.stream.debounce(const Duration(seconds: 1)).listen((s) {
      getBookingList();
    });
    getBookingList();
    super.onReady();
  }

  getBookingList({bool showloader = true, String search = "", bool isNearByBooking = false}) {
    isFromNearByBooking(isNearByBooking);
    if (showloader) {
      isLoading(true);
    }
    getBookingsFuture(BookingApi.getBookingFilterList(
      filterByStatus: selectedStatus.join(","),
      filterByService: selectedService.join(","),
      isNearByBooking: isNearByBooking,
      page: page.value,
      search: searchCont.text.trim(),
      bookings: bookings,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    )).whenComplete(() => isLoading(false));
  }

  updateBooking({required int bookingId, required String status, VoidCallback? onUpdateBooking}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    try {
      Get.find<HomeController>().isLoading(true);
    } catch (e) {
      log('HomeController Get.find() Err: $e');
    }
    Map<String, dynamic> req = {
      "id": bookingId,
      "status": status,
    };
    await BookingApi.updateBooking(request: req).then((value) async {
      if (onUpdateBooking != null) {
        onUpdateBooking.call();
      }
      try {
        Get.find<HomeController>().getDashboardDetail();
      } catch (e) {
        log('HomeController Get.find() Err: $e');
      }
    }).catchError(
      (e) {
        toast(e.toString(), print: true);
      },
    ).whenComplete(() {
      try {
        Get.find<HomeController>().isLoading(true);
      } catch (e) {
        log('HomeController Get.find() Err: $e');
      }
      isLoading(false);
    });
  }

  acceptPublicBooking({required int bookingId, VoidCallback? onUpdateBooking}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    try {
      Get.find<HomeController>().isLoading(true);
    } catch (e) {
      log('HomeController Get.find() Err: $e');
    }

    await BookingApi.acceptBookingRequest(bookingId: bookingId).then((value) async {
      if (onUpdateBooking != null) {
        onUpdateBooking.call();
      }
      try {
        Get.find<HomeController>().getDashboardDetail();
      } catch (e) {
        log('HomeController Get.find() Err: $e');
      }
    }).catchError(
      (e) {
        toast(e.toString(), print: true);
      },
    ).whenComplete(() {
      try {
        Get.find<HomeController>().isLoading(true);
      } catch (e) {
        log('HomeController Get.find() Err: $e');
      }
      isLoading(false);
    });
  }

  String scheduleDate(BookingDataModel appointment) {
    try {
      if (appointment.service.slug.contains(ServicesKeyConst.boarding)) {
        return appointment.dropoffDateTime.isValidDateTime ? appointment.dropoffDateTime : " - ";
      } else {
        return appointment.serviceDateTime.isValidDateTime ? appointment.serviceDateTime : " - ";
      }
    } catch (e) {
      log('scheduleDate E: $e');
      return " - ";
    }
  }

  @override
  void onClose() {
    searchStream.close();
    if (Get.context != null) {
      _scrollController.removeListener(() => hideKeyboard(Get.context));
    }
    super.onClose();
  }
}
