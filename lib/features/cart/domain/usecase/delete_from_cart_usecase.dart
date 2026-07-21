import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class DeleteFromCartUseCase {
  final CartRepository repo;
  DeleteFromCartUseCase(this.repo);
  Future<CartResponseEntity> call(String productId) =>
      repo.deleteFromCart(productId: productId);
}
