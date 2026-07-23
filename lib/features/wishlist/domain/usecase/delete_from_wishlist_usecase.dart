import 'package:ecommerce/features/wishlist/domain/entities/wishlist_response_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';

class DeleteFromWishlistUseCase {
  final WishlistRepository repo;
  DeleteFromWishlistUseCase(this.repo);
  Future<WishlistResponseEntity> call(String productId) =>
      repo.deleteFromWishlist(productId: productId);
}
