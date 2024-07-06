import '../product_detail/model/product_item_data_response.dart';

class ProductListResponse {
  bool status;
  List<ProductItemDataResponse> data;
  String message;

  ProductListResponse({
    this.status = false,
    this.data = const <ProductItemDataResponse>[],
    this.message = "",
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<ProductItemDataResponse>.from(json['data'].map((x) => ProductItemDataResponse.fromJson(x))) : [],
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

class Combination {
  int id;
  String productVariationType;
  String productVariationName;
  String productVariationValue;

  Combination({
    this.id = -1,
    this.productVariationType = "",
    this.productVariationName = "",
    this.productVariationValue = "",
  });

  factory Combination.fromJson(Map<String, dynamic> json) {
    return Combination(
      id: json['id'] is int ? json['id'] : -1,
      productVariationType: json['product_variation_type'] is String ? json['product_variation_type'] : "",
      productVariationName: json['product_variation_name'] is String ? json['product_variation_name'] : "",
      productVariationValue: json['product_variation_value'] is String ? json['product_variation_value'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_variation_type': productVariationType,
      'product_variation_name': productVariationName,
      'product_variation_value': productVariationValue,
    };
  }
}
