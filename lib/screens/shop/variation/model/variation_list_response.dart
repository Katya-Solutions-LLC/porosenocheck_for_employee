import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../shop_product/model/product_list_response.dart';

class VariationListResponse {
  bool status;
  List<VariationData> data;
  String message;

  VariationListResponse({
    this.status = false,
    this.data = const <VariationData>[],
    this.message = "",
  });

  factory VariationListResponse.fromJson(Map<String, dynamic> json) {
    return VariationListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<VariationData>.from(json['data'].map((x) => VariationData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class VariationData {
  int id;
  String name;
  String type;
  int isFixed;
  int status;
  List<ProductVariationData> productVariationData;
  int createdBy;
  int updatedBy;
  String deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  TextEditingController? variationTypeCont;
  FocusNode? variationTypeFocus;
  TextEditingController? variationValueCont;
  FocusNode? variationValueFocus;
  int index;
  int addVariationCount;
  int variation;
  List<int> variationValue;

  //For Product Variations
  TextEditingController? variationTypeNameCont;
  FocusNode? variationTypeNameFocus;
  TextEditingController? variationTypeValueCont;
  FocusNode? variationTypeValueFocus;
  int indexVariation;
  int addVariationTypeCount;
  int variationType;
  List<int> variationTypeValue;

  //For Product List Keys
  int variationKey;
  String sku;
  String code;
  int locationId;
  int productStockQty;
  int isStockAvailable;
  List<Combination> combination;
  num productAmount;
  int inCart;
  num taxIncludeProductPrice;
  num discountedProductPrice;

  VariationData({
    this.id = -1,
    this.name = '',
    this.type = '',
    this.isFixed = -1,
    this.status = -1,
    this.productVariationData = const <ProductVariationData>[],
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    this.variationTypeCont,
    this.variationTypeFocus,
    this.variationValueCont,
    this.variationValueFocus,
    this.index = -1,
    this.addVariationCount = -1,
    this.variation = -1,
    this.variationValue = const <int>[],
    this.variationTypeNameCont,
    this.variationTypeNameFocus,
    this.variationTypeValueCont,
    this.variationTypeValueFocus,
    this.indexVariation = -1,
    this.addVariationTypeCount = -1,
    this.variationType = -1,
    this.variationTypeValue = const <int>[],
    this.variationKey = -1,
    this.sku = "",
    this.code = "",
    this.locationId = -1,
    this.productStockQty = -1,
    this.isStockAvailable = -1,
    this.combination = const <Combination>[],
    this.productAmount = -1,
    this.inCart = -1,
    this.taxIncludeProductPrice = -1,
    this.discountedProductPrice = -1,
  });

  factory VariationData.fromJson(Map<String, dynamic> json) {
    return VariationData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      type: json['type'] is String ? json['type'] : "",
      isFixed: json['is_fixed'] is int ? json['is_fixed'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      productVariationData: json['variation_data'] is List ? List<ProductVariationData>.from(json['variation_data'].map((x) => ProductVariationData.fromJson(x))) : [],
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'] is String ? json['deleted_by'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
      variationKey: json['variation_key'] is int ? json['variation_key'] : -1,
      sku: json['sku'] is String ? json['sku'] : "",
      code: json['code'] is String ? json['code'] : "",
      locationId: json['location_id'] is int ? json['location_id'] : -1,
      productStockQty: json['product_stock_qty'] is int ? json['product_stock_qty'] : -1,
      isStockAvailable: json['is_stock_avaible'] is int ? json['is_stock_avaible'] : -1,
      combination: json['combination'] is List ? List<Combination>.from(json['combination'].map((x) => Combination.fromJson(x))) : [],
      productAmount: json['product_amount'] is num ? json['product_amount'] : -1,
      inCart: json['in_cart'] is int ? json['in_cart'] : -1,
      taxIncludeProductPrice: json['tax_include_product_price'] is num ? json['tax_include_product_price'] : -1,
      discountedProductPrice: json['discounted_product_price'] is num ? json['discounted_product_price'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'is_fixed': isFixed,
      'variation_data': productVariationData.map((e) => e.toJson()).toList(),
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'status': status,
      'variation_key': variationKey,
      'sku': sku,
      'code': code,
      'location_id': locationId,
      'product_stock_qty': productStockQty,
      'is_stock_avaible': isStockAvailable,
      'combination': combination.map((e) => e.toJson()).toList(),
      'product_amount': productAmount,
      'in_cart': inCart,
      'tax_include_product_price': taxIncludeProductPrice,
      'discounted_product_price': discountedProductPrice,
    };
  }

  Map<String, dynamic> toJsonRequest() {
    return {
      'variation': variation,
      'variationValue': variationValue.map((e) => e).toList(),
    };
  }
}

class ProductVariationData {
  int id;
  int variationId;
  String name;
  String value;
  int status;
  RxBool isSelected = false.obs;

  ProductVariationData({
    this.id = -1,
    this.variationId = -1,
    this.name = '',
    this.value = '',
    this.status = -1,
  });

  factory ProductVariationData.fromJson(Map<String, dynamic> json) {
    return ProductVariationData(
      id: json['id'] is int ? json['id'] : -1,
      variationId: json['variation_id'] is int ? json['variation_id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      value: json['value'] is String ? json['value'] : "",
      status: json['status'] is int ? json['status'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'variation_id': variationId,
      'value': value,
    };
  }
}
