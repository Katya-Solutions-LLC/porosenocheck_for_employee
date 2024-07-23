import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/main.dart';

import '../../../components/app_scaffold.dart';
import '../../../generated/assets.dart';
import '../../../utils/colors.dart';

class PasswordSetSuccess extends StatelessWidget {
  const PasswordSetSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      scaffoldBackgroundColor: authScafoldColor,
      appBarbackgroundColor: authScafoldColor,
      body: Container(
        alignment: Alignment.center,
        height: Get.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                decoration: boxDecorationDefault(color: scafoldColor),
                child: Image.asset(Assets.imagesVector4),
              ),
              32.height,
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  locale.value.yourPasswordHasBeen,
                  textAlign: TextAlign.center,
                  style: secondaryTextStyle(
                    color: primaryTextColor,
                    size: 22,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
              16.height,
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  locale.value.youCanNowLog,
                  textAlign: TextAlign.center,
                  style: secondaryTextStyle(color: secondaryTextColor),
                ),
              ),
              48.height,
              AppButton(
                width: Get.width,
                text: locale.value.done,
                textStyle: const TextStyle(fontSize: 14, color: Colors.white),
                onTap: () {
                  Get.back();
                  Get.back();
                  /* Get.to(() => OptionScreen()); */
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
