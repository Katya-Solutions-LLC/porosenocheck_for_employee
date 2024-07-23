import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/models/base_response_model.dart';
import 'package:porosenocheckemployee/network/network_utils.dart';
import 'package:porosenocheckemployee/utils/api_end_points.dart';
import 'package:porosenocheckemployee/utils/constants.dart';

import '../model/unit_tag_list_response.dart';

class UnitTagsAPI {
  static Future<BaseResponseModel> addUpdateUnit({String? unitId, required Map request, bool isUpdate = false}) async {
    String id = unitId.validate().isNotEmpty ? unitId.validate() : '';
    return BaseResponseModel.fromJson(
        await handleResponse(await buildHttpResponse(isUpdate ? '${APIEndPoints.updateUnit}/$id' : APIEndPoints.saveUnit, request: request, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> removeUnitTag({required int id, bool isFromTags = false}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${isFromTags ? APIEndPoints.deleteTags : APIEndPoints.deleteUnit}/$id', method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> addUpdateTag({String? tagId, required Map request, bool isUpdate = false}) async {
    String id = tagId.validate().isNotEmpty ? tagId.validate() : '';
    return BaseResponseModel.fromJson(
        await handleResponse(await buildHttpResponse(isUpdate ? '${APIEndPoints.updateTags}/$id' : APIEndPoints.saveTags, request: request, method: HttpMethodType.POST)));
  }

  static Future<RxList<UnitTagData>> getUnits({
    required String filterByServiceStatus,
    required int employeeId,
    required List<UnitTagData> list,
    int page = 1,
    int? isAddedByAdmin,
    int perPage = Constants.perPageItem,
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    String addedByAdmin = isAddedByAdmin != null && isAddedByAdmin != 0 ? '&added_by_admin=$isAddedByAdmin' : "";
    String statusFilter = filterByServiceStatus.isNotEmpty ? '&filter_type=$filterByServiceStatus' : '';
    final brandRes = UnitTagListResponse.fromJson(
        await handleResponse(await buildHttpResponse('${APIEndPoints.getUnit}?employee_id=$employeeId$statusFilter$pageQuery$perPageQuery$addedByAdmin', method: HttpMethodType.GET)));

    if (page == 1) list.clear();
    list.addAll(brandRes.data.validate());
    lastPageCallBack?.call(brandRes.data.validate().length != perPage);

    return list.obs;
  }

  static Future<RxList<UnitTagData>> getTags({
    required String filterByServiceStatus,
    required int employeeId,
    required List<UnitTagData> list,
    var page = 1,
    int? isAddedByAdmin,
    int perPage = Constants.perPageItem,
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    String statusFilter = filterByServiceStatus.isNotEmpty ? '&filter_type=$filterByServiceStatus' : '';
    String addedByAdmin = isAddedByAdmin != null && isAddedByAdmin != 0 ? '&added_by_admin=$isAddedByAdmin' : "";
    final brandRes = UnitTagListResponse.fromJson(
        await handleResponse(await buildHttpResponse('${APIEndPoints.getTag}?employee_id=$employeeId$statusFilter$pageQuery$perPageQuery$addedByAdmin', method: HttpMethodType.GET)));

    if (page == 1) list.clear();
    list.addAll(brandRes.data.validate());
    lastPageCallBack?.call(brandRes.data.validate().length != perPage);

    return list.obs;
  }
}
