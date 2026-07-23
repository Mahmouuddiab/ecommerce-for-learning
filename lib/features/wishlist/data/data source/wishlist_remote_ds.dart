import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/features/wishlist/data/models/product_wishlist_model.dart';
import 'package:ecommerce/features/wishlist/data/models/wishlist_response_model.dart';

abstract class WishlistRemoteDs {
  Future<WishlistResponseModel> addToWishlist({required String productId});
  Future<WishlistResponseModel> deleteFromWishlist({required String productId});
  Future<List<ProductWishlistModel>> getUserWishlist();
}

class WishlistRemoteDsImpl implements WishlistRemoteDs {
  @override
  Future<WishlistResponseModel> addToWishlist({
    required String productId,
  }) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.addToWishlist,
        withAuth: true,
        data: {"productId": productId},
      );
      if (response.statusCode == 200) {
        return WishlistResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.data["message"] ?? "Something went wrong",
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductWishlistModel>> getUserWishlist() async {
    try {
      final response = await DioHelper.get(
        path: ApiConstants.getUserWishlist,
        withAuth: true,
      );
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> dataList = response.data['data'] as List<dynamic>;
        return dataList
            .map((item) => ProductWishlistModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          response.data?['message'] ?? 'Failed to load wishlist items.',
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<WishlistResponseModel> deleteFromWishlist({required String productId}) async{
   try{
     final response = await DioHelper.delete(
         path: ApiConstants.deleteFromWishlist(productId),
         withAuth: true
     );
     if(response.statusCode ==200){
       return WishlistResponseModel.fromJson(response.data) ;
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
