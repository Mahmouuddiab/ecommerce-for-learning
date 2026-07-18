import 'package:ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce/features/home/domain/repository/home_repository.dart';

class CategoriesUseCase {
  final HomeRepository repo;
  CategoriesUseCase(this.repo);
  Future<List<CategoryEntity>> call() => repo.categories();
}
