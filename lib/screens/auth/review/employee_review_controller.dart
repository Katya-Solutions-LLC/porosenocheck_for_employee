import 'package:get/get.dart';

import '../../../models/review_data.dart';
import '../../../utils/constants.dart';
import '../../booking_module/services/booking_api.dart';

class EmployeeReviewController extends GetxController {
  Rx<Future<List<ReviewData>>> getReview = Future(() => <ReviewData>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;
  RxList<ReviewData> employeeReview = RxList();
  RxList<String> reviewStatus = [ReviewStatus.ByService, ReviewStatus.ByOrder].obs;
  RxSet<String> selectedIndex = RxSet();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await getReview(BookingApi.getEmployeeReviews(
      filterByStatus: selectedIndex.join(","),
      page: page.value,
      reviews: employeeReview,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }
}
