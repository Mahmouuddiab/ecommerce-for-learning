import 'package:ecommerce/features/wishlist/domain/entities/product_wishlist_entity.dart';

class ProductWishlistModel extends ProductWishlistEntity {
  const ProductWishlistModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.description,
    required super.imageCover,
    super.images = const [],
    required super.price,
    super.priceAfterDiscount,
    required super.quantity,
    required super.sold,
    required super.ratingsAverage,
    required super.ratingsQuantity,
    super.category,
    super.brand,
    super.subcategories = const [],
  });

  factory ProductWishlistModel.fromJson(Map<String, dynamic> json) {
    return ProductWishlistModel(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageCover: json['imageCover'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          const [],
      price: json['price'] as num? ?? 0,
      priceAfterDiscount: json['priceAfterDiscount'] as num?,
      quantity: json['quantity'] as num? ?? 0,
      sold: json['sold'] as num? ?? 0,
      ratingsAverage: json['ratingsAverage'] as num? ?? 0,
      ratingsQuantity: json['ratingsQuantity'] as num? ?? 0,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'imageCover': imageCover,
      'images': images,
      'price': price,
      'priceAfterDiscount': priceAfterDiscount,
      'quantity': quantity,
      'sold': sold,
      'ratingsAverage': ratingsAverage,
      'ratingsQuantity': ratingsQuantity,
      'category': (category as CategoryModel?)?.toJson(),
      'brand': (brand as BrandModel?)?.toJson(),
      'subcategory': subcategories
          .map((e) => (e as SubcategoryModel).toJson())
          .toList(),
    };
  }
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    super.slug,
    super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'image': image,
    };
  }
}

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    super.slug,
    super.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'image': image,
    };
  }
}

class SubcategoryModel extends SubcategoryEntity {
  const SubcategoryModel({
    required super.id,
    required super.name,
    super.slug,
    super.categoryId,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String?,
      categoryId: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'category': categoryId,
    };
  }
}