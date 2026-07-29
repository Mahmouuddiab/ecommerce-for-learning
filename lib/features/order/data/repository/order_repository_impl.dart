import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/features/order/domain/entity/order_entity.dart';
import 'package:ecommerce/features/order/domain/repository/order_repository.dart';
import '../data source/order_remote_ds.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, OrderEntity>> createCashOrder({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  }) async {
    try {
      final response = await remoteDataSource.createCashOrder(
        cartId: cartId,
        details: details,
        phone: phone,
        city: city,
      );

      if (response.data != null) {
        return Right(response.data!.toEntity());
      } else {
        return const Left('Failed to process order.');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Network Error Occurred';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}