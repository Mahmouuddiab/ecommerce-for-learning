import 'package:ecommerce/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getUser([String? id]);
}

