import 'package:get/get.dart';
import 'package:porosenocheckemployee/utils/common_base.dart';

import '../../shop/orders/model/order_detail_model.dart';
import '../../shop/variation/model/variation_list_response.dart';

class PetStoreDetail {
  int brandCount;
  int unitCount;
  int tagCount;
  int productCategoryCount;
  int productCount;
  int orderCount;
  num pendingOrderPayout;

  num totalRevenue;
  List<OrderListData> order;

  PetStoreDetail({
    this.brandCount = 0,
    this.unitCount = 0,
    this.tagCount = 0,
    this.productCategoryCount = -1,
    this.productCount = 0,
    this.orderCount = 0,
    this.pendingOrderPayout = 0.0,
    this.totalRevenue = 0.0,
    this.order = const <OrderListData>[],
  });

  factory PetStoreDetail.fromJson(Map<String, dynamic> json) {
    return PetStoreDetail(
      brandCount: json['brand_count'] is int ? json['brand_count'] : 0,
      unitCount: json['unit_count'] is int ? json['unit_count'] : 0,
      tagCount: json['tag_count'] is int ? json['tag_count'] : 0,
      productCategoryCount: json['product_category_count'] is int ? json['product_category_count'] : -1,
      productCount: json['product_count'] is int ? json['product_count'] : 0,
      orderCount: json['order_count'] is int ? json['order_count'] : 0,
      pendingOrderPayout: json['pending_order_payout'] is num ? json['pending_order_payout'] : 0.0,
      totalRevenue: json['total_revenue'] is num ? json['total_revenue'] : 0.0,
      order: json['order'] is List ? List<OrderListData>.from(json['order'].map((x) => OrderListData.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brand_count': brandCount,
      'unit_count': unitCount,
      'tag_count': tagCount,
      'product_category_count': productCategoryCount,
      'product_count': productCount,
      'order_count': orderCount,
      'pending_order_payout': orderCount,
      'total_revenue': totalRevenue,
      'order': order.map((e) => e.toJson()).toList(),
    };
  }
}

class ProductDetails {
  int id;
  int userId;
  int productId;
  int productVariationId;
  RxInt qty;
  String unitName;
  String productName;
  String productImage;
  String productDescription;
  num discountValue;
  String discountType;
  VariationData productVariation;
  String productVariationType;
  String productVariationName;
  String productVariationValue;
  String createdAt;
  String updatedAt;
  String deletedAt;

  ///Order List
  num taxIncludeProductPrice;
  num getProductPrice;
  num productAmount;

  ///Order Detail
  num totalAmount;
  int orderId;
  String orderCode;
  String soldBy;
  String deliveryStatus;
  String paymentStatus;
  num taxAmount;
  num grandTotal;
  String deliveredDate;
  String expectedDeliveryDate;

  //local
  bool get isDiscount => discountValue != 0;
  String get deliveringDate => expectedDeliveryDate.dateInDMMMyyyyFormat;

  ProductDetails({
    this.id = -1,
    this.userId = -1,
    this.productId = -1,
    this.productVariationId = -1,
    required this.qty,
    this.unitName = "",
    this.productName = "",
    this.productImage = "",
    this.productDescription = "",
    this.discountValue = -1,
    this.discountType = "",
    required this.productVariation,
    this.productVariationType = "",
    this.productVariationName = "",
    this.productVariationValue = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    this.taxIncludeProductPrice = -1,
    this.getProductPrice = -1,
    this.productAmount = -1,
    this.totalAmount = -1,
    this.orderId = -1,
    this.orderCode = "",
    this.soldBy = "",
    this.deliveryStatus = "",
    this.paymentStatus = "",
    this.taxAmount = -1,
    this.grandTotal = -1,
    this.deliveredDate = "",
    this.expectedDeliveryDate = "",
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] is int ? json['id'] : -1,
      userId: json['user_id'] is int ? json['user_id'] : -1,
      productId: json['product_id'] is int ? json['product_id'] : -1,
      productVariationId: json['product_variation_id'] is int ? json['product_variation_id'] : -1,
      qty: RxInt(json['qty'] is int ? json['qty'] : 0),
      unitName: json['unit_name'] is String ? json['unit_name'] : "",
      productName: json['product_name'] is String ? json['product_name'] : "",
      productImage: json['product_image'] is String ? json['product_image'] : "",
      productDescription: json['product_description'] is String ? json['product_description'] : "",
      discountValue: json['discount_value'] is num ? json['discount_value'] : -1,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      productVariation: json['product_variation'] is Map ? VariationData.fromJson(json['product_variation']) : VariationData(),
      productVariationType: json['product_variation_type'] is String ? json['product_variation_type'] : "",
      productVariationName: json['product_variation_name'] is String ? json['product_variation_name'] : "",
      productVariationValue: json['product_variation_value'] is String ? json['product_variation_value'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
      taxIncludeProductPrice: json['tax_include_product_price'] is num ? json['tax_include_product_price'] : -1,
      getProductPrice: json['get_product_price'] is num ? json['get_product_price'] : -1,
      productAmount: json['product_amount'] is num ? json['product_amount'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      orderId: json['order_id'] is int ? json['order_id'] : -1,
      orderCode: json['order_code'] is String
          ? json['order_code']
          : json['order_code'] is int
            ? json['order_code'].toString()
            : "",
      soldBy: json['sold_by'] is String ? json['sold_by'] : "",
      deliveryStatus: json['delivery_status'] is String ? json['delivery_status'] : "",
      paymentStatus: json['payment_status'] is String ? json['payment_status'] : "",
      taxAmount: json['tax_amount'] is num ? json['tax_amount'] : -1,
      grandTotal: json['grand_total'] is num ? json['grand_total'] : -1,
      deliveredDate: json['delivered_date'] is String ? json['delivered_date'] : "",
      expectedDeliveryDate: json['expected_delivery_date'] is String ? json['expected_delivery_date'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'product_variation_id': productVariationId,
      'qty': qty.value,
      'unit_name': unitName,
      'product_name': productName,
      'product_image': productImage,
      'product_description': productDescription,
      'discount_value': discountValue,
      'discount_type': discountType,
      'product_variation': productVariation.toJson(),
      'product_variation_type': productVariationType,
      'product_variation_name': productVariationName,
      'product_variation_value': productVariationValue,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'tax_include_product_price': taxIncludeProductPrice,
      'get_product_price': getProductPrice,
      'product_amount': productAmount,
      'total_amount': totalAmount,
      'order_id': orderId,
      'order_code': orderCode,
      'sold_by': soldBy,
      'delivery_status': deliveryStatus,
      'payment_status': paymentStatus,
      'tax_amount': taxAmount,
      'grand_total': grandTotal,
      'delivered_date': deliveredDate,
      'expected_delivery_date': expectedDeliveryDate,
    };
  }
}
