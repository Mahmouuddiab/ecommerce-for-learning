import 'package:ecommerce/features/cart/domain/entities/product_cart_entity.dart';

class ProductCartModel extends ProductCartEntity {
  const ProductCartModel({
    required super.id,
    required super.productId,
    required super.title,
    super.imageCover,
    super.brand,
    super.category,
    required super.price,
    required super.quantity,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    final productField = json['product'];

    String productId = '';
    String title = '';
    String? imageCover;
    BrandEntity? brand;
    CategoryEntity? category;

    if (productField is String) {
      // Add-to-cart response: product is just an ID, no extra details available
      productId = productField;
    } else if (productField is Map<String, dynamic>) {
      productId = productField['_id'] as String? ?? '';
      title = productField['title'] as String? ?? '';
      imageCover = productField['imageCover'] as String?;

      final brandJson = productField['brand'] as Map<String, dynamic>?;
      if (brandJson != null) {
        brand = BrandEntity(
          id: brandJson['_id'] as String?,
          name: brandJson['name'] as String?,
        );
      }

      final categoryJson = productField['category'] as Map<String, dynamic>?;
      if (categoryJson != null) {
        category = CategoryEntity(
          id: categoryJson['_id'] as String?,
          name: categoryJson['name'] as String?,
        );
      }
    }

    return ProductCartModel(
      id: json['_id'] as String? ?? '',
      productId: productId,
      title: title,
      imageCover: imageCover,
      brand: brand,
      category: category,
      price: (json['price'] as num?) ?? 0,
      quantity: (json['count'] as num?)?.toInt() ?? 0,
    );
  }
}