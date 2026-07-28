import 'package:ecommerce/core/params/address_params.dart';
import 'package:ecommerce/features/adresses/domain/entity/address_entity.dart';
import 'package:ecommerce/features/adresses/domain/repository/address_repository.dart';

class AddAddressUseCase {
  final AddressRepository repo;
  AddAddressUseCase(this.repo);
  Future<AddressEntity> call(AddressParams params)=> repo.addAddress(params);
}