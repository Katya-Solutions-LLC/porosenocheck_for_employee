import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/constants.dart';

import '../configs.dart';
import '../utils/colors.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.appLogoSize,
      width: Constants.appLogoSize,
      alignment: Alignment.center,
      // padding: const EdgeInsets.all(50),
      decoration: boxDecorationDefault(
        shape: BoxShape.circle,
        color: primaryColor,
      ),
      child: Text(APP_NAME.toUpperCase(), style: boldTextStyle(color: Colors.white, letterSpacing: 10)),
    );
  }
}
