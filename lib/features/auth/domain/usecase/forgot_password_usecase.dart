import 'package:ecommerce/features/auth/domain/entities/forgot_password.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repo;
  ForgotPasswordUseCase(this.repo);
  Future<ForgotPasswordEntity> call(String email) => repo.forgotPassword(email);
}
