import 'package:ecommerce/features/cart/data/models/product_cart_model.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';

class CartResponseModel extends CartResponseEntity {
  const CartResponseModel({
    required super.cartId,
    required super.numOfCartItems,
    required super.totalCartPrice,
    required super.products,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'] as Map<String, dynamic>? ?? json;

    return CartResponseModel(
      cartId: dataJson['_id'] as String? ?? json['cartId'] as String? ?? '',
      numOfCartItems: (json['numOfCartItems'] as num?)?.toInt() ??
          (dataJson['products'] as List?)?.length ??
          0,
      totalCartPrice: (dataJson['totalCartPrice'] as num?) ?? 0,
      products: (dataJson['products'] as List<dynamic>?)
          ?.whereType<Map<String, dynamic>>()
          .map((e) => ProductCartModel.fromJson(e))
          .toList() ??
          const [],
    );
  }
}