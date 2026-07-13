import 'package:dio/dio.dart';
import 'package:ecommerce/core/cache/cache_helper.dart';
import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/data/data%20source/auth_remote_ds.dart';
import 'package:ecommerce/features/auth/data/models/forgot_password_model.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRemoteDsImpl implements AuthRemoteDs {
  @override
  Future<UserModel> signIn(LoginParams params) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.signIn,
        data: {
          'email': params.email,
          'password': params.password,
        },
      );

      final user = UserModel.fromJson(response.data);

      // Decode JWT
      final decodedToken = JwtDecoder.decode(user.token);

      debugPrint('JWT Payload: $decodedToken');

      // Try common keys for the user id
      final userId =
          decodedToken['id'] ??
              decodedToken['_id'] ??
              decodedToken['sub'];

      if (userId != null) {
        debugPrint('User ID: $userId');

        await CacheHelper.saveUserId(userId.toString());
      } else {
        debugPrint('User ID not found in JWT.');
      }

      await CacheHelper.saveToken(user.token);

      return user;
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw const UnknownException();
    }
  }

  @override
  Future<UserModel> signUp(RegisterParams params) async {
    try {
      // FIX: Changed from FormData to a standard Map JSON payload
      final response = await DioHelper.post(
        path: ApiConstants.signUp,
        data: {
          'name': params.name,
          'email': params.email,
          'password': params.password,
          'rePassword': params.rePassword,
          'phone': params.phone,
        },
      );

      // Note: Make sure to check if route-misr wraps response inside 'data' or if the user data is directly at the root
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw const UnknownException();
    }
  }

  // Extracted helper method to keep code DRY and clean
  void _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = e.response?.data?['message'];

    switch (statusCode) {
      case 400: // Added 400 as RouteMisr frequently returns 400 for existing emails
      case 401:
        throw UnauthorizedException(message ?? 'Invalid credentials');
      case 403:
        throw ForbiddenException(message ?? 'Access denied');
      case 404:
        throw NotFoundException(message ?? 'Resource not found');
      case 422:
        throw ValidationException(message ?? 'Validation failed');
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.badCertificate) {
          throw const NetworkException();
        }
        throw ServerException(message ?? 'Server error occurred');
    }
  }

  @override
  Future<ForgotPasswordModel> forgotPassword(String email) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.forgotPassword,
        data: {
          "email": email,
        },
      );

      if (response.statusCode == 200) {
        return ForgotPasswordModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Something went wrong');
      }
    } catch (e) {
      rethrow;
    }
  }
}
