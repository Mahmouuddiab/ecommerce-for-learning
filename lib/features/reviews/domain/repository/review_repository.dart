import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/params/review_params.dart';
import 'package:ecommerce/features/reviews/domain/entity/review_entity.dart';

abstract class ReviewRepository {
  Future<ReviewEntity> addReview(ReviewParams params);
  Future<Either<String, List<ReviewEntity>>> getProductReviews(String productId);
}