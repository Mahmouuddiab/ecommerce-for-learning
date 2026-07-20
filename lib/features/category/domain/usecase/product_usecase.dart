import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/category/domain/repository/category_repository.dart';

class ProductUseCase {
  final CategoryRepository repo;
  ProductUseCase(this.repo);
  Future<List<ProductEntity>> call(String subCategoryId) =>
      repo.products(subCategoryId);
}
