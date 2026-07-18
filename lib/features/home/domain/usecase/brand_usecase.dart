import 'package:ecommerce/features/home/domain/entities/brand_entity.dart';
import 'package:ecommerce/features/home/domain/repository/home_repository.dart';

class BrandUseCase {
  final HomeRepository repo;
  BrandUseCase(this.repo);
  Future<List<BrandEntity>> call() => repo.brands();
}
