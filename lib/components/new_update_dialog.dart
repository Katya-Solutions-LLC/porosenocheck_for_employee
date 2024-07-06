import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configs.dart';
import '../generated/assets.dart';
import '../main.dart';
import '../utils/app_common.dart';
import '../utils/colors.dart';
import '../utils/common_base.dart';

class NewUpdateDialog extends StatelessWidget {
  final bool canClose;
  const NewUpdateDialog({super.key, this.canClose = true});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Get.width - 16,
          constraints: BoxConstraints(maxHeight: Get.height * 0.6),
          child: AnimatedScrollView(
            listAnimationType: ListAnimationType.FadeIn,
            children: [
              60.height,
              Text(locale.value.newUpdate, style: primaryTextStyle(size: 18)),
              8.height,
              Text("${locale.value.anUpdateTo} $APP_NAME ${locale.value.isAvailableGo}", style: secondaryTextStyle(), textAlign: TextAlign.left),
              24.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppButton(
                    text: canClose ? locale.value.later : locale.value.closeApp,
                    textStyle: appButtonTextStyleGray,
                    color: isDarkMode.value ? lightPrimaryColor2 : lightSecondaryColor,
                    onTap: () async {
                      if (canClose) {
                        Get.back();
                      } else {
                        exit(0);
                      }
                    },
                  ).expand(),
                  32.width,
                  AppButton(
                    text: locale.value.updateNow,
                    textStyle: appButtonTextStyleWhite,
                    onTap: () async {
                      getPackageName().then((value) {
                        if (isAndroid) {
                          String package = '';
                          package = value;

                          log('dfdfdfdf: ${getSocialMediaLink(LinkProvider.PLAY_STORE)}$package}');
                          commonLaunchUrl(
                            '${getSocialMediaLink(LinkProvider.PLAY_STORE)}$package',
                            launchMode: LaunchMode.externalApplication,
                          );

                          if (canClose) {
                            Get.back();
                          } else {
                            exit(0);
                          }
                        } else if (isIOS) {
                          commonLaunchUrl(APP_APPSTORE_URL, launchMode: LaunchMode.externalApplication);
                          if (canClose) {
                            Get.back();
                          } else {
                            exit(0);
                          }
                        }
                      });
                    },
                  ).expand(),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 24),
        ),
        Positioned(
          top: -42,
          child: Image.asset(Assets.imagesForceUpdate, height: 100, width: 100, fit: BoxFit.cover),
        ),
      ],
    );
  }
}
