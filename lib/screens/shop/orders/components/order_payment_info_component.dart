import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/main.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';

import '../../../../components/price_widget.dart';
import '../model/order_detail_model.dart';

class OrderPaymentInfoComponent extends StatelessWidget {
  final OrderListData orderData;

  const OrderPaymentInfoComponent({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.priceDetails, style: primaryTextStyle()),
        8.height,
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Subtotal
              detailWidgetPrice(title: locale.value.subTotal, value: orderData.orderDetails.productPrice, textColor: textPrimaryColorGlobal, isSemiBoldText: true),

              /// Total Tax Amount
              detailWidgetPrice(title: locale.value.tax, value: orderData.orderDetails.productDetails.taxAmount, textColor: textPrimaryColorGlobal, isSemiBoldText: true),

              /// Delivery Charge
              detailWidgetPrice(title: locale.value.deliveryCharge, value: orderData.logisticCharge, textColor: textPrimaryColorGlobal, isSemiBoldText: true),

              /// Payment Status
              detailWidget(title: locale.value.paymentStatus, value: orderData.paymentStatus.capitalizeFirstLetter(), textColor: getOrderPriceStatusColor(paymentStatus: orderData.paymentStatus)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.value.total, style: secondaryTextStyle()),
                  PriceWidget(price: orderData.totalAmount, size: 12)
                ],
              ).paddingBottom(10),
            ],
          ),
        ),
      ],
    );
  }
}
