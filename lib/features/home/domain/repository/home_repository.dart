import 'package:ecommerce/features/home/domain/entities/brand_entity.dart';
import 'package:ecommerce/features/home/domain/entities/category_entity.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> categories();
  Future<List<BrandEntity>> brands();
}