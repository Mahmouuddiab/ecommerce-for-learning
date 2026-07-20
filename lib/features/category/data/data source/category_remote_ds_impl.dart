import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/features/category/data/data source/category_remote_ds.dart';
import 'package:ecommerce/features/category/data/models/product_model.dart';
import 'package:ecommerce/features/category/data/models/sub_category_model.dart';

class CategoryRemoteDsImpl implements CategoryRemoteDs {
  @override
  Future<List<SubCategoryModel>> subCategories(String categoryId) async {
    try {
      final response = await DioHelper.get(
        path: ApiConstants.subcategoriesByCategoryId(categoryId),
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => SubCategoryModel.fromJson(e))
            .toList();
      } else {
        throw ServerException('Failed to load subcategories');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> products(String subCategoryId) async {
    try {
      final response = await DioHelper.get(
        path: ApiConstants.productsBySubCategoryId(subCategoryId),
      );
      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      } else {
        throw ServerException('Failed to load products');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
