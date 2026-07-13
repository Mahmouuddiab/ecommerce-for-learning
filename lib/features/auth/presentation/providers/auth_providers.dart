import 'package:dio/dio.dart';
import 'package:ecommerce/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ecommerce/features/auth/domain/usecase/sign_in_usecase.dart';
import 'package:ecommerce/features/auth/domain/usecase/sign_up_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:ecommerce/features/auth/data/data%20source/auth_remote_ds_impl.dart';
import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Data layer

final authRemoteDsProvider = Provider<AuthRemoteDs>((ref) {
  return AuthRemoteDsImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDsProvider));
});

/// Use cases

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

/// Controller (state)

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<UserEntity?>>((ref) {
      return AuthController(
        signInUseCase: ref.watch(signInUseCaseProvider),
        signUpUseCase: ref.watch(signUpUseCaseProvider),
      );
    });

class AuthController extends StateNotifier<AsyncValue<UserEntity?>> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthController({required this.signInUseCase, required this.signUpUseCase})
    : super(const AsyncValue.data(null));

  Future<void> signIn(LoginParams params) async {
    state = const AsyncValue.loading();
    try {
      final user = await signInUseCase(params);
      state = AsyncValue.data(user);
    } on AppException catch (e, st) {
      state = AsyncValue.error(e, st);
    } catch (e, st) {
      state = AsyncValue.error(const UnknownException(), st);
    }
  }

  Future<void> signUp(RegisterParams params) async {
    state = const AsyncValue.loading();
    try {
      final user = await signUpUseCase(params);
      state = AsyncValue.data(user);
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
