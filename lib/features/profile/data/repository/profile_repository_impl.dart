import 'package:ecommerce/features/profile/domain/repository/profile_repository.dart';

import '../../domain/entities/profile_entity.dart';
import '../data source/profile_remote_ds.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDs remote;
  ProfileRepositoryImpl(this.remote);

  @override
  Future<ProfileEntity> getUser([String? id]) async {
    return await remote.getUser(id);
  }
}