import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repo;
  AddToCartUseCase(this.repo);
  Future<CartResponseEntity> call(String productId) =>
      repo.addProductToCart(productId: productId);
}
