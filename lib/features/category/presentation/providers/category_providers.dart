import 'package:ecommerce/features/category/data/data%20source/category_remote_ds.dart';
import 'package:ecommerce/features/category/data/repository/category_repository_impl.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/category/domain/entities/sub_category_entity.dart';
import 'package:ecommerce/features/category/domain/repository/category_repository.dart';
import 'package:ecommerce/features/category/domain/usecase/product_usecase.dart';
import 'package:ecommerce/features/category/domain/usecase/sub_category_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data source/category_remote_ds_impl.dart';

// 1. Remote Data Source Provider
final categoryRemoteDsProvider = Provider<CategoryRemoteDs>((ref) {
  return CategoryRemoteDsImpl();
});

// 2. Repository Provider
final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  final remoteDataSource = ref.watch(categoryRemoteDsProvider);
  return CategoryRepositoryImpl(remoteDataSource);
});

// 3. Use Case Provider
final subCategoryUseCaseProvider = Provider<SubCategoryUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return SubCategoryUseCase(repository);
});

// 4. UI FutureProvider (Family used to accept categoryId dynamically)
final subCategoriesProvider =
  FutureProvider.family<List<SubCategoryEntity>, String>((ref, categoryId) async {
   final useCase = ref.watch(subCategoryUseCaseProvider);
    return await useCase.call(categoryId);
});

// 5. Product Use Case Provider
final productUseCaseProvider = Provider<ProductUseCase>((ref) {
  final repository = ref.watch(categoryRepositoryProvider);
  return ProductUseCase(repository);
});

// 6. Products UI FutureProvider (Family used to accept subCategoryId)
final productsBySubCategoryProvider =
FutureProvider.family<List<ProductEntity>, String>((ref, subCategoryId) async {
  final useCase = ref.watch(productUseCaseProvider);
  return await useCase.call(subCategoryId);
});