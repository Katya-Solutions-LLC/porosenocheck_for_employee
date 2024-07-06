import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';

class CustomAnimatedBottomBar extends StatelessWidget {
  const CustomAnimatedBottomBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.enableBgColor = false,
    this.activeBackgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 56,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool enableBgColor;
  final Color? activeBackgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarTheme.color;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  iconSize: iconSize,
                  activeBackgroundColor: activeBackgroundColor,
                  enableBgColor: enableBgColor,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor ?? Colors.white,
                  itemCornerRadius: itemCornerRadius,
                  length: items.length,
                  animationDuration: animationDuration,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final bool enableBgColor;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Color? activeBackgroundColor;
  final double itemCornerRadius;
  final int length;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    this.enableBgColor = true,
    required this.backgroundColor,
    this.activeBackgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.length,
    required this.iconSize,
    this.curve = Curves.linear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: Get.width / length - 16,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: enableBgColor
              ? isSelected
                  ? activeBackgroundColor ?? item.activeColor.withOpacity(0.2)
                  : backgroundColor
              : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: Get.width / length,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                IconTheme(
                  data: IconThemeData(
                    size: iconSize,
                    color: isSelected ? item.activeColor.withOpacity(1) : item.inactiveColor ?? item.activeColor,
                  ),
                  child: isSelected ? item.activeIconData ?? item.iconData : item.iconData,
                ),
                Container(
                  width: Get.width / length - 110,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(item.titleText, maxLines: 1, textAlign: item.textAlign, style: primaryTextStyle(color: isSelected ? item.activeColor.withOpacity(1) : item.inactiveColor ?? item.activeColor, size: 14)),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.iconData,
    this.activeIconData,
    required this.title,
    required this.titleText,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget iconData;
  final Widget? activeIconData;
  final Widget title;
  final String titleText;
  final Color activeColor;
  final Color? inactiveColor;
  final TextAlign? textAlign;
}

BottomNavyBarItem tab({required Widget iconData, required Widget activeIconData, required String tabName}) {
  return BottomNavyBarItem(
    iconData: iconData,
    activeIconData: activeIconData,
    titleText: tabName,
    title: Text(tabName, style: primaryTextStyle(color: primaryColor, size: 14)),
    activeColor: primaryColor,
    inactiveColor: darkGray,
    textAlign: TextAlign.end,
  );
}
