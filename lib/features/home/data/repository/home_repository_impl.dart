import 'package:ecommerce/features/home/data/data%20source/home_remote_ds.dart';
import 'package:ecommerce/features/home/domain/entities/brand_entity.dart';
import 'package:ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDs remote;
  HomeRepositoryImpl(this.remote);
  @override
  Future<List<CategoryEntity>> categories() async {
    return await remote.categories();
  }

  @override
  Future<List<BrandEntity>> brands() async {
    return await remote.brands();
  }
}
