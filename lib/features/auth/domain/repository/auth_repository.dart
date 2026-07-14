import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/domain/entities/forgot_password.dart';
import 'package:ecommerce/features/auth/domain/entities/reset_password_entity.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/entities/verify_code_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signUp(RegisterParams params);
  Future<UserEntity> signIn(LoginParams params);
  Future<ForgotPasswordEntity> forgotPassword(String email);
  Future<VerifyCodeEntity> verifyCode(String code);
  Future<ResetPasswordEntity> resetPassword(String email,String newPassword);
}