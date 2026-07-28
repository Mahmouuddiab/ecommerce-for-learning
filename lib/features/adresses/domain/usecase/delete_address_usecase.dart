import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';
import 'package:ecommerce/features/adresses/domain/repository/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository repo;
  DeleteAddressUseCase(this.repo);
  Future<SavedAddressEntity> call(String id)=> repo.deleteAddress(id);
}