import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repo;
  SignUpUseCase(this.repo);
  Future<UserEntity> call(RegisterParams params) => repo.signUp(params);
}
