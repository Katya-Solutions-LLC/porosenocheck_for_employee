import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/models/base_response_model.dart';
import 'package:porosenocheckemployee/network/network_utils.dart';
import 'package:porosenocheckemployee/screens/shop/supply_logistic/logistics/model/logistic_list_response.dart';
import 'package:porosenocheckemployee/utils/api_end_points.dart';
import 'package:porosenocheckemployee/utils/constants.dart';

import '../../../../../main.dart';

class LogisticAPI {
  //region Get Logistic
  static Future<RxList<LogisticData>> getLogistics({
    required String filterByServiceStatus,
    required int employeeId,
    required List<LogisticData> logisticList,
    int page = 1,
    var perPage = Constants.perPageItem,
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    String statusFilter = filterByServiceStatus.isNotEmpty ? '&filter_type=$filterByServiceStatus' : '';
    final logisticRes = LogisticListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getLogistic}?employee_id=$employeeId$statusFilter$pageQuery$perPageQuery', method: HttpMethodType.GET)));

    if (page == 1) logisticList.clear();
    logisticList.addAll(logisticRes.logisticData.validate());

    lastPageCallBack?.call(logisticRes.logisticData.validate().length != perPage);

    return logisticList.obs;
  }

  //endregion

  //region Save and Update Logistic
  static Future<void> addUpdateLogistic({
    required String logisticName,
    required bool status,
    File? imageFile,
    Function(dynamic)? onSuccess,
    int? id,
    bool isEdit = false,
  }) async {
    String logisticId = id != -1 ? '/${id.toString()}' : '';
    http.MultipartRequest multiPartRequest = await getMultiPartRequest(isEdit ? '${APIEndPoints.updateLogistic}$logisticId' : APIEndPoints.saveLogistic);
    multiPartRequest.fields['name'] = logisticName;
    multiPartRequest.fields['status'] = status ? "1" : "0";

    if (imageFile!.path.isNotEmpty) multiPartRequest.files.add(await http.MultipartFile.fromPath("feature_image", imageFile.path));

    multiPartRequest.headers.addAll(buildHeaderTokens());

    log("MultiPart Request : ${jsonEncode(multiPartRequest.fields)} ${multiPartRequest.files.map((e) => e.field + ": " + e.filename.validate())}");

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        if (isEdit) {
          toast(locale.value.logisticHasBeenUpdatedSuccessfully); 
        } else {
          toast(locale.value.logisticHasBeenCreatedSuccessfully);
        }

        onSuccess?.call(data);
      },
      onError: (error) {
        throw error;
      },
    ).catchError((error) {
      throw error;
    });
  }

  //endregion

  //region Delete Logistic
  static Future<BaseResponseModel> deleteLogistic({required int logisticId}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.deleteLogistic}/$logisticId', method: HttpMethodType.POST)));
  }
//endregion
}
