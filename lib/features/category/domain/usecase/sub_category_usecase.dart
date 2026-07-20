import 'package:ecommerce/features/category/domain/entities/sub_category_entity.dart';
import 'package:ecommerce/features/category/domain/repository/category_repository.dart';

class SubCategoryUseCase {
  final CategoryRepository repo;
  SubCategoryUseCase(this.repo);
  Future<List<SubCategoryEntity>> call(String categoryId) =>
      repo.subCategories(categoryId);
}
