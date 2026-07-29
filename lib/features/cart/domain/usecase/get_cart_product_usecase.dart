import 'package:ecommerce/features/cart/domain/entities/cart_response_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class GetCartProductUseCase {
  final CartRepository repo;
  GetCartProductUseCase(this.repo);
  Future<CartResponseEntity> call()=> repo.cartProducts();
}