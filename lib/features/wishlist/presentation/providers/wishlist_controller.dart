import 'package:ecommerce/features/wishlist/presentation/providers/wishlist_providers.dart';
import 'package:ecommerce/features/wishlist/presentation/providers/wishlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistController extends Notifier<WishlistState> {
  @override
  WishlistState build() => WishlistInitial();

  /// Add product to wishlist
  Future<void> addToWishlist(String productId) async {
    state = WishlistLoading();
    try {
      final addToWishlistUseCase = ref.read(addToWishlistUseCaseProvider);
      final result = await addToWishlistUseCase.call(productId);

      state = WishlistSuccess(result, message: 'Item added to wishlist');

      // Invalidate wishlistProductsProvider so UI screens auto-refresh
      ref.invalidate(wishlistProductsProvider);
    } catch (e) {
      state = WishlistError(e.toString());
    }
  }

  /// Remove product from wishlist
  Future<void> removeFromWishlist(String productId) async {
    state = WishlistLoading();
    try {
      final deleteFromWishlistUseCase = ref.read(deleteFromWishlistUseCaseProvider);
      final result = await deleteFromWishlistUseCase.call(productId);

      state = WishlistSuccess(result, message: 'Item removed from wishlist');

      // Invalidate wishlistProductsProvider so UI screens auto-refresh
      ref.invalidate(wishlistProductsProvider);
    } catch (e) {
      state = WishlistError(e.toString());
    }
  }
}