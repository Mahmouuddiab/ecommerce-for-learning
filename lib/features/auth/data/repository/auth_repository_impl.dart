import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDs remote;
  AuthRepositoryImpl(this.remote);
  @override
  Future<UserEntity> signIn(LoginParams params) async {
    return await remote.signIn(params);
  }

  @override
  Future<UserEntity> signUp(RegisterParams params) async {
    return await remote.signUp(params);
  }
}
