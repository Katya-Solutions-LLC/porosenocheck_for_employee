// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../main.dart';
import '../model/notification_model.dart';
import '../services/auth_services.dart';

class NotificationScreenController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Future<List<NotificationData>>> getNotifications = Future(() => <NotificationData>[]).obs;
  RxList<NotificationData> notificationDetail = RxList();
  int page = 1;
  RxBool isLastPage = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init({bool showLoader = true}) async {
    if (showLoader) {
      isLoading(true);
    }
    await getNotifications(AuthServiceApis.getNotificationDetail(
      page: page,
      notifications: notificationDetail,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }

  Future<void> removeNotification({required BuildContext context, required String notificationId}) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "${locale.value.doYouWantToRemoveNotification}?",
      positiveText: locale.value.yes,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        isLoading(true);
        await AuthServiceApis.removeNotification(notificationId: notificationId).then((value) {
          init();
          toast("${locale.value.notificationDeleted} ${locale.value.successfully}");
        }).catchError((error) {
          toast(error.toString());
        }).whenComplete(() => isLoading(false));
      },
    );
  }

  Future<void> clearAllNotification({required BuildContext context}) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "${locale.value.doYouWantToClearAllNotification}?",
      positiveText: locale.value.yes,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        isLoading(true);
        await AuthServiceApis.clearAllNotification().then((value) {
          init();
        }).catchError((error) {
          toast(error.toString());
        }).whenComplete(() => isLoading(false));
      },
    );
  }
}
