import 'package:ecommerce/core/params/address_params.dart';
import 'package:ecommerce/features/adresses/domain/entity/address_entity.dart';
import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';

abstract class AddressRepository {
  Future<AddressEntity> addAddress(AddressParams params);
  Future<List<SavedAddressEntity>> getSavedAddress();
  Future<SavedAddressEntity> deleteAddress(String id);
}