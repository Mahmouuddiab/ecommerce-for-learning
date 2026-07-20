import 'package:ecommerce/features/category/data/data%20source/category_remote_ds.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/category/domain/entities/sub_category_entity.dart';
import 'package:ecommerce/features/category/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDs remote;
  CategoryRepositoryImpl(this.remote);
  @override
  Future<List<SubCategoryEntity>> subCategories(String categoryId) async {
    return await remote.subCategories(categoryId);
  }

  @override
  Future<List<ProductEntity>> products(String subCategoryId) async{
    return await remote.products(subCategoryId);
  }
}
