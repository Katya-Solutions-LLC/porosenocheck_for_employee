import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../generated/assets.dart';

class EmptyStateWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const EmptyStateWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(Assets.lottieEmptyLottie, height: 150, repeat: true);
  }
}

class ErrorStateWidget extends StatelessWidget {
  final double? height;
  final double? width;

  const ErrorStateWidget({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(Assets.lottieErrorLottie, height: 110, repeat: true);
  }
}
