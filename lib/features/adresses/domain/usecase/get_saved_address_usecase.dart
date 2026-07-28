import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';
import 'package:ecommerce/features/adresses/domain/repository/address_repository.dart';

class GetSavedAddressUseCase {
  final AddressRepository repo;
  GetSavedAddressUseCase(this.repo);
  Future<List<SavedAddressEntity>> call()=> repo.getSavedAddress();
}