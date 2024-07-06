import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/empty_error_state_widget.dart';

import '../../home/model/status_list_res.dart';
import '../model/bookings_model.dart';
import '../services/booking_api.dart';
import 'bookings_card.dart';

class BookingListComponent extends StatefulWidget {
  final StatusModel bookingStatusData;

  const BookingListComponent({super.key, required this.bookingStatusData});

  @override
  State<BookingListComponent> createState() => _BookingListComponentState();
}

class _BookingListComponentState extends State<BookingListComponent> {
  Rx<Future<List<BookingDataModel>>> future = Future(() => <BookingDataModel>[]).obs;

  List<BookingDataModel> bookings = [];

  int page = 1;
  int selectedIndex = 1;

  bool isLastPage = false;

  RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init({String search = '', bool showloader = true}) async {
    if (showloader) {
      isLoading(true);
    }
    await future(BookingApi.getBookingList(
      bookingType: widget.bookingStatusData.status,
      page: page,
      bookings: bookings,
      lastPageCallBack: (p) {
        isLastPage = p;
      },
    )).whenComplete(() => isLoading(false));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => SnapHelperWidget<List<BookingDataModel>>(
            future: future.value,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  page = 1;

                  init();
                },
              );
            },
            loadingWidget: const LoaderWidget(),
            onSuccess: (bookingList) {
              return AnimatedListView(
                shrinkWrap: true,
                itemCount: bookingList.length,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                emptyWidget: NoDataWidget(
                  title: locale.value.noBookingsFound,
                  imageWidget: const EmptyStateWidget(),
                  subTitle: locale.value.thereAreCurrentlyNo,
                  retryText: locale.value.reload,
                  onRetry: () {
                    page = 1;
                    init();
                  },
                ).paddingSymmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return BookingsCard(
                    booking: bookingList[index],
                    onUpdateBooking: () {
                      bookingList.removeAt(index);
                      setState(() {});
                    },
                  );
                },
                onNextPage: () {
                  if (!isLastPage) {
                    page++;
                    log('PAGE: $page');
                    init();
                  }
                },
                onSwipeRefresh: () async {
                  page = 1;
                  return await init(showloader: false);
                },
              );
            },
          ),
        ),
        Obx(() => const LoaderWidget().center().visible(isLoading.value)),
      ],
    );
  }
}
