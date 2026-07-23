import 'package:ecommerce/features/wishlist/domain/entities/wishlist_response_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';

class AddToWishlistUseCase {
  final WishlistRepository repo;
  AddToWishlistUseCase(this.repo);
  Future<WishlistResponseEntity> call(String productId) =>
      repo.addToWishlist(productId: productId);
}
