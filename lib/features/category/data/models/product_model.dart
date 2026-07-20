import 'package:ecommerce/features/category/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    super.priceAfterDiscount,
    required super.imageCover,
    required super.images,
    required super.ratingsAverage,
    required super.ratingsQuantity,
    required super.quantity,
    required super.sold,
    super.category,
    super.brand,
    super.subcategories,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      priceAfterDiscount: json['priceAfterDiscount'] as num?,
      imageCover: json['imageCover'] ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      ratingsAverage: json['ratingsAverage'] ?? 0,
      ratingsQuantity: json['ratingsQuantity'] ?? 0,
      quantity: json['quantity'] ?? 0,
      sold: json['sold'] ?? 0,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      brand: json['brand'] != null
          ? BrandModel.fromJson(json['brand'] as Map<String, dynamic>)
          : null,
      subcategories: (json['subcategory'] as List<dynamic>?)
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