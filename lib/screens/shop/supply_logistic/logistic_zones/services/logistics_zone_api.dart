import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/models/base_response_model.dart';
import 'package:porosenocheckemployee/network/network_utils.dart';
import 'package:porosenocheckemployee/utils/api_end_points.dart';
import 'package:porosenocheckemployee/utils/constants.dart';

import '../model/city_list_response.dart';
import '../model/country_list_response.dart';
import '../model/logistic_zone_list_response.dart';
import '../model/state_list_response.dart';

class LogisticZoneAPI {
  //region Get LogisticZone API
  static Future<RxList<LogisticZoneData>> getLogisticsZones({
    required String filterByServiceStatus,
    required int employeeId,
    required List<LogisticZoneData> logisticZoneList,
    int page = 1,
    int perPage = Constants.perPageItem,
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    String statusFilter = filterByServiceStatus.isNotEmpty ? '&filter_type=$filterByServiceStatus' : '';
    final logisticZoneRes = LogisticZoneListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getLogisticZone}?employee_id=$employeeId$statusFilter$pageQuery$perPageQuery', method: HttpMethodType.GET)));

    if (page == 1) logisticZoneList.clear();
    logisticZoneList.addAll(logisticZoneRes.logisticZone.validate());

    lastPageCallBack?.call(logisticZoneRes.logisticZone.validate().length != perPage);

    return logisticZoneList.obs;
  }

  //endregion

  //region Delete Logistic Zone API
  static Future<BaseResponseModel> deleteLogisticZone({required int logisticZoneId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.deleteLogisticZone}/$logisticZoneId', method: HttpMethodType.POST)));
  }

//endregion

  //region Country List API
  static Future<CountryListResponse> getCountryList() async {
    return CountryListResponse.fromJson(await (handleResponse(await buildHttpResponse(APIEndPoints.getCountry, method: HttpMethodType.GET))));
  }

  static Future<StateListResponse> getStateList({int countryId = -1}) async {
    return StateListResponse.fromJson(await (handleResponse(await buildHttpResponse('${APIEndPoints.getStates}?country_id=$countryId', method: HttpMethodType.GET))));
  }

  static Future<CityListResponse> getCityList({int stateId = -1}) async {
    return CityListResponse.fromJson(await (handleResponse(await buildHttpResponse('${APIEndPoints.getCity}?state_id=$stateId', method: HttpMethodType.GET))));
  }

//endregion

//region Save LogisticZone API

  static Future<BaseResponseModel> saveLogisticZone({String? logisticZoneId, Map? request, bool isUpdate = false}) async {
    String id = logisticZoneId.validate().isNotEmpty ? '/${logisticZoneId.validate()}' : '';
    return BaseResponseModel.fromJson(await (handleResponse(await buildHttpResponse(isUpdate ? '${APIEndPoints.updateLogisticZone}$id' : APIEndPoints.saveLogisticZone, request: request, method: HttpMethodType.POST))));
  }

//endregion
}
