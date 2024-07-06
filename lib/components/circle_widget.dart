import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CircleWidget extends StatelessWidget {
  final double? height;
  final double? width;

  final Widget? child;

  final Decoration? decoration;

  final Color? circleColor;

  final EdgeInsets? padding;

  const CircleWidget({super.key, this.height, this.width, this.child, this.circleColor, this.padding, this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: decoration ??
          boxDecorationDefault(
            shape: BoxShape.circle,
            boxShadow: [],
            color: circleColor,
            borderRadius: BorderRadius.circular(height ?? 48),
          ),
      child: child,
    );
  }
}
