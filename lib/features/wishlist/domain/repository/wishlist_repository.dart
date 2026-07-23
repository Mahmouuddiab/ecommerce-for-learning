import 'package:ecommerce/features/wishlist/domain/entities/product_wishlist_entity.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_response_entity.dart';

abstract class WishlistRepository {
  Future<WishlistResponseEntity> addToWishlist({required String productId});
  Future<WishlistResponseEntity> deleteFromWishlist({required String productId});
  Future<List<ProductWishlistEntity>> getUserWishlist();
}