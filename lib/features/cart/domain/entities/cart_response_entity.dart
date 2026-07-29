import 'product_cart_entity.dart';

class CartResponseEntity {
  final String cartId;
  final int numOfCartItems;
  final num totalCartPrice;
  final List<ProductCartEntity> products;

  const CartResponseEntity({
    required this.cartId,
    required this.numOfCartItems,
    required this.totalCartPrice,
    required this.products,
  });
}