import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck_employee/screens/shop/orders/order_list/orders_controller.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../components/price_widget.dart';
import '../../../../main.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../model/order_detail_model.dart';
import '../order_detail/order_detail_screen.dart';

class NewOrderCard extends StatelessWidget {
  final OrderListData getOrderData;
  final VoidCallback? onUpdateDeliveryStatus;

  NewOrderCard({super.key, required this.getOrderData, this.onUpdateDeliveryStatus});

  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: primaryColor,
                  borderRadius: radiusOnly(topLeft: defaultRadius),
                ),
                child: Text("#${getOrderData.orderCode}", style: boldTextStyle(color: Colors.white, size: 12)),
              ).visible(getOrderData.orderCode.isNotEmpty),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: secondaryColor,
                  borderRadius: radiusOnly(topRight: defaultRadius),
                ),
                child: PriceWidget(price: getOrderData.totalAmount.validate(), color: Colors.white, size: 12),
              ),
            ],
          ),
          12.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImageWidget(
                url: getOrderData.productImage.toString(),
                height: 55,
                width: 55,
                fit: BoxFit.cover,
                radius: defaultRadius,
              ),
              12.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getOrderData.productName, style: primaryTextStyle(fontFamily: fontFamilyFontWeight400), maxLines: 1, overflow: TextOverflow.ellipsis),
                  if (getOrderData.productVariationType.isNotEmpty && getOrderData.productVariationName.isNotEmpty)
                    Row(
                      children: [
                        Text('${getOrderData.productVariationType} : ', style: secondaryTextStyle()),
                        Text(getOrderData.productVariationName, style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                      ],
                    ),
                  Row(
                    children: [
                      Text('${locale.value.qty} : ', style: secondaryTextStyle()),
                      Text(getOrderData.qty.toString(), style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                    ],
                  ),
                ],
              ).expand(),
            ],
          ).paddingOnly(left: 16, right: 16, top: 16),
          8.height,
          Divider(color: context.dividerColor),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.value.deliveryStatus, style: secondaryTextStyle()),
                  Text(getOrderStatus(status: getOrderData.deliveryStatus), style: primaryTextStyle(color: getOrderStatusColor(status: getOrderData.deliveryStatus))),
                ],
              ),
              4.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.value.payment, style: secondaryTextStyle()),
                  Text(getBookingPaymentStatus(status: getOrderData.paymentStatus), style: primaryTextStyle(color: getOrderPriceStatusColor(paymentStatus: getOrderData.paymentStatus))),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16),
          if (getOrderData.deliveryStatus.contains(OrderStatus.OrderPlaced) || getOrderData.deliveryStatus.contains(OrderStatus.Accepted) || getOrderData.deliveryStatus.contains(OrderStatus.Processing))
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (getOrderData.deliveryStatus.contains(OrderStatus.OrderPlaced))
                  AppButton(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(right: 8, left: 8),
                      color: primaryColor,
                      textStyle: appButtonTextStyleWhite,
                      text: locale.value.accept,
                      onTap: () {
                        showConfirmDialogCustom(
                          getContext,
                          primaryColor: primaryColor,
                          negativeText: locale.value.cancel,
                          positiveText: locale.value.yes,
                          onAccept: (_) {
                            orderController.updateDeliveryStatus(
                              orderId: getOrderData.orderId,
                              orderItemId: getOrderData.id,
                              status: OrderStatus.Accept,
                              onUpdateDeliveryStatus: onUpdateDeliveryStatus,
                            );
                          },
                          dialogType: DialogType.ACCEPT,
                          title: "Do you want to accept the order?", //TODO: string
                        );
                      }).expand(),
                AppButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: const EdgeInsets.only(right: 8, left: 8),
                  text: locale.value.processing,
                  width: Get.width,
                  color: primaryColor,
                  textStyle: appButtonTextStyleWhite,
                  onTap: () {
                    showConfirmDialogCustom(getContext, primaryColor: primaryColor, negativeText: locale.value.cancel, positiveText: locale.value.yes, onAccept: (_) {
                      orderController.updateDeliveryStatus(
                        orderId: getOrderData.orderId,
                        orderItemId: getOrderData.id,
                        status: OrderStatus.Processing,
                        onUpdateDeliveryStatus: onUpdateDeliveryStatus,
                      );
                    }, dialogType: DialogType.ACCEPT, title: 'Do you want to add product in processing?'); //TODO: string
                  },
                ).expand().visible(getOrderData.deliveryStatus.contains(OrderStatus.Accepted)),
                AppButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  margin: const EdgeInsets.only(right: 8, left: 8),
                  text: locale.value.delivered,
                  width: Get.width,
                  color: primaryColor,
                  textStyle: appButtonTextStyleWhite,
                  onTap: () {
                    showConfirmDialogCustom(getContext, primaryColor: primaryColor, negativeText: locale.value.cancel, positiveText: locale.value.yes, onAccept: (_) {
                      orderController.updateDeliveryStatus(
                        orderId: getOrderData.orderId,
                        orderItemId: getOrderData.id,
                        status: OrderStatus.Delivered,
                        onUpdateDeliveryStatus: onUpdateDeliveryStatus,
                      );
                    }, dialogType: DialogType.ACCEPT, title: 'Have you delivered the product?'); //TODO: string
                  },
                ).expand().visible(getOrderData.deliveryStatus.contains(OrderStatus.Processing)),
              ],
            ),
          16.height,
        ],
      ),
    ).onTap(() {
      hideKeyboard(context);
      Get.to(() => OrderDetailScreen(), arguments: getOrderData);
    }, borderRadius: radius(), highlightColor: Colors.transparent, splashColor: Colors.transparent).paddingOnly(bottom: 16);
  }
}
