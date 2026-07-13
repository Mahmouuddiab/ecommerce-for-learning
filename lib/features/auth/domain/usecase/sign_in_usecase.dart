import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repo;
  SignInUseCase(this.repo);
  Future<UserEntity> call(LoginParams params) => repo.signIn(params);
}