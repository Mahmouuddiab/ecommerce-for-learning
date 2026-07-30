import 'package:ecommerce/core/params/review_params.dart';
import 'package:ecommerce/features/reviews/domain/entity/review_entity.dart';
import 'package:ecommerce/features/reviews/domain/repository/review_repository.dart';

class AddReviewUseCase {
  final ReviewRepository repo;
  AddReviewUseCase(this.repo);
  Future<ReviewEntity> call(ReviewParams params) => repo.addReview(params);
}
