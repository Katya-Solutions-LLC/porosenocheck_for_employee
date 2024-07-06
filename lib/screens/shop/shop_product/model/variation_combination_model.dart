import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class VariationCombinationModel {
  bool status;
  List<VariationCombinationData> data;
  String message;

  VariationCombinationModel({
    this.status = false,
    this.data = const <VariationCombinationData>[],
    this.message = "",
  });

  factory VariationCombinationModel.fromJson(Map<String, dynamic> json) {
    return VariationCombinationModel(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<VariationCombinationData>.from(json['data'].map((x) => VariationCombinationData.fromJson(x))) : [],
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

class VariationCombinationData {
  String variationKey;
  String variation;
  num price;
  int stock;
  String sku;
  String code;

  TextEditingController variationsCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController stockCont = TextEditingController();
  TextEditingController skuCont = TextEditingController();
  TextEditingController codeCont = TextEditingController();

  VariationCombinationData({
    this.variationKey = "",
    this.variation = "",
    this.price = 0,
    this.stock = 0,
    this.sku = "",
    this.code = "",
  });

  factory VariationCombinationData.fromJson(Map<String, dynamic> json) {
    return VariationCombinationData(
      variationKey: json['variation_key'] is String ? json['variation_key'] : "",
      variation: json['variation'] is String ? json['variation'] : "",
      price: json['price'] is num ? json['price'] : 0,
      stock: json['stock'] is int ? json['stock'] : 0,
      sku: json['sku'] is String ? json['sku'] : "",
      code: json['code'] is String ? json['code'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variation_key': variationKey,
      'variation': variation,
      'price': price,
      'stock': stock,
      'sku': sku,
      'code': code,
    };
  }

  Map<String, dynamic> toCombinationRequest() {
    return {
      'variation_key': variationKey,
      'variation': variationsCont.text,
      'price': priceCont.text.toDouble(),
      'stock': stockCont.text.toInt(),
      'sku': skuCont.text,
      'code': codeCont.text,
    };
  }
}
