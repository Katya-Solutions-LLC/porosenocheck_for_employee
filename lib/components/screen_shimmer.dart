import 'package:flutter/material.dart';

class ScreenShimmer extends StatelessWidget {
  final double spacing;
  final double runSpacing;
  final int itemCount;
  final Widget shimmerComponent;
  const ScreenShimmer({
    super.key,
    required this.shimmerComponent,
    this.runSpacing = 16,
    this.spacing = 16,
    this.itemCount = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      alignment: WrapAlignment.center,
      children: List.generate(itemCount, (index) => shimmerComponent),
    );
  }
}
