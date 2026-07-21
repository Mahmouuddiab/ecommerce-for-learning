class CartResponseEntity {
  final String cartId;
  final int numOfCartItems;
  final num totalCartPrice;

  const CartResponseEntity({
    required this.cartId,
    required this.numOfCartItems,
    required this.totalCartPrice,
  });
}