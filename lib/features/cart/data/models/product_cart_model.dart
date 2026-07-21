import 'package:ecommerce/features/cart/domain/entities/product_cart_entity.dart';

class ProductCartModel extends ProductCartEntity {
  const ProductCartModel({
    required super.id,
    required super.cartItemId,
    required super.title,
    required super.price,
    required super.imageCover,
    required super.quantity,
    required super.ratingsAverage,
    super.category,
    super.brand,
    super.subcategories,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    // Inner product object contains title, image, ratings, etc.
    final productJson = json['product'] as Map<String, dynamic>? ?? {};

    return ProductCartModel(
      // Product ID
      id: productJson['_id'] ?? productJson['id'] ?? '',

      // Cart Item ID (used for delete/update cart API requests)
      cartItemId: json['_id'] ?? '',

      // Cart Item Price & Quantity
      price: json['price'] ?? 0,
      quantity: json['count'] ?? 1, // 'count' represents cart quantity in RouteMisr API

      // Fields inside 'product' object
      title: productJson['title'] ?? '',
      imageCover: productJson['imageCover'] ?? '',
      ratingsAverage: productJson['ratingsAverage'] ?? 0,

      // Nested models
      category: productJson['category'] != null
          ? CategoryModel.fromJson(productJson['category'] as Map<String, dynamic>)
          : null,
      brand: productJson['brand'] != null
          ? BrandModel.fromJson(productJson['brand'] as Map<String, dynamic>)
          : null,
      subcategories: (productJson['subcategory'] as List<dynamic>?)
          ?.map((e) => SubcategoryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const [],
    );
  }
}

/// Category Model extending CategoryEntity
class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] as String?,
    );
  }
}

/// Brand Model extending BrandEntity
class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    super.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] as String?,
    );
  }
}

/// Subcategory Model extending SubcategoryEntity
class SubcategoryModel extends SubcategoryEntity {
  const SubcategoryModel({
    required super.id,
    required super.name,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}