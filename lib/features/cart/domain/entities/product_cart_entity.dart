class ProductCartEntity {
  final String id;
  final String cartItemId;
  final String title;
  final num price;
  final String imageCover;
  final num quantity; // Corresponds to 'count' in the cart API
  final num ratingsAverage;
  final CategoryEntity? category;
  final BrandEntity? brand;
  final List<SubcategoryEntity> subcategories;

  const ProductCartEntity({
    required this.id,
    required this.cartItemId,
    required this.title,
    required this.price,
    required this.imageCover,
    required this.quantity,
    required this.ratingsAverage,
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