import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/params/review_params.dart';
import 'package:ecommerce/features/reviews/data/data%20source/review_remote_ds.dart';
import 'package:ecommerce/features/reviews/domain/entity/review_entity.dart';
import 'package:ecommerce/features/reviews/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDs remote;
  ReviewRepositoryImpl(this.remote);
  @override
  Future<ReviewEntity> addReview(ReviewParams params) async {
    return await remote.addReview(params);
  }

  @override
  Future<Either<String, List<ReviewEntity>>> getProductReviews(
      String productId,
      ) async {
    try {
      final reviews = await remote.getProductReviews(productId);
      return Right(reviews);
    } on ServerException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
