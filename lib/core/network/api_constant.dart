class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://ecommerce.routemisr.com/api/v1';
  static const String signUp = '$baseUrl/auth/signup';
  static const String signIn = '$baseUrl/auth/signin';
  static const String forgotPassword = '$baseUrl/auth/forgotPasswords';
  static const String verifyResetCode = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';
  static const String categories = '$baseUrl/categories';
  static const String brands = '$baseUrl/brands';
  static String subcategoriesByCategoryId(String categoryId) =>
      '$baseUrl/subcategories?category=$categoryId';
  static String productsBySubCategoryId(String subCategoryId) =>
      '$baseUrl/products?subcategory=$subCategoryId';
}
