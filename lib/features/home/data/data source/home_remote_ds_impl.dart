import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/features/home/data/data%20source/home_remote_ds.dart';
import 'package:ecommerce/features/home/data/models/brand_model.dart';
import 'package:ecommerce/features/home/data/models/category_model.dart';

class HomeRemoteDsImpl implements HomeRemoteDs {
  @override
  Future<List<CategoryModel>> categories() async {
    try {
      final response = await DioHelper.get(path: ApiConstants.categories);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data
            .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to fetch categories',
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BrandModel>> brands() async {
    try {
      final response = await DioHelper.get(path: ApiConstants.brands);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] as List<dynamic>;
        return data
            .map((json) => BrandModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to fetch brands',
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
