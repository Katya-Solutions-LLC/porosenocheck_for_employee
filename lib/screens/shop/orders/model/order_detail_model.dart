import 'package:get/get.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';

import '../../../pet_store/model/pet_store_dashboard_model.dart';
import '../../variation/model/variation_list_response.dart';

class OrderDetailModel {
  bool status;
  OrderListData data;
  String message;

  OrderDetailModel({this.status = false, required this.data, this.message = ""});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map
          ? OrderListData.fromJson(json['data'])
          : OrderListData(orderDetails: OrderDetails(productDetails: ProductDetails(qty: 0.obs, productVariation: VariationData()))),
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class OrderListData {
  int id;
  String orderCode;
  int userId;
  String deliveryStatus;
  String paymentStatus;
  num subTotalAmount;
  num totalTaxAmount;
  num logisticCharge;
  num totalAmount;
  String paymentMethod;
  String orderDate;
  String logisticName;
  String expectedDeliveryDate;
  String deliveryDays;
  String deliveryTime;
  String userName;
  String addressLine1;
  String addressLine2;
  String phoneNo;
  String alternativePhoneNo;
  String city;
  String state;
  String country;
  String postalCode;
  OrderDetails orderDetails;

  /// PetStore Detail Dashboard
  int orderId;
  String productName;
  int qty;
  String productImage;
  int productId;
  int productVariationId;
  String productVariationType;
  String productVariationName;
  String productVariationValue;
  num taxIncludeProductPrice;
  num getProductPrice;
  num productAmount;
  num discountValue;
  String discountType;
  String soldBy;
  num grandTotal;

  // local
  String get orderingDate => orderDate.dateInddMMMyyyyHHmmAmPmFormat;

  //local
  bool get isDiscount => discountValue != 0;

  ///use only for notification id
  String notificationId;

  OrderListData({
    this.id = -1,
    this.orderCode = "",
    this.userId = -1,
    this.deliveryStatus = "",
    this.paymentStatus = "",
    this.subTotalAmount = -1,
    this.totalTaxAmount = -1,
    this.logisticCharge = -1,
    this.totalAmount = -1,
    this.paymentMethod = "",
    this.orderDate = "",
    this.logisticName = "",
    this.expectedDeliveryDate = "",
    this.deliveryDays = "",
    this.deliveryTime = "",
    this.userName = "",
    this.addressLine1 = "",
    this.addressLine2 = "",
    this.phoneNo = "",
    this.alternativePhoneNo = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.postalCode = "",
    required this.orderDetails,
    this.orderId = -1,
    this.productName = "",
    this.qty = -1,
    this.productImage = "",
    this.productId = -1,
    this.productVariationId = -1,
    this.productVariationType = "",
    this.productVariationName = "",
    this.productVariationValue = "",
    this.taxIncludeProductPrice = -1,
    this.getProductPrice = -1,
    this.productAmount = -1,
    this.discountValue = -1,
    this.discountType = "",
    this.soldBy = "",
    this.grandTotal = -1,
    this.notificationId = "",
  });

  factory OrderListData.fromJson(Map<String, dynamic> json) {
    return OrderListData(
      id: json['id'] is int ? json['id'] : -1,
      orderCode: json['order_code'] is String
          ? json['order_code']
          : json['order_code'] is int
              ? json['order_code'].toString()
              : "",
      userId: json['user_id'] is int ? json['user_id'] : -1,
      deliveryStatus: json['delivery_status'] is String ? json['delivery_status'] : "",
      paymentStatus: json['payment_status'] is String ? json['payment_status'] : "",
      subTotalAmount: json['sub_total_amount'] is num ? json['sub_total_amount'] : -1,
      totalTaxAmount: json['total_tax_amount'] is num ? json['total_tax_amount'] : -1,
      logisticCharge: json['logistic_charge'] is num ? json['logistic_charge'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      paymentMethod: json['payment_method'] is String ? json['payment_method'] : "",
      orderDate: json['order_date'] is String ? json['order_date'] : "",
      logisticName: json['logistic_name'] is String ? json['logistic_name'] : "",
      expectedDeliveryDate: json['expected_delivery_date'] is String ? json['expected_delivery_date'] : "",
      deliveryDays: json['delivery_days'] is String ? json['delivery_days'] : "",
      deliveryTime: json['delivery_time'] is String ? json['delivery_time'] : "",
      userName: json['user_name'] is String ? json['user_name'] : "",
      addressLine1: json['address_line_1'] is String ? json['address_line_1'] : "",
      addressLine2: json['address_line_2'] is String ? json['address_line_2'] : "",
      phoneNo: json['phone_no'] is String ? json['phone_no'] : "",
      alternativePhoneNo: json['alternative_phone_no'] is String ? json['alternative_phone_no'] : "",
      city: json['city'] is String ? json['city'] : "",
      state: json['state'] is String ? json['state'] : "",
      country: json['country'] is String ? json['country'] : "",
      postalCode: json['postal_code'] is String ? json['postal_code'] : "",
      orderDetails: json['order_details'] is Map ? OrderDetails.fromJson(json['order_details']) : OrderDetails(productDetails: ProductDetails(qty: 0.obs, productVariation: VariationData())),
      orderId: json['order_id'] is int ? json['order_id'] : -1,
      productName: json['product_name'] is String ? json['product_name'] : "",
      qty: json['qty'] is int ? json['qty'] : -1,
      productImage: json['product_image'] is String ? json['product_image'] : "",
      productId: json['product_id'] is int ? json['product_id'] : -1,
      productVariationId: json['product_variation_id'] is int ? json['product_variation_id'] : -1,
      productVariationType: json['product_variation_type'] is String ? json['product_variation_type'] : "",
      productVariationName: json['product_variation_name'] is String ? json['product_variation_name'] : "",
      productVariationValue: json['product_variation_value'] is String ? json['product_variation_value'] : "",
      taxIncludeProductPrice: json['tax_include_product_price'] is num ? json['tax_include_product_price'] : -1,
      getProductPrice: json['get_product_price'] is num ? json['get_product_price'] : -1,
      productAmount: json['product_amount'] is num ? json['product_amount'] : -1,
      discountValue: json['discount_value'] is num ? json['discount_value'] : -1,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      soldBy: json['sold_by'] is String ? json['sold_by'] : "",
      grandTotal: json['grand_total'] is num ? json['grand_total'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_code': orderCode,
      'user_id': userId,
      'delivery_status': deliveryStatus,
      'payment_status': paymentStatus,
      'sub_total_amount': subTotalAmount,
      'total_tax_amount': totalTaxAmount,
      'logistic_charge': logisticCharge,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'order_date': orderDate,
      'logistic_name': logisticName,
      'expected_delivery_date': expectedDeliveryDate,
      'delivery_days': deliveryDays,
      'delivery_time': deliveryTime,
      'user_name': userName,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'phone_no': phoneNo,
      'alternative_phone_no': alternativePhoneNo,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'order_id': orderId,
      'product_name': productName,
      'qty': qty,
      'product_image': productImage,
      'product_id': productId,
      'product_variation_id': productVariationId,
      'product_variation_type': productVariationType,
      'product_variation_name': productVariationName,
      'product_variation_value': productVariationValue,
      'tax_include_product_price': taxIncludeProductPrice,
      'get_product_price': getProductPrice,
      'product_amount': productAmount,
      'discount_value': discountValue,
      'discount_type': discountType,
      'sold_by': soldBy,
      'grand_total': grandTotal,
    };
  }
}

class OrderDetails {
  int vendorId;
  num totalTaxAmount;
  num logisticCharge;
  num productPrice;
  num totalAmount;
  num grandTotal;
  ProductDetails productDetails;
  List<OtherOrderItems> otherOrderItems;

  OrderDetails({
    this.vendorId = -1,
    this.totalTaxAmount = -1,
    this.logisticCharge = -1,
    this.productPrice = -1,
    this.totalAmount = -1,
    this.grandTotal = -1,
    required this.productDetails,
    this.otherOrderItems = const <OtherOrderItems>[],
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      vendorId: json['vendor_id'] is int ? json['vendor_id'] : -1,
      totalTaxAmount: json['total_tax_amount'] is num ? json['total_tax_amount'] : -1,
      logisticCharge: json['logistic_charge'] is num ? json['logistic_charge'] : -1,
      productPrice: json['product_price'] is num ? json['product_price'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      grandTotal: json['grand_total'] is num ? json['grand_total'] : -1,
      productDetails: json['product_details'] is Map ? ProductDetails.fromJson(json['product_details']) : ProductDetails(qty: 0.obs, productVariation: VariationData()),
      otherOrderItems: json['other_order_items'] is List ? List<OtherOrderItems>.from(json['other_order_items'].map((x) => OtherOrderItems.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendor_id': vendorId,
      'total_tax_amount': totalTaxAmount,
      'logistic_charge': logisticCharge,
      'product_price': productPrice,
      'total_amount': totalAmount,
      'grand_total': grandTotal,
      'product_details': productDetails.toJson(),
      'other_order_items': otherOrderItems.map((e) => e.toJson()).toList(),
    };
  }
}

class OtherOrderItems {
  int id;
  int orderItemId;
  int userId;
  String deliveryStatus;
  String paymentStatus;
  num productPrice;
  num totalAmount;
  num grandTotal;
  ProductDetails productDetails;

  OtherOrderItems({
    this.id = -1,
    this.orderItemId = -1,
    this.userId = -1,
    this.deliveryStatus = "",
    this.paymentStatus = "",
    this.productPrice = -1,
    this.totalAmount = -1,
    this.grandTotal = -1,
    required this.productDetails,
  });

  factory OtherOrderItems.fromJson(Map<String, dynamic> json) {
    return OtherOrderItems(
      id: json['id'] is int ? json['id'] : -1,
      orderItemId: json['order_item_id'] is int ? json['order_item_id'] : -1,
      userId: json['user_id'] is int ? json['user_id'] : -1,
      deliveryStatus:
      json['delivery_status'] is String ? json['delivery_status'] : "",
      paymentStatus:
      json['payment_status'] is String ? json['payment_status'] : "",
      productPrice: json['product_price'] is num ? json['product_price'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      grandTotal: json['grand_total'] is num ? json['grand_total'] : -1,
      productDetails: json['product_details'] is Map ? ProductDetails.fromJson(json['product_details']) : ProductDetails(qty: 0.obs, productVariation: VariationData()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_item_id': orderItemId,
      'user_id': userId,
      'delivery_status': deliveryStatus,
      'payment_status': paymentStatus,
      'product_price': productPrice,
      'total_amount': totalAmount,
      'grand_total': grandTotal,
      'product_details': productDetails.toJson(),
    };
  }
}

