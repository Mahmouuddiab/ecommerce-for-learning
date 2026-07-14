import 'package:dio/dio.dart';
import 'package:ecommerce/core/cache/cache_helper.dart';
import 'package:ecommerce/core/error/app_exception.dart';
import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/features/auth/data/data source/auth_remote_ds.dart';
import 'package:ecommerce/features/auth/data/models/forgot_password_model.dart';
import 'package:ecommerce/features/auth/data/models/reset_password_model.dart';
import 'package:ecommerce/features/auth/data/models/user_model.dart';
import 'package:ecommerce/features/auth/data/models/verify_code_model.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRemoteDsImpl implements AuthRemoteDs {
  @override
  Future<UserModel> signIn(LoginParams params) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.signIn,
        data: {'email': params.email, 'password': params.password},
      );

      final user = UserModel.fromJson(response.data);

      // Decode JWT
      final decodedToken = JwtDecoder.decode(user.token);

      debugPrint('JWT Payload: $decodedToken');

      // Try common keys for the user id
      final userId =
          decodedToken['id'] ?? decodedToken['_id'] ?? decodedToken['sub'];

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

      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<ForgotPasswordModel> forgotPassword(String email) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.forgotPassword,
        data: {"email": email},
      );

      return ForgotPasswordModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<VerifyCodeModel> verifyCode(String code) async {
    try {
      final response = await DioHelper.post(
        path: ApiConstants.verifyResetCode,
        data: {"resetCode": code},
      );

      return VerifyCodeModel.fromJson(response.data);
    } on DioException catch (e) {
      _handleDioError(e);
      rethrow;
    } catch (e) {
      throw const UnknownException();
    }
  }

  @override
  Future<ResetPasswordModel> resetPassword(
      String email,
      String newPassword,
      ) async {
    try {
      final response = await DioHelper.put(
        path: ApiConstants.resetPassword,
        data: {"email": email, "newPassword": newPassword},
      );

      return ResetPasswordModel.fromJson(response.data);
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
      case 400:
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
}