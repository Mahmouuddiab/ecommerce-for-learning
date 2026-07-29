import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/order/domain/entity/order_entity.dart';
import 'package:ecommerce/features/order/domain/repository/order_repository.dart';

class CreateCashOrderUseCase {
  final OrderRepository repository;

  CreateCashOrderUseCase(this.repository);

  Future<Either<String, OrderEntity>> execute({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  }) {
    return repository.createCashOrder(
      cartId: cartId,
      details: details,
      phone: phone,
      city: city,
    );
  }
}