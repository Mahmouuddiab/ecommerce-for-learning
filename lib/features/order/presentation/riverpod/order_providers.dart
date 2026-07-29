import 'dart:async';
import 'package:ecommerce/features/order/data/repository/order_repository_impl.dart';
import 'package:ecommerce/features/order/domain/entity/order_entity.dart';
import 'package:ecommerce/features/order/domain/repository/order_repository.dart';
import 'package:ecommerce/features/order/domain/usecase/create_cash_order_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data source/order_remote_ds.dart';

// 1. Data Source Provider
final orderRemoteDataSourceProvider = Provider<OrderRemoteDataSource>((ref) {
  return OrderRemoteDataSourceImpl();
});

// 2. Repository Provider
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final remoteDataSource = ref.read(orderRemoteDataSourceProvider);
  return OrderRepositoryImpl(remoteDataSource);
});

// 3. UseCase Provider
final createCashOrderUseCaseProvider = Provider<CreateCashOrderUseCase>((ref) {
  final repository = ref.read(orderRepositoryProvider);
  return CreateCashOrderUseCase(repository);
});

// 4. Controller (AsyncNotifier)
class OrderController extends AsyncNotifier<OrderEntity?> {
  @override
  FutureOr<OrderEntity?> build() {
    return null; // Initial state (no order yet)
  }

  Future<void> createCashOrder({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  }) async {
    state = const AsyncLoading();

    final useCase = ref.read(createCashOrderUseCaseProvider);

    final result = await useCase.execute(
      cartId: cartId,
      details: details,
      phone: phone,
      city: city,
    );

    result.fold(
          (error) => state = AsyncError(error, StackTrace.current),
          (order) => state = AsyncData(order),
    );
  }
}

// 5. Controller Provider
final orderControllerProvider =
AsyncNotifierProvider<OrderController, OrderEntity?>(
  OrderController.new,
);