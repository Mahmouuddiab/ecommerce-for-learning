import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';

class CartResponseModel extends CartResponseEntity {
  const CartResponseModel({
    required super.cartId,
    required super.numOfCartItems,
    required super.totalCartPrice,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      cartId: json['cartId'] as String? ?? json['_id'] as String? ?? '',
      numOfCartItems: (json['numOfCartItems'] as num?)?.toInt() ?? 0,
      totalCartPrice: json['totalCartPrice'] as num? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartId': cartId,
      'numOfCartItems': numOfCartItems,
      'totalCartPrice': totalCartPrice,
    };
  }
}