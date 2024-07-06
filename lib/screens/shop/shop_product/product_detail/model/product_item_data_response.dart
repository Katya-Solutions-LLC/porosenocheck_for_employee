import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../variation/model/variation_list_response.dart';
import '../../model/shop_category_model.dart';

class ProductItemDataResponse {
  RxInt id;
  String slug;
  String name;
  int userId;
  int productId;
  String productName;
  String productDescription;
  String productImage;
  List<ShopCategory> category;
  int brandId;
  String brandName;
  int unitId;
  String unitName;
  String shortDescription;
  String description;
  num minPrice;
  num maxPrice;
  num discountValue;
  String discountType;
  num minDiscountedProductAmount;
  num maxDiscountedProductAmount;
  String discountStartDate;
  String discountEndDate;
  dynamic sellTarget;
  int stockQty;
  int status;
  int minPurchaseQty;
  int maxPurchaseQty;
  int hasVariation;
  num rating;
  List<VariationData> variationData;
  List<String>? productGalleryData;
  int ratingCount;
  RxBool inWishlist;
  int hasWarranty;
  dynamic createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int isFeatured;
  String dateRange;
  List<String> productTags;

  //local
  bool get isDiscount => discountValue != 0;

  ProductItemDataResponse({
    required this.id,
    this.slug = "",
    this.name = "",
    this.userId = -1,
    this.productId = -1,
    this.productName = "",
    this.productDescription = "",
    this.productImage = "",
    this.category = const <ShopCategory>[],
    this.brandId = -1,
    this.brandName = "",
    this.unitId = -1,
    this.unitName = "",
    this.shortDescription = "",
    this.description = "",
    this.minPrice = 0,
    this.maxPrice = 0,
    this.discountValue = 0,
    this.discountType = "",
    this.minDiscountedProductAmount = 0,
    this.maxDiscountedProductAmount = 0,
    this.discountStartDate = "",
    this.discountEndDate = "",
    this.sellTarget,
    this.stockQty = -1,
    this.status = -1,
    this.minPurchaseQty = -1,
    this.maxPurchaseQty = -1,
    this.hasVariation = -1,
    this.rating = 0,
    this.variationData = const <VariationData>[],
    this.ratingCount = -1,
    this.productGalleryData,
    required this.inWishlist,
    this.hasWarranty = -1,
    this.createdBy,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
    this.isFeatured = -1,
    this.dateRange = "",
    this.productTags = const <String>[],
  });

  factory ProductItemDataResponse.fromJson(Map<String, dynamic> json) {
    log(json['product_image']);
    return ProductItemDataResponse(
      id: json['id'] is int ? (json['id'] as int).obs : (-1).obs,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      userId: json['user_id'] is int ? json['user_id'] : -1,
      productId: json['product_id'] is int ? json['product_id'] : -1,
      productName: json['product_name'] is String ? json['product_name'] : "",
      productDescription: json['product_description'] is String ? json['product_description'] : "",
      productImage: json['product_image'] is String ? json['product_image'] : "",
      category: json['category'] is List ? List<ShopCategory>.from(json['category'].map((x) => ShopCategory.fromJson(x))) : [],
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      brandName: json['brand_name'] is String ? json['brand_name'] : "",
      unitId: json['unit_id'] is int ? json['unit_id'] : -1,
      unitName: json['unit_name'] is String ? json['unit_name'] : "",
      shortDescription: json['short_description'] is String ? json['short_description'] : "",
      description: json['description'] is String ? json['description'] : "",
      minPrice: json['min_price'] is num ? json['min_price'] : 0,
      maxPrice: json['max_price'] is num ? json['max_price'] : 0,
      discountValue: json['discount_value'] is num ? json['discount_value'] : 0,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      minDiscountedProductAmount: json['min_discounted_product_amount'] is num ? json['min_discounted_product_amount'] : 0,
      maxDiscountedProductAmount: json['max_discounted_product_amount'] is num ? json['max_discounted_product_amount'] : 0,
      discountStartDate: json['discount_start_date'] is String ? json['discount_start_date'] : "",
      discountEndDate: json['discount_end_date'] is String ? json['discount_end_date'] : "",
      sellTarget: json['sell_target'],
      stockQty: json['stock_qty'] is int ? json['stock_qty'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      minPurchaseQty: json['min_purchase_qty'] is int ? json['min_purchase_qty'] : -1,
      maxPurchaseQty: json['max_purchase_qty'] is int ? json['max_purchase_qty'] : -1,
      hasVariation: json['has_variation'] is int ? json['has_variation'] : -1,
      rating: json['rating'] is num ? json['rating'] : 0,
      variationData: json['variation_data'] is List ? List<VariationData>.from(json['variation_data'].map((x) => VariationData.fromJson(x))) : [],
      inWishlist: json['in_wishlist'] is int ? (json['in_wishlist'] == 1).obs : false.obs,
      ratingCount: json['rating_count'] is int ? json['rating_count'] : -1,
      hasWarranty: json['has_warranty'] is int ? json['has_warranty'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
      productGalleryData: json['product_gallary'] != null ? List<String>.from(json['product_gallary']) : null,
      isFeatured: json['is_featured'] is int ? json['is_featured'] : -1,
      dateRange: json['date_range'] is String ? json['date_range'] : "",
      productTags: json['product_tags'] is List ? List<String>.from(json['product_tags'].map((x) => x)) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'user_id': userId,
      'product_id': productId,
      'product_name': productName,
      'product_description': productDescription,
      'product_image': productImage,
      'category': category.map((e) => e.toJson()).toList(),
      'brand_id': brandId,
      'brand_name': brandName,
      'unit_id': unitId,
      'unit_name': unitName,
      'short_description': shortDescription,
      'description': description,
      'min_price': minPrice,
      'max_price': maxPrice,
      'discount_value': discountValue,
      'discount_type': discountType,
      'min_discounted_product_amount': minDiscountedProductAmount,
      'max_discounted_product_amount': maxDiscountedProductAmount,
      'discount_start_date': discountStartDate,
      'discount_end_date': discountEndDate,
      'sell_target': sellTarget,
      'stock_qty': stockQty,
      'status': status,
      'min_purchase_qty': minPurchaseQty,
      'max_purchase_qty': maxPurchaseQty,
      'has_variation': hasVariation,
      'rating': rating,
      'variation_data': variationData.map((e) => e.toJson()).toList(),
      'in_wishlist': inWishlist.value,
      'has_warranty': hasWarranty,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'rating_count': ratingCount,
      'is_featured': isFeatured,
      'date_range': dateRange,
      'product_tags': productTags.map((e) => e).toList(),
    };
  }
}
