import 'package:ecommerce/features/profile/data/repository/profile_repository_impl.dart';
import 'package:ecommerce/features/profile/domain/repository/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/features/profile/domain/entities/profile_entity.dart';
import 'package:ecommerce/features/profile/domain/usecase/get_user_usecase.dart';

import '../../data/data source/profile_remote_ds.dart';

// 1. Data Source Provider
final profileRemoteDsProvider = Provider<ProfileRemoteDs>((ref) {
  return ProfileRemoteDsImpl();
});

// 2. Repository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remote = ref.watch(profileRemoteDsProvider);
  return ProfileRepositoryImpl(remote);
});

// 3. Use Case Provider
final getUserUseCaseProvider = Provider<GetUserUseCase>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return GetUserUseCase(repo);
});

// 4. Clean FutureProvider (No parameter needed in UI)
final userProfileProvider = FutureProvider<ProfileEntity>((ref) async {
  final getUserUseCase = ref.watch(getUserUseCaseProvider);
  return await getUserUseCase();
});