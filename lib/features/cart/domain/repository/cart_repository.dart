import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';
import 'package:ecommerce/features/cart/domain/entities/product_cart_entity.dart';

abstract class CartRepository {
  Future<CartResponseEntity> cartProducts();
  Future<CartResponseEntity> addProductToCart({required String productId});
  Future<CartResponseEntity> deleteFromCart({required String productId});
}
