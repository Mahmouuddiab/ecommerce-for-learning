import 'package:ecommerce/features/auth/domain/entities/reset_password_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repo;
  ResetPasswordUseCase(this.repo);
  Future<ResetPasswordEntity> call(String email, String newPassword) =>
      repo.resetPassword(email, newPassword);
}
