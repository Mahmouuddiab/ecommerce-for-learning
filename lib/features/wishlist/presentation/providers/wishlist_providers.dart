import 'package:ecommerce/features/wishlist/data/repository/wishlist_repository_impl.dart';
import 'package:ecommerce/features/wishlist/domain/entities/product_wishlist_entity.dart';
import 'package:ecommerce/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:ecommerce/features/wishlist/domain/usecase/add_to_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/usecase/delete_from_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/domain/usecase/get_wishlist_usecase.dart';
import 'package:ecommerce/features/wishlist/presentation/providers/wishlist_controller.dart';
import 'package:ecommerce/features/wishlist/presentation/providers/wishlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data source/wishlist_remote_ds.dart';

// Remote Data Source Provider
final wishlistRemoteDsProvider = Provider<WishlistRemoteDs>((ref) {
  return WishlistRemoteDsImpl();
});

// Repository Provider
final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  final remoteDataSource = ref.watch(wishlistRemoteDsProvider);
  return WishlistRepositoryImpl(remoteDataSource);
});

// Use Case Providers
final addToWishlistUseCaseProvider = Provider<AddToWishlistUseCase>((ref) {
  final repository = ref.watch(wishlistRepositoryProvider);
  return AddToWishlistUseCase(repository);
});

final deleteFromWishlistUseCaseProvider = Provider<DeleteFromWishlistUseCase>((ref) {
  final repository = ref.watch(wishlistRepositoryProvider);
  return DeleteFromWishlistUseCase(repository);
});

final getWishlistUseCaseProvider = Provider<GetWishlistUseCase>((ref) {
  final repository = ref.watch(wishlistRepositoryProvider);
  return GetWishlistUseCase(repository);
});

// Controller Provider
final wishlistControllerProvider =
NotifierProvider<WishlistController, WishlistState>(
  WishlistController.new,
);

// Wishlist Items Auto-Fetcher
final wishlistProductsProvider = FutureProvider<List<ProductWishlistEntity>>((ref) async {
  final useCase = ref.watch(getWishlistUseCaseProvider);
  return await useCase.call();
});