import 'package:ecommerce/features/category/data/models/product_model.dart';
import 'package:ecommerce/features/category/data/models/sub_category_model.dart';

abstract class CategoryRemoteDs {
  Future<List<SubCategoryModel>> subCategories(String categoryId);
  Future<List<ProductModel>> products(String subCategoryId);
}