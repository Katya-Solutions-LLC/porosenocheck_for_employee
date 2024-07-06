class ProductDiscountData {
  int id;
  String productDiscountName;
  String? productDiscountType;
  bool? isSelected;

  ProductDiscountData({
    this.id = -1,
    this.productDiscountName = "",
    this.productDiscountType,
    this.isSelected = false,
  });

  factory ProductDiscountData.fromJson(Map<String, dynamic> json) {
    return ProductDiscountData(
      id: json['id'] is int ? json['id'] : -1,
      productDiscountName: json['product_discount_name'] is String ? json['product_discount_name'] : "",
      productDiscountType: json['product_discount_type'] is String ? json['product_discount_type'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_discount_name': productDiscountName,
      'product_discount_type': productDiscountType,
    };
  }
}