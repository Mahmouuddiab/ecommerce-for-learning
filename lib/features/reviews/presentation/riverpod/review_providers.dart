import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/params/review_params.dart';
import 'package:ecommerce/features/reviews/data/repository/review_repository_impl.dart';
import 'package:ecommerce/features/reviews/domain/entity/review_entity.dart';
import 'package:ecommerce/features/reviews/domain/repository/review_repository.dart';
import 'package:ecommerce/features/reviews/domain/usecase/add_review_usecase.dart';
import 'package:ecommerce/features/reviews/domain/usecase/get_product_reviews_usecase.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/data source/review_remote_ds.dart';


/// Remote Data Source Provider
final reviewRemoteDsProvider = Provider<ReviewRemoteDs>((ref) {
  return ReviewRemoteDsImpl();
});

/// Repository Provider
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final remoteDs = ref.watch(reviewRemoteDsProvider);
  return ReviewRepositoryImpl(remoteDs);
});

/// Add Review UseCase Provider
final addReviewUseCaseProvider = Provider<AddReviewUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return AddReviewUseCase(repository);
});

/// Get Product Reviews UseCase Provider
final getProductReviewsUseCaseProvider = Provider<GetProductReviewsUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return GetProductReviewsUseCase(repository);
});

// ADD REVIEW STATE NOTIFIER

class AddReviewNotifier extends StateNotifier<AsyncValue<ReviewEntity?>> {
  final AddReviewUseCase _addReviewUseCase;

  AddReviewNotifier(this._addReviewUseCase)
      : super(const AsyncValue.data(null));

  Future<bool> addReview(ReviewParams params) async {
    state = const AsyncValue.loading();

    try {
      final result = await _addReviewUseCase(params);
      state = AsyncValue.data(result);
      return true;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}

final addReviewNotifierProvider = StateNotifierProvider.autoDispose<
    AddReviewNotifier, AsyncValue<ReviewEntity?>>((ref) {
  final useCase = ref.watch(addReviewUseCaseProvider);
  return AddReviewNotifier(useCase);
});


/// Fetches product reviews dynamically based on productId
final productReviewsProvider = FutureProvider.family.autoDispose<List<ReviewEntity>, String>((ref, productId) async {
  final useCase = ref.watch(getProductReviewsUseCaseProvider);
  final result = await useCase(productId);

  return result.fold(
        (failure) => throw failure,
        (reviews) => reviews,
  );
});