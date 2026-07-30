import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/core/params/review_params.dart';
import 'package:ecommerce/features/reviews/data/model/review_model.dart';

abstract class ReviewRemoteDs {
  Future<ReviewModel> addReview(ReviewParams params);
  Future<List<ReviewModel>> getProductReviews(String productId);
}

class ReviewRemoteDsImpl implements ReviewRemoteDs {
  @override
  Future<ReviewModel> addReview(ReviewParams params) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.addReview(params.productId),
        withAuth: true,
        data: {"review": params.review, "rating": params.rating},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ReviewModel.fromJson(response.data);
      }

      throw ServerException(
        response.data['message'] ?? 'Cannot add review, try again!',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ReviewModel>> getProductReviews(String productId) async {
    try {
      final response = await DioHelper.get(
        path: ApiConstants.getProductReviews(productId),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => ReviewModel.fromJson(json)).toList();
      }

      throw ServerException(
        response.data['message'] ?? 'Cannot fetch reviews, try again!',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

}
