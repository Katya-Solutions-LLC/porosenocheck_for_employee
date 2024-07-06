import 'package:get/get.dart';

import '../../../../models/review_data.dart';
import '../services/order_service_api.dart';

class OrderReviewController extends GetxController {
  Rx<Future<List<ReviewData>>> getOrderReview = Future(() => <ReviewData>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;
  RxList<ReviewData> orderReview = RxList();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await getOrderReview(OrderAPIs.getOrderReviews(
      page: page.value,
      reviews: orderReview,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }
}
