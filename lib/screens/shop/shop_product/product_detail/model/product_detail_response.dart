import 'package:get/get.dart';
import 'package:porosenocheckemployee/screens/shop/shop_product/product_detail/model/product_item_data_response.dart';

class ProductDetailResponse {
  ProductItemDataResponse data;
  bool status;
  List<ProductItemDataResponse> relatedProduct;
  String message;

  ProductDetailResponse({
    required this.data,
    this.status = false,
    this.relatedProduct = const <ProductItemDataResponse>[],
    this.message = "",
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    return ProductDetailResponse(
      data: json['data'] is Map ? ProductItemDataResponse.fromJson(json['data']) : ProductItemDataResponse(inWishlist: false.obs, id: (-1).obs),
      status: json['status'] is bool ? json['status'] : false,
      relatedProduct: json['data'] is List ? List<ProductItemDataResponse>.from(json['data'].map((x) => ProductItemDataResponse.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'status': status,
      'relatedProduct': relatedProduct.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}
