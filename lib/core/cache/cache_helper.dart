import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _keyToken = 'token';

  /// Save Token
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  /// Get Token
  static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Remove Token (Logout)
  static Future<void> clearToken() async {
    await _storage.delete(key: _keyToken);
  }

  /// Clear All Stored Data
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}