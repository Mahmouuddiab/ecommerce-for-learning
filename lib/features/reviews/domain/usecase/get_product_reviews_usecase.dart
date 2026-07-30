import 'package:dartz/dartz.dart';
import 'package:ecommerce/features/reviews/domain/entity/review_entity.dart';
import 'package:ecommerce/features/reviews/domain/repository/review_repository.dart';

class GetProductReviewsUseCase {
  final ReviewRepository repository;

  GetProductReviewsUseCase(this.repository);

  Future<Either<String, List<ReviewEntity>>> call(String productId) {
    return repository.getProductReviews(productId);
  }
}
