import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/constants.dart';
import '../../utils/local_storage.dart';
import '../pet_store/model/pet_store_dashboard_model.dart';
import 'dashboard_controller.dart';
import 'model/dashboard_res_model.dart';
import 'services/home_service_api.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Future<DashboardRes>> getDashboardDetailFuture = Future(() => DashboardRes(data: DashboardData(petstoreDetail: PetStoreDetail()))).obs;
  Rx<DashboardData> dashboardData = DashboardData(petstoreDetail: PetStoreDetail()).obs;

  @override
  void onReady() {
    init();
    super.onReady();
  }

  void init() {
    try {
      final dashboardResFromLocal = getValueFromLocal(APICacheConst.DASHBOARD_RESPONSE);
      getAppConfigurations();
      if (dashboardResFromLocal != null) {
        handleDashboardRes(DashboardRes.fromJson(dashboardResFromLocal));
      }
    } catch (e) {
      log('handleDashboardRes from cache E: $e');
    }
    getDashboardDetail();
  }

  ///Get ChooseService List
  getDashboardDetail({bool isFromSwipeRefresh = false}) async {
    if (!isFromSwipeRefresh) {
      isLoading(true);
      getAppConfigurations();
    }
    await getDashboardDetailFuture(HomeServiceApi.getDashboard()).then((value) {
      handleDashboardRes(value);
      try {
        setValueToLocal(APICacheConst.DASHBOARD_RESPONSE, value.toJson());
      } catch (e) {
        log('store DASHBOARD_RESPONSE E: $e');
      }
    }).whenComplete(() => isLoading(false));
  }

  void handleDashboardRes(DashboardRes value) {
    dashboardData(value.data);
  }
}
