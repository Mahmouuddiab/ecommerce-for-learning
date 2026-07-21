import 'package:ecommerce/features/cart/data/data%20source/cart_remote_ds.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';
import 'package:ecommerce/features/cart/domain/entities/product_cart_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDs remote;
  CartRepositoryImpl(this.remote);
  @override
  Future<List<ProductCartEntity>> cartProducts() async {
    return await remote.cartProducts();
  }

  @override
  Future<CartResponseEntity> addProductToCart({required String productId}) async{
    return await remote.addProductToCart(productId: productId);
  }

  @override
  Future<CartResponseEntity> deleteFromCart({required String productId}) async{
    return await remote.deleteFromCart(productId: productId);
  }
}
