class ProductWishlistEntity {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String imageCover;
  final List<String> images;
  final num price;
  final num? priceAfterDiscount;
  final num quantity;
  final num sold;
  final num ratingsAverage;
  final num ratingsQuantity;
  final CategoryEntity? category;
  final BrandEntity? brand;
  final List<SubcategoryEntity> subcategories;

  const ProductWishlistEntity({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.imageCover,
    this.images = const [],
    required this.price,
    this.priceAfterDiscount,
    required this.quantity,
    required this.sold,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    this.category,
    this.brand,
    this.subcategories = const [],
  });
}

class CategoryEntity {
  final String id;
  final String name;
  final String? slug;
  final String? image;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.slug,
    this.image,
  });
}

class BrandEntity {
  final String id;
  final String name;
  final String? slug;
  final String? image;

  const BrandEntity({
    required this.id,
    required this.name,
    this.slug,
    this.image,
  });
}

class SubcategoryEntity {
  final String id;
  final String name;
  final String? slug;
  final String? categoryId;

  const SubcategoryEntity({
    required this.id,
    required this.name,
    this.slug,
    this.categoryId,
  });
}