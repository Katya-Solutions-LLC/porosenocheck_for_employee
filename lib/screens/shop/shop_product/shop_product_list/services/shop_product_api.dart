import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/network/network_utils.dart';
import 'package:porosenocheckemployee/utils/app_common.dart';
import 'package:porosenocheckemployee/utils/constants.dart';

import '../../../../../models/base_response_model.dart';
import '../../../../../utils/api_end_points.dart';
import '../../model/product_list_response.dart';
import '../../model/shop_category_model.dart';
import '../../product_detail/model/product_detail_response.dart';
import '../../product_detail/model/product_item_data_response.dart';

class ShopProductAPI {
  //region Get Category
  static Future<RxList<ShopCategory>> getShopCategory({
    required List<ShopCategory> list,
    int page = 1,
    int perPage = Constants.perPageItem,
    String search = "",
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '?page=$page';
    String searchCategory = search.isNotEmpty ? '&search=$search' : '';

    final categoryRes = CategoryListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getShopCategory}$pageQuery$perPageQuery$searchCategory', method: HttpMethodType.GET)));

    if (page == 1) list.clear();
    list.addAll(categoryRes.data.validate());
    lastPageCallBack?.call(categoryRes.data.validate().length != perPage);

    return list.obs;
  }

  //endregion

  //region Get Product
  static Future<RxList<ProductItemDataResponse>> getProduct({
    required int employeeId,
    String search = '',
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<ProductItemDataResponse> list,
    Function(bool)? lastPageCallBack,
  }) async {
    String searchProduct = search.isNotEmpty ? '&search=$search' : '';
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';

    final productRes = ProductListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getProduct}?employee_id=$employeeId$searchProduct$pageQuery$perPageQuery', method: HttpMethodType.GET)));

    if (page == 1) list.clear();
    list.addAll(productRes.data.validate());
    lastPageCallBack?.call(productRes.data.validate().length != perPage);

    return list.obs;
  }

  //endregion

  static Future<BaseResponseModel> removeProduct({required int productId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.deleteProduct}/$productId', method: HttpMethodType.POST)));
  }

  static Future<void> addProductMultipart({bool isEdit = false, String productId = '', required Map<String, dynamic> request, File? imageFile}) async {
    http.MultipartRequest multiPartRequest = await getMultiPartRequest(isEdit ? '${APIEndPoints.updateProduct}/$productId' : APIEndPoints.saveProduct);

    multiPartRequest.fields.addAll(await getMultipartFields(val: request));
    if (imageFile != null) {
      multiPartRequest.files.add(await http.MultipartFile.fromPath("feature_image", imageFile.path));
    }

    log("${multiPartRequest.fields}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    log("Multi Part Request : ${jsonEncode(multiPartRequest.fields)} ${multiPartRequest.files.map((e) => "${e.field}: ${e.filename.validate()}")}");

    await sendMultiPartRequest(multiPartRequest, onSuccess: (temp) async {
      log("Response: ${jsonDecode(temp)}");

      toast(jsonDecode(temp)['message'], print: true);
    }, onError: (error) {
      toast(error.toString(), print: true);
    }).catchError((e) {
      toast(e.toString());
    });
  }

  static Future<ProductDetailResponse> getProductDetails({required int productId}) async {
    return ProductDetailResponse.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getProductDetails}?id=$productId&user_id=${loginUserData.value.id}", method: HttpMethodType.GET)));
  }
}
