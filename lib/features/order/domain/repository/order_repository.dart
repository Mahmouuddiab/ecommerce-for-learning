import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/order/domain/entity/order_entity.dart';

abstract class OrderRepository {
  Future<Either<String, OrderEntity>> createCashOrder({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  });
}