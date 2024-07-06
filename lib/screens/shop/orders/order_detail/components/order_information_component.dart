import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/utils/common_base.dart';

import '../../../../../main.dart';
import '../../model/order_detail_model.dart';

class OrderInformationComponent extends StatelessWidget {
  final OrderListData orderData;

  const OrderInformationComponent({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.orderDetails, style: primaryTextStyle()),
        8.height,
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              16.height,
              detailWidget(title: locale.value.orderDate, value: orderData.orderingDate),
              detailWidget(
                title: "Expected On", //TODO: string
                value: orderData.orderDetails.productDetails.deliveredDate.isNotEmpty
                    ? orderData.orderDetails.productDetails.deliveredDate.dateInDMMMyyyyFormat
                    : orderData.orderDetails.productDetails.deliveringDate,
              ),
              detailWidget(title: "Payment Method", value: orderData.paymentMethod.capitalizeFirstLetter()), //TODO: string
              detailWidget(
                title: locale.value.deliveryStatus,
                value: getOrderStatus(status: orderData.deliveryStatus),
                textColor: getOrderStatusColor(status: orderData.deliveryStatus),
              ),
              6.height,
            ],
          ),
        ),
        16.height,
      ],
    );
  }
}
