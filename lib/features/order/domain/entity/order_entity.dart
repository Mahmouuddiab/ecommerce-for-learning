class OrderEntity {
  final String id;
  final num totalOrderPrice;
  final String paymentMethodType;
  final bool isPaid;
  final bool isDelivered;

  const OrderEntity({
    required this.id,
    required this.totalOrderPrice,
    required this.paymentMethodType,
    required this.isPaid,
    required this.isDelivered,
  });
}