import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/network/network_utils.dart';
import 'package:porosenocheck_employee/utils/api_end_points.dart';
import 'package:porosenocheck_employee/utils/constants.dart';

import '../../../../models/base_response_model.dart';
import '../../shop_product/model/variation_combination_model.dart';
import '../model/variation_list_response.dart';

class VariationAPI {
  static Future<RxList<VariationData>> getVariations({
    required String filterByServiceStatus,
    required int employeeId,
    required List<VariationData> list,
    int page = 1,
    int perPage = Constants.perPageItem,
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    String statusFilter = filterByServiceStatus.isNotEmpty ? '&filter_type=$filterByServiceStatus' : '';
    final variationRes = VariationListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getVariation}?employee_id=$employeeId$statusFilter$pageQuery$perPageQuery', method: HttpMethodType.GET)));

    if (page == 1) list.clear();
    list.addAll(variationRes.data.validate());
    lastPageCallBack?.call(variationRes.data.validate().length != perPage);

    return list.obs;
  }

  static Future<BaseResponseModel> removeProduct({required int productId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.deleteProduct}/$productId', method: HttpMethodType.POST)));
  }

  static Future<VariationCombinationModel> getVariationCombination({required Map request}) async {
    return VariationCombinationModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.createCombination, request: request, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> removeVariation({required int variationId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.deleteVariation}/$variationId', method: HttpMethodType.POST)));
  }
}
