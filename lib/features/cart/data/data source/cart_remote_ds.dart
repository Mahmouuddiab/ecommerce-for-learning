import 'package:ecommerce/features/cart/data/models/cart_response_model.dart';
import 'package:ecommerce/features/cart/data/models/product_cart_model.dart';

abstract class CartRemoteDs {
  Future<List<ProductCartModel>> cartProducts();
  Future<CartResponseModel> addProductToCart({required String productId});
  Future<CartResponseModel> deleteFromCart({required String productId});
}