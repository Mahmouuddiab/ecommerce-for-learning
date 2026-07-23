import 'package:ecommerce/features/wishlist/data/data%20source/wishlist_remote_ds.dart';
import 'package:ecommerce/features/wishlist/domain/entities/product_wishlist_entity.dart';
import 'package:ecommerce/features/wishlist/domain/entities/wishlist_response_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDs remote;
  WishlistRepositoryImpl(this.remote);
  @override
  Future<WishlistResponseEntity> addToWishlist({required String productId}) async{
    return remote.addToWishlist(productId: productId);
  }

  @override
  Future<List<ProductWishlistEntity>> getUserWishlist() async{
    return await remote.getUserWishlist();
  }

  @override
  Future<WishlistResponseEntity> deleteFromWishlist({required String productId}) async{
    return await remote.deleteFromWishlist(productId: productId);
  }
}