import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../model/order_detail_model.dart';

class ShippingDetailComponent extends StatelessWidget {
  final OrderListData shippingData;

  const ShippingDetailComponent({super.key, required this.shippingData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.shippingDetail, style: primaryTextStyle()),
        8.height,
        Container(
          width: Get.width,
          padding: const EdgeInsets.all(16),
          decoration: boxDecorationDefault(color: context.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Marquee(child: Text(shippingData.userName.capitalizeFirstLetter(), style: primaryTextStyle())).visible(shippingData.userName.trim().isNotEmpty),
              Marquee(child: Text(shippingData.addressLine1.capitalizeFirstLetter(), style: primaryTextStyle(size: 13))).visible(shippingData.addressLine1.trim().isNotEmpty),
              Marquee(child: Text(shippingData.addressLine2.capitalizeFirstLetter(), style: primaryTextStyle(size: 13))).visible(shippingData.addressLine2.trim().isNotEmpty),

              if (shippingData.city.trim().isNotEmpty)
                Row(
                  children: [
                    Text('${locale.value.city} : ', style: secondaryTextStyle()),
                    Marquee(child: Text(shippingData.city.capitalizeFirstLetter(), style: primaryTextStyle(size: 13))),
                  ],
                ),

              if (shippingData.state.trim().isNotEmpty)
                Row(
                  children: [
                    Text('${locale.value.state} : ', style: secondaryTextStyle()),
                    Marquee(child: Text('${shippingData.state.capitalizeFirstLetter()} - ${shippingData.postalCode}', style: primaryTextStyle(size: 13))),
                  ],
                ),

              if (shippingData.phoneNo.trim().isNotEmpty)
                Row(
                  children: [
                    Text('${locale.value.contactNumber} : ', style: secondaryTextStyle()),
                    Marquee(child: Text(shippingData.phoneNo, style: primaryTextStyle(size: 13))),
                  ],
                ),

              if(shippingData.alternativePhoneNo.trim().isNotEmpty)
                Row(
                  children: [
                    Text('${locale.value.alternativeContactNumber} : ', style: secondaryTextStyle()),
                    Marquee(child: Text(shippingData.alternativePhoneNo, style: primaryTextStyle(size: 13))),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
