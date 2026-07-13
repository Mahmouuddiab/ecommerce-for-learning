import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/data/data source/auth_remote_ds.dart';
import 'package:ecommerce/features/auth/data/data source/auth_remote_ds_impl.dart';
import 'package:ecommerce/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ecommerce/features/auth/domain/entities/forgot_password.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:ecommerce/features/auth/domain/usecase/forgot_password_usecase.dart';
import 'package:ecommerce/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:ecommerce/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Data layer

final authRemoteDsProvider = Provider<AuthRemoteDs>((ref) {
  return AuthRemoteDsImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDsProvider));
});

/// Use Cases

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

final forgotPasswordUseCaseProvider = Provider<ForgotPasswordUseCase>((ref) {
  return ForgotPasswordUseCase(ref.watch(authRepositoryProvider));
});

/// Controller

final authControllerProvider =
StateNotifierProvider<AuthController, AsyncValue<Object?>>((ref) {
  return AuthController(
    signInUseCase: ref.watch(signInUseCaseProvider),
    signUpUseCase: ref.watch(signUpUseCaseProvider),
    forgotPasswordUseCase: ref.watch(forgotPasswordUseCaseProvider),
  );
});

class AuthController extends StateNotifier<AsyncValue<Object?>> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthController({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.forgotPasswordUseCase,
  }) : super(const AsyncValue.data(null));

  /// Sign In
  Future<void> signIn(LoginParams params) async {
    state = const AsyncValue.loading();

    try {
      final UserEntity user = await signInUseCase(params);
      state = AsyncValue.data(user);
    } on AppException catch (e, st) {
      state = AsyncValue.error(e, st);
    } catch (e, st) {
      state = AsyncValue.error(const UnknownException(), st);
    }
  }

  /// Sign Up
  Future<void> signUp(RegisterParams params) async {
    state = const AsyncValue.loading();

    try {
      final UserEntity user = await signUpUseCase(params);
      state = AsyncValue.data(user);
    } on AppException catch (e, st) {
      state = AsyncValue.error(e, st);
    } catch (e, st) {
      state = AsyncValue.error(const UnknownException(), st);
    }
  }

  /// Forgot Password
  Future<void> forgotPassword(String email) async {
    state = const AsyncValue.loading();

    try {
      final ForgotPasswordEntity result =
      await forgotPasswordUseCase(email);

      state = AsyncValue.data(result);
    } on AppException catch (e, st) {
      state = AsyncValue.error(e, st);
    } catch (e, st) {
      state = AsyncValue.error(const UnknownException(), st);
    }
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}