import 'package:ecommerce/core/params/address_params.dart';
import 'package:ecommerce/features/adresses/data/data%20source/address_remote_ds.dart';
import 'package:ecommerce/features/adresses/domain/entity/address_entity.dart';
import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';
import 'package:ecommerce/features/adresses/domain/repository/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDs remote;
  AddressRepositoryImpl(this.remote);
  @override
  Future<AddressEntity> addAddress(AddressParams params) async {
    return await remote.addAddress(params);
  }

  @override
  Future<List<SavedAddressEntity>> getSavedAddress() async{
    return await remote.getSavedAddress() ;
  }

  @override
  Future<SavedAddressEntity> deleteAddress(String id) async{
    return await remote.deleteAddress(id);
  }
}
