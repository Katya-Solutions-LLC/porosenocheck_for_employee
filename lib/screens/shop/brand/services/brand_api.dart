import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/screens/shop/brand/model/brand_list_response.dart';

import '../../../../main.dart';
import '../../../../models/base_response_model.dart';
import '../../../../network/network_utils.dart';
import '../../../../utils/api_end_points.dart';
import '../../../../utils/constants.dart';

class BrandAPI {
  static Future<RxList<BrandData>> getBrand({
    required int employeeId,
    required List<BrandData> brand,
    int? status,
    int page = 1,
    int? isAddedByAdmin,
    int perPage = Constants.perPageItem,
    Function(bool)? lastPageCallBack,
  }) async {
    String brandStatus = status != null ? '&status=$status' : '';
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    String addedByAdmin = isAddedByAdmin != null && isAddedByAdmin != 0 ? '&added_by_admin=$isAddedByAdmin' : "";
    final brandRes = BrandListResponse.fromJson(
        await handleResponse(await buildHttpResponse('${APIEndPoints.getBrand}?employee_id=$employeeId$brandStatus$pageQuery$perPageQuery$addedByAdmin', method: HttpMethodType.GET)));

    if (page == 1) brand.clear();
    brand.addAll(brandRes.data.validate());
    lastPageCallBack?.call(brandRes.data.validate().length != perPage);

    return brand.obs;
  }

  static Future<void> addUpdateBrand({
    required String brandName,
    required bool status,
    File? imageFile,
    int? id,
    bool isEdit = false,
    Function(dynamic)? onSuccess,
  }) async {
    String brandId = id != -1 ? '/${id.toString()}' : '';
    http.MultipartRequest multiPartRequest = await getMultiPartRequest(isEdit ? '${APIEndPoints.updateBrand}$brandId' : APIEndPoints.saveBrand);
    multiPartRequest.fields['name'] = brandName;
    multiPartRequest.fields['status'] = status ? "1" : "0";

    if (imageFile != null) multiPartRequest.files.add(await http.MultipartFile.fromPath('feature_image', imageFile.path));

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        toast(locale.value.brandAddedSuccessfully);
        onSuccess?.call(data);
      },
      onError: (error) {
        throw error;
      },
    ).catchError((error) {
      throw error;
    });
  }

  static Future<BaseResponseModel> removeBrand({required int brandId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.deleteBrand}/$brandId', method: HttpMethodType.POST)));
  }
}
