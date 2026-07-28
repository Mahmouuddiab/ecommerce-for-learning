import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/core/params/address_params.dart';
import 'package:ecommerce/features/adresses/data/data%20source/address_remote_ds.dart';
import 'package:ecommerce/features/adresses/data/repository/address_repository_impl.dart';
import 'package:ecommerce/features/adresses/domain/entity/address_entity.dart';
import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';
import 'package:ecommerce/features/adresses/domain/repository/address_repository.dart';
import 'package:ecommerce/features/adresses/domain/usecase/add_address_usecase.dart';
import 'package:ecommerce/features/adresses/domain/usecase/delete_address_usecase.dart';
import 'package:ecommerce/features/adresses/domain/usecase/get_saved_address_usecase.dart';


final addressRemoteDsProvider = Provider<AddressRemoteDs>((ref) {
  return AddressRemoteDsImpl();
});

final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  final remote = ref.watch(addressRemoteDsProvider);
  return AddressRepositoryImpl(remote);
});


final addAddressUseCaseProvider = Provider<AddAddressUseCase>((ref) {
  final repo = ref.watch(addressRepositoryProvider);
  return AddAddressUseCase(repo);
});

final getSavedAddressUseCaseProvider = Provider<GetSavedAddressUseCase>((ref) {
  final repo = ref.watch(addressRepositoryProvider);
  return GetSavedAddressUseCase(repo);
});

final deleteAddressUseCaseProvider = Provider<DeleteAddressUseCase>((ref) {
  final repo = ref.watch(addressRepositoryProvider);
  return DeleteAddressUseCase(repo);
});


final getSavedAddressesProvider = FutureProvider<List<SavedAddressEntity>>((ref) async {
  final useCase = ref.watch(getSavedAddressUseCaseProvider);
  return await useCase();
});

final addAddressControllerProvider =
AsyncNotifierProvider<AddAddressNotifier, AddressEntity?>(AddAddressNotifier.new);

class AddAddressNotifier extends AsyncNotifier<AddressEntity?> {
  @override
  Future<AddressEntity?> build() async {
    return null;
  }

  Future<void> addAddress(AddressParams params) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(addAddressUseCaseProvider);
      final result = await useCase(params);
      ref.invalidate(getSavedAddressesProvider);
      return result;
    });
  }
}

final deleteAddressControllerProvider =
AsyncNotifierProvider<DeleteAddressNotifier, SavedAddressEntity?>(DeleteAddressNotifier.new);

class DeleteAddressNotifier extends AsyncNotifier<SavedAddressEntity?> {
  @override
  Future<SavedAddressEntity?> build() async {
    return null;
  }

  Future<void> deleteAddress(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = ref.read(deleteAddressUseCaseProvider);
      final deletedItem = await useCase(id);
      ref.invalidate(getSavedAddressesProvider);
      return deletedItem;
    });
  }
}