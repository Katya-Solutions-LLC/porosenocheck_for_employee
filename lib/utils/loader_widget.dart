/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../generated/assets.dart';

class LoaderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const LoaderWidget({super.key, this.height, this.width, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.imagesFrezkaLoader,
      height: height ?? 150,
      width: width ?? 150,
      color: color ?? (Get.isDarkMode ? Colors.white : Colors.black),
    ).center();
    //return Lottie.asset('assets/lottie/app_loader.json', height: height ?? 70, width: width ?? 70, repeat: true).center();
  }
}
 */