import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;

  final EdgeInsets? padding;
  final Widget? child;
  final Color? backgroundColor;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerWidget({super.key, this.height, this.width, this.padding, this.child, this.backgroundColor, this.baseColor, this.highlightColor});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? primaryColor.withOpacity(0.6),
      highlightColor: highlightColor ?? Colors.transparent,
      enabled: true,
      direction: ShimmerDirection.ltr,
      period: const Duration(seconds: 1),
      child: child ??
          Container(
            height: height,
            width: width,
            padding: padding,
            decoration: boxDecorationWithRoundedCorners(backgroundColor: backgroundColor ?? Colors.white10),
          ),
    );
  }
}
