import 'package:ecommerce/features/wishlist/domain/entities/product_wishlist_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';

class GetWishlistUseCase {
  final WishlistRepository repo;
  GetWishlistUseCase(this.repo);
  Future<List<ProductWishlistEntity>> call()=> repo.getUserWishlist();
}