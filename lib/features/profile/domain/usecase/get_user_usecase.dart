import 'package:ecommerce/features/profile/domain/entities/profile_entity.dart';
import 'package:ecommerce/features/profile/domain/repository/profile_repository.dart';

class GetUserUseCase {
  final ProfileRepository repo;
  GetUserUseCase(this.repo);
  Future<ProfileEntity> call([String? id]) => repo.getUser(id);
}
