class ProductEntity {
  final String id;
  final String title;
  final String description;
  final num price;
  final num? priceAfterDiscount;
  final String imageCover;
  final List<String> images;
  final num ratingsAverage;
  final num ratingsQuantity;
  final num quantity;
  final num sold;
  final CategoryEntity? category;
  final BrandEntity? brand;
  final List<SubcategoryEntity> subcategories;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.priceAfterDiscount,
    required this.imageCover,
    required this.images,
    required this.ratingsAverage,
    required this.ratingsQuantity,
    required this.quantity,
    required this.sold,
    this.category,
    this.brand,
    this.subcategories = const [],
  });
}

class CategoryEntity {
  final String id;
  final String name;
  final String? image;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.image,
  });
}

class BrandEntity {
  final String id;
  final String name;
  final String? image;

  const BrandEntity({
    required this.id,
    required this.name,
    this.image,
  });
}

class SubcategoryEntity {
  final String id;
  final String name;

  const SubcategoryEntity({
    required this.id,
    required this.name,
  });
}