import 'package:ecommerce/features/cart/data/data%20source/cart_remote_ds.dart';
import '../../data/data source/cart_remote_ds_impl.dart';
import 'package:ecommerce/features/cart/data/repository/cart_repository_impl.dart';
import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';
import 'package:ecommerce/features/cart/domain/entities/product_cart_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:ecommerce/features/cart/domain/usecase/delete_from_cart_usecase.dart';
import 'package:ecommerce/features/cart/domain/usecase/get_cart_product_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==========================================
// 1. Remote Data Source Provider
// ==========================================
final cartRemoteDsProvider = Provider<CartRemoteDs>((ref) {
  return CartRemoteDsImpl();
});

// ==========================================
// 2. Repository Provider
// ==========================================
final cartRepositoryProvider = Provider<CartRepository>((ref) {
  final remoteDataSource = ref.watch(cartRemoteDsProvider);
  return CartRepositoryImpl(remoteDataSource);
});

// ==========================================
// 3. Use Case Providers
// ==========================================
final getCartProductUseCaseProvider = Provider<GetCartProductUseCase>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return GetCartProductUseCase(repository);
});

final addToCartUseCaseProvider = Provider<AddToCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return AddToCartUseCase(repository);
});

final deleteFromCartUseCaseProvider = Provider<DeleteFromCartUseCase>((ref) {
  final repository = ref.watch(cartRepositoryProvider);
  return DeleteFromCartUseCase(repository);
});

// ==========================================
// 4. Cart Products UI FutureProvider
// ==========================================
final cartProductsProvider = FutureProvider<List<ProductCartEntity>>((
    ref,
    ) async {
  final useCase = ref.watch(getCartProductUseCaseProvider);
  return await useCase.call();
});

// ==========================================
// 5. Cart Operation State
// ==========================================
abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final CartResponseEntity cartResponse;
  AddToCartSuccess(this.cartResponse);
}

class AddToCartError extends AddToCartState {
  final String message;
  AddToCartError(this.message);
}

// ==========================================
// 6. Cart Controller (Notifier)
// ==========================================
class CartController extends Notifier<AddToCartState> {
  @override
  AddToCartState build() => AddToCartInitial();

  /// Add product to cart
  Future<void> addToCart(String productId) async {
    state = AddToCartLoading();
    try {
      final addToCartUseCase = ref.read(addToCartUseCaseProvider);
      final result = await addToCartUseCase.call(productId);

      state = AddToCartSuccess(result);
      ref.invalidate(cartProductsProvider);
    } catch (e) {
      state = AddToCartError(e.toString());
    }
  }

  /// Delete product from cart
  Future<void> deleteFromCart(String productId) async {
    state = AddToCartLoading();
    try {
      final deleteFromCartUseCase = ref.read(deleteFromCartUseCaseProvider);
      final result = await deleteFromCartUseCase.call(productId);

      state = AddToCartSuccess(result);
      ref.invalidate(cartProductsProvider);
    } catch (e) {
      state = AddToCartError(e.toString());
    }
  }
}

final cartControllerProvider =
NotifierProvider<CartController, AddToCartState>(CartController.new);

// ==========================================
// 7. Dynamic Cart Count Provider
// ==========================================
final cartCountProvider = Provider<int>((ref) {
  final cartAsync = ref.watch(cartProductsProvider);

  return cartAsync.maybeWhen(
    data: (products) =>
        products.fold<int>(0, (sum, item) => sum + item.quantity.toInt()),
    orElse: () => 0,
  );
});