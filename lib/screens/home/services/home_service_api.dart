import 'package:nb_utils/nb_utils.dart';

import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../model/about_page_res.dart';
import '../model/dashboard_res_model.dart';
import '../model/status_list_res.dart';

class HomeServiceApi {
  static Future<DashboardRes> getDashboard() async {
    return DashboardRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getEmployeeDashboard, method: HttpMethodType.GET)));
  }

  static Future<AboutPageRes> getAboutPageData() async {
    return AboutPageRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.aboutPages, method: HttpMethodType.GET)));
  }

  static Future<StatusListRes> getAllStatusUsedForBooking() async {
    return StatusListRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.bookingStatus, method: HttpMethodType.GET)));
  }
}
