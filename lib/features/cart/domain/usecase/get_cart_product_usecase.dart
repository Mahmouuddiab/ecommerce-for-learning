import 'package:ecommerce/features/cart/domain/entities/product_cart_entity.dart';
import 'package:ecommerce/features/cart/domain/repository/cart_repository.dart';

class GetCartProductUseCase {
  final CartRepository repo;
  GetCartProductUseCase(this.repo);
  Future<List<ProductCartEntity>> call()=> repo.cartProducts();
}