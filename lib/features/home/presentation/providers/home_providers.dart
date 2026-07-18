import 'package:ecommerce/features/home/data/data%20source/home_remote_ds.dart';
import 'package:ecommerce/features/home/data/repository/home_repository_impl.dart';
import 'package:ecommerce/features/home/domain/entities/brand_entity.dart';
import 'package:ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce/features/home/domain/repository/home_repository.dart';
import 'package:ecommerce/features/home/domain/usecase/brand_usecase.dart';
import 'package:ecommerce/features/home/domain/usecase/categories_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data source/home_remote_ds_impl.dart';

// 1. Remote Data Source Provider
final homeRemoteDsProvider = Provider<HomeRemoteDs>((ref) {
  return HomeRemoteDsImpl();
});

// 2. Repository Provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final remoteDataSource = ref.watch(homeRemoteDsProvider);
  return HomeRepositoryImpl(remoteDataSource);
});

// 3. Use Case Providers
final categoriesUseCaseProvider = Provider<CategoriesUseCase>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return CategoriesUseCase(repository);
});

// Added: Brand Use Case Provider
final brandUseCaseProvider = Provider<BrandUseCase>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return BrandUseCase(repository);
});

// 4. UI FutureProviders

// Categories UI Provider
final homeCategoriesProvider = FutureProvider<List<CategoryEntity>>((ref) async {
  final useCase = ref.watch(categoriesUseCaseProvider);
  return await useCase.call();
});

// Added: Brands UI Provider
final homeBrandsProvider = FutureProvider<List<BrandEntity>>((ref) async {
  final useCase = ref.watch(brandUseCaseProvider);
  return await useCase.call();
});