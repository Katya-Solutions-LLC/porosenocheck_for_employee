import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../components/app_logo_widget.dart';
import '../components/app_scaffold.dart';
import '../generated/assets.dart';
import '../main.dart';
import '../utils/app_common.dart';
import '../utils/constants.dart';
import '../utils/empty_error_state_widget.dart';
import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController splashController = Get.put(SplashScreenController());
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        hideAppBar: true,
        isLoading: isLoading,
        scaffoldBackgroundColor: isDarkMode.value ? const Color(0xFF0C0910) : const Color(0xFFFCFCFC),
        body: Obx(
          () => SnapHelperWidget(
            future: appConfigsFuture.value,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  isLoading(true);
                  getAppConfigurations();
                },
              ).paddingSymmetric(horizontal: 16);
            },
            loadingWidget: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    isDarkMode.value ? Assets.imagesporosenocheckLoaderDark : Assets.imagesporosenocheckLoaderLight,
                    height: Constants.appLogoSize,
                    width: Constants.appLogoSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const AppLogoWidget(),
                  ),
                ],
              ),
            ),
            onSuccess: (splash) {
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
