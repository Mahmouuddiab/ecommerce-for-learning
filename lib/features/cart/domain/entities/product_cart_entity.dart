class BrandEntity {
  final String? id;
  final String? name;

  const BrandEntity({this.id, this.name});
}

class CategoryEntity {
  final String? id;
  final String? name;

  const CategoryEntity({this.id, this.name});
}

class ProductCartEntity {
  final String id; // cart-item _id
  final String productId; // underlying product's _id
  final String title;
  final String? imageCover;
  final BrandEntity? brand;
  final CategoryEntity? category;
  final num price;
  final int quantity;

  const ProductCartEntity({
    required this.id,
    required this.productId,
    required this.title,
    this.imageCover,
    this.brand,
    this.category,
    required this.price,
    required this.quantity,
  });
}