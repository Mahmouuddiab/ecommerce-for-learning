class ApiConstants {
  ApiConstants._();

  /// Auth
  static const String baseUrl = 'https://ecommerce.routemisr.com/api/v1';
  static const String signUp = '$baseUrl/auth/signup';
  static const String signIn = '$baseUrl/auth/signin';
  static const String forgotPassword = '$baseUrl/auth/forgotPasswords';
  static const String verifyResetCode = '$baseUrl/auth/verifyResetCode';
  static const String resetPassword = '$baseUrl/auth/resetPassword';

  /// Categories & Brands
  static const String categories = '$baseUrl/categories';
  static const String brands = '$baseUrl/brands';
  static String subcategoriesByCategoryId(String categoryId) =>
      '$baseUrl/subcategories?category=$categoryId';
  static String productsBySubCategoryId(String subCategoryId) =>
      '$baseUrl/products?subcategory=$subCategoryId';


  /// cart
  static const String addToCart = '$baseUrl/cart';
  static const String getUserCart = '$baseUrl/cart';
  static String deleteFromCart(String productId) => '$baseUrl/cart/$productId';

  /// wishlist
  static const String getUserWishlist = '$baseUrl/wishlist';
  static const String addToWishlist = '$baseUrl/wishlist';
  static String deleteFromWishlist(String productId) => '$baseUrl/wishlist/$productId';

  /// User / Profile
  static String getUserProfile(String userId) => '$baseUrl/users/$userId';
}
