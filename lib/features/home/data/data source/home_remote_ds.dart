import 'package:ecommerce/features/home/data/models/brand_model.dart';
import 'package:ecommerce/features/home/data/models/category_model.dart';

abstract class HomeRemoteDs {
  Future<List<CategoryModel>> categories();
  Future<List<BrandModel>> brands();
}