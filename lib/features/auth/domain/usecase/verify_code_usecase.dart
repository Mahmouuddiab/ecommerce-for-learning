import 'package:ecommerce/features/auth/domain/entities/verify_code_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';

class VerifyCodeUseCase {
  final AuthRepository repo;
  VerifyCodeUseCase(this.repo);
  Future<VerifyCodeEntity> call(String code)=> repo.verifyCode(code);
}