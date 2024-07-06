
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../generated/assets.dart';
import '../utils/colors.dart';

class ChatGPTLoadingWidget extends StatelessWidget {
  const ChatGPTLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 37,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: Lottie.asset(
        Assets.lottieTyping,
        width: 60,
        height: 15,
        fit: BoxFit.contain,
      ),
    );
  }
}
