import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp(RegisterParams params);
  Future<UserEntity> signIn(LoginParams params);
}