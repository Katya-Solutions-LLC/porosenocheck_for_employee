import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/components/price_widget.dart';

import '../utils/app_common.dart';
import '../utils/colors.dart';

class EmployeeTotalWidget extends StatelessWidget {
  final String title;
  final String total;
  final String? icon;
  final Color? color;
  final bool isPrice;

  const EmployeeTotalWidget({super.key, required this.title, required this.total, this.icon, this.color, this.isPrice = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: boxDecorationDefault(color: primaryColor),
      width: context.width() / 2 - 24,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isPrice
                      ? PriceWidget(
                          price: total.toDouble(),
                          color: Colors.white,
                          size: 14,
                        )
                      : Text(total.validate(), style: boldTextStyle(color: Colors.white, size: 16)),
                  (icon != null && icon!.isNotEmpty) ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    child: Image.asset(icon!, width: 20, height: 20, color: primaryColor),
                  ) : const Offstage(),
                ],
              ),
              8.height,
              Marquee(child: Text(title.validate(), style: secondaryTextStyle(color: isDarkMode.value ? Colors.white : context.cardColor))),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
