import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/category/domain/entities/sub_category_entity.dart';

abstract class CategoryRepository {
  Future<List<SubCategoryEntity>> subCategories(String categoryId);
  Future<List<ProductEntity>> products(String subCategoryId);
}