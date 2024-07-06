import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../main.dart';
import '../utils/constants.dart';

class ViewAllLabel extends StatelessWidget {
  final String label;
  final String? trailingText;
  final List? list;
  final VoidCallback? onTap;
  final int? labelSize;
  final bool isShowAll;
  final Color? trailingTextColor;

  const ViewAllLabel({super.key, required this.label, this.onTap, this.labelSize, this.list, this.isShowAll = true, this.trailingText, this.trailingTextColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: primaryTextStyle(fontFamily: fontFamilyBoldGlobal, size: labelSize ?? Constants.labelTextSize)),
        if (isShowAll)
          TextButton(
            onPressed: (list == null ? true : isViewAllVisible(list!))
                ? () {
                    onTap?.call();
                  }
                : null,
            child: (list == null ? true : isViewAllVisible(list!)) ? Text(trailingText ?? locale.value.viewAll, style: secondaryTextStyle(color: trailingTextColor ?? context.primaryColor, size: 12)) : const SizedBox(),
          )
        else
          46.height,
      ],
    );
  }
}

bool isViewAllVisible(List list) => list.length >= 4;
