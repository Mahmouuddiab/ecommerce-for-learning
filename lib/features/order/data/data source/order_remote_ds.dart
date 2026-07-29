import 'package:dio/dio.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/features/order/data/model/order_response_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderResponseModel> createCashOrder({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  @override
  Future<OrderResponseModel> createCashOrder({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  }) async {
    final response = await DioHelper.post(
      path: ApiConstants.createOrder(cartId),
      withAuth: true,
      data: {
        "shippingAddress": {"details": details, "phone": phone, "city": city},
      },
    );

    return OrderResponseModel.fromJson(response.data);
  }
}
