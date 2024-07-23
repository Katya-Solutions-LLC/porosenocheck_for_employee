import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/add_services_forms/service_api.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../utils/app_common.dart';
import '../../utils/constants.dart';
import 'model/service_list_model.dart';

class ServiceListController extends GetxController {
  // Rx<Future<List<ServiceData>>> getServices = Future(() => <ServiceData>[]).obs;
  Rx<Future<RxList<ServiceData>>> getServices = Future(() => RxList<ServiceData>()).obs;
  RxList<ServiceData> serviceList = RxList();
  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxBool isSearchServiceText = false.obs;

  TextEditingController searchServiceCont = TextEditingController();
  RxString selectedFilterStatus = ServiceFilterStatusConst.addedByMe.obs;

  RxList<String> allServiceFilterStatus = RxList([
    ServiceFilterStatusConst.addedByMe,
    ServiceFilterStatusConst.assignByAdmin,
    ServiceFilterStatusConst.all,
  ]);

  StreamController<String> searchServiceStream = StreamController<String>();
  final _scrollController = ScrollController();

  @override
  void onReady() {
    _scrollController.addListener(() => Get.context != null ? hideKeyboard(Get.context) : null);
    searchServiceStream.stream.debounce(const Duration(seconds: 1)).listen((s) {
      getServiceList();
    });
    getServiceList();
    super.onReady();
  }

  /*@override
  void onInit() {
    init();
    super.onInit();
  }*/

  getServiceList({bool showloader = true, String search = ""}) {
    if (showloader) {
      isLoading(true);
    }
    getServices(ServiceFormApis.getServiceList(
      filterByServiceStatus: selectedFilterStatus.value,
      employeeId: loginUserData.value.id,
      serviceList: serviceList,
      page: page.value,
      search: searchServiceCont.text.trim(),
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    )).whenComplete(() => isLoading(false));
  }

  /*Future<void> init() async {
    await getServices(ServiceFormApis.getServiceList(
      filterByServiceStatus: selectedFilterStatus.value,
      employeeId: loginUserData.value.id,
      serviceList: serviceList,
      search: searchServiceCont.text.trim(),
      page: page.value,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }*/

  @override
  void onClose() {
    searchServiceStream.close();
    if (Get.context != null) {
      _scrollController.removeListener(() => hideKeyboard(Get.context));
    }
    super.onClose();
  }
}
