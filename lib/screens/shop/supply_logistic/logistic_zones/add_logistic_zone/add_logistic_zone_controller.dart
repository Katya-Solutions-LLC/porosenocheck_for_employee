import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/screens/shop/supply_logistic/logistics/model/logistic_list_response.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';
import 'package:porosenocheckemployee/utils/constants.dart';

import '../../../../../main.dart';
import '../../logistics/services/logistic_api.dart';
import '../model/city_list_response.dart';
import '../model/country_list_response.dart';
import '../model/logistic_zone_list_response.dart';
import '../model/state_list_response.dart';
import '../services/logistics_zone_api.dart';

class AddLogisticZoneController extends RxController {
  TextEditingController nameCont = TextEditingController();
  TextEditingController logisticCont = TextEditingController();
  TextEditingController countryCont = TextEditingController();
  TextEditingController stateCont = TextEditingController();
  TextEditingController cityCont = TextEditingController();
  TextEditingController deliveryChargeCont = TextEditingController(text: "0");
  TextEditingController deliveryTimeCont = TextEditingController();

  Rx<LogisticData> selectedLogisticData = LogisticData(id: -1).obs;
  Rx<CountryData> selectedCountry = CountryData(id: -1).obs;
  Rx<StateData> selectedState = StateData(id: -1).obs;
  RxList<CityData> selectedCities = RxList([CityData(id: -1)]);
  RxList<String> selectedCitiesName = RxList();

  Rx<LogisticZoneData> logisticZone = LogisticZoneData(id: -1).obs;

  RxInt page = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxBool hasError = false.obs;
  RxBool isEdit = false.obs;
  RxString errorMessage = "".obs;

  Rx<Future<RxList<LogisticData>>> getLogisticList = Future(() => RxList<LogisticData>()).obs;
  List<LogisticData> logisticList = [];

  RxList<CountryData> countryList = RxList();
  RxList<StateData> stateList = RxList();
  RxList<CityData> cityList = RxList();

  @override
  Future<void> onInit() async {
    if (Get.arguments is LogisticZoneData) {
      logisticZone(Get.arguments as LogisticZoneData);
      isEdit(true);

      nameCont.text = logisticZone.value.name;
      deliveryChargeCont.text = logisticZone.value.standardDeliveryCharge.toString().validate();
      deliveryTimeCont.text = logisticZone.value.standardDeliveryTime.validate();
      await getLogistics(logisticId: logisticZone.value.logisticId, showLoader: true);
    } else {
      getLogistics();
    }
    getCounties();
    super.onInit();
  }

  //region Get Country's
  getCounties({bool showLoader = true, int? countryId}) {
    if (showLoader) {
      isLoading(true);
    }
    LogisticZoneAPI.getCountryList().then((res) {
      countryList.clear();
      countryList.addAll(res.data.obs);

      if (isEdit.value) {
        for (var element in countryList) {
          if (element.id == logisticZone.value.countryId) {
            selectedCountry = element.obs;
            countryCont.text = element.name;
          }
        }

        getStates(countryId: logisticZone.value.countryId);
      }
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }

  //endregion

  //region Get State's
  getStates({bool showLoader = true, int? countryId}) {
    if (showLoader) {
      isLoading(true);
    }
    LogisticZoneAPI.getStateList(countryId: countryId!).then((res) {
      stateList.clear();
      stateList.addAll(res.data.obs);

      if (isEdit.value) {
        for (var element in stateList) {
          if (element.id == logisticZone.value.stateId) {
            selectedState = element.obs;
            stateCont.text = element.name;
          }
        }

        getCities(stateId: logisticZone.value.stateId);
      }
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }

  //endregion

  //region Get Cities
  getCities({bool showLoader = true, int? stateId}) {
    if (showLoader) {
      isLoading(true);
    }
    LogisticZoneAPI.getCityList(stateId: stateId!).then((res) {
      cityList.clear();
      cityList.addAll(res.data.obs);
      selectedCities.clear();

      if (isEdit.value) {
        for (var e1 in cityList) {
          for (var e2 in logisticZone.value.cities) {
            if (e1.id == e2.id) {
              e1.isSelected = true;
              selectedCities.add(e1);
            }
          }
        }

        selectedCitiesName.clear();
        for (var e3 in selectedCities) {
          selectedCitiesName.add(e3.name);
        }

        cityCont.text = selectedCitiesName.join(',');
      }
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }

  //endregion

  //region Get Logistic's
  getLogistics({bool showLoader = true, int? logisticId = -1}) async {
    if (showLoader) {
      isLoading(true);
    }

    await getLogisticList(
      LogisticAPI.getLogistics(
        filterByServiceStatus: ServiceFilterStatusConst.all,
        employeeId: loginUserData.value.id,
        page: page.value,
        perPage: PER_PAGE_ALL,
        logisticList: logisticList,
        lastPageCallBack: (p) {
          isLastPage(p);
        },
      ),
    ).then((value) {}).catchError((e) {
      toast(e.toString(), print: true);
      log('Error: $e');
    }).whenComplete(() => isLoading(false));

    if (isEdit.value) {
      for (var e in logisticList) {
        if (e.id == logisticZone.value.logisticId) {
          selectedLogisticData = e.obs;

          logisticCont.text = selectedLogisticData.value.name.validate();
        }
      }
    }
  }

//endregion

  Future<void> saveLogisticZones() async {
    hideKeyBoardWithoutContext();
    List<int> selectedCitiesId = [];
    for (var element in selectedCities) {
      selectedCitiesId.add(element.id);
    }

    if (deliveryChargeCont.text == "0") return toast(locale.value.youCantSetTheStandardDeliveryCharge0);

    Map request = {
      if (isEdit.value) "id": logisticZone.value.id,
      "name": nameCont.text.trim(),
      "logistic_id": selectedLogisticData.value.id,
      "country_id": selectedCountry.value.id,
      "state_id": selectedState.value.id,
      "city_id": selectedCitiesId,
      "standard_delivery_charge": deliveryChargeCont.text.trim(),
      "standard_delivery_time": deliveryTimeCont.text.trim(),
    };

    isLoading(true);

    LogisticZoneAPI.saveLogisticZone(logisticZoneId: isEdit.value ? logisticZone.value.id.toString() : '', request: request, isUpdate: isEdit.value).then((value) {
      toast(value.message.validate());
      Get.back(result: true);
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }
}
