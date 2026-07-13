import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/data/models/forgot_password_model.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDs {
  Future<UserModel> signUp(RegisterParams params);
  Future<UserModel> signIn(LoginParams params);
  Future<ForgotPasswordModel> forgotPassword(String email);
}