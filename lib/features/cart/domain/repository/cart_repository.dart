import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';

abstract class CartRepository {
  Future<CartResponseEntity> cartProducts();
  Future<CartResponseEntity> addProductToCart({required String productId});
  Future<CartResponseEntity> deleteFromCart({required String productId});
}
