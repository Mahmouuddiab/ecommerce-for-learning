import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/features/cart/data/data%20source/cart_remote_ds.dart';
import 'package:ecommerce/features/cart/data/models/cart_response_model.dart';
import 'package:ecommerce/features/cart/data/models/product_cart_model.dart';

class CartRemoteDsImpl implements CartRemoteDs {
  @override
  Future<List<ProductCartModel>> cartProducts() async {
    try {
      final response = await DioHelper.get(
        path: ApiConstants.getUserCart,
        withAuth: true,
      );
      if (response.statusCode == 200 && response.data != null) {
        final List data = response.data['data']?['products'] ?? [];
        return data.map((e) => ProductCartModel.fromJson(e)).toList();
      } else {
        throw ServerException(
          'Failed to load cart products. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Cart DataSource Error: ${e.toString()}');
    }
  }

  @override
  Future<CartResponseModel> addProductToCart({required String productId}) async{
    try{
      final response = await DioHelper.post(
          path: ApiConstants.addToCart,
          withAuth: true,
          data: {"productId":productId}
      );
      if(response.statusCode== 200){
        return CartResponseModel.fromJson(response.data) ;
      }
      else{
        throw ServerException(response.data["message"] ?? "Something went wrong");
      }
    }
    catch(e){
      throw ServerException(e.toString(),);
    }
  }

  @override
  Future<CartResponseModel> deleteFromCart({required String productId}) async{
    try{
      final response = await DioHelper.delete(
          path: ApiConstants.deleteFromCart(productId),
          withAuth: true
      );
      if(response.statusCode == 200){
        return CartResponseModel.fromJson(response.data) ;
      }
      else{
        throw ServerException(response.data["message"] ?? "Something went wrong");
      }
    }
    catch(e){
      throw ServerException(e.toString(),);
    }
  }
}
