class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://ecommerce.routemisr.com/api/v1';
  static const String signUp = '$baseUrl/auth/signup';
  static const String signIn = '$baseUrl/auth/signin';
  static const String forgotPassword = '$baseUrl/auth/forgotPasswords';
  static const String verifyResetCode = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
}