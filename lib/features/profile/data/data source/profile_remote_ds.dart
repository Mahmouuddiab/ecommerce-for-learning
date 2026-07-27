import 'package:ecommerce/core/cache/cache_helper.dart';
import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';

import '../models/profile_model.dart';

abstract class ProfileRemoteDs {
  Future<ProfileModel> getUser([String? id]);
}

class ProfileRemoteDsImpl implements ProfileRemoteDs {
  @override
  Future<ProfileModel> getUser([String? id]) async {
    try {
      final cachedId = await CacheHelper.getUserId();
      final String userId = id ?? cachedId?.toString() ?? '';

      if (userId.isEmpty) {
        throw const UnauthorizedException('User ID not found in storage');
      }

      final response = await DioHelper.get(
        path: ApiConstants.getUserProfile(userId),
      );

      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.statusMessage ?? 'Failed to fetch user profile',
        );
      }
    } on ServerException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}