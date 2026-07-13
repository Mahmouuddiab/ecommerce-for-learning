import 'package:dio/dio.dart';
import 'package:ecommerce/core/cache/cache_helper.dart';
class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await CacheHelper.getToken();

    if (token?.isNotEmpty ?? false) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401) {
      await CacheHelper.clearToken();

      // Optionally navigate the user to the login screen
      // or refresh the access token here.
    }

    handler.next(err);
  }
}