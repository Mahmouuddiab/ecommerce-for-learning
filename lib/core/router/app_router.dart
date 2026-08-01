import 'package:ecommerce/core/screens/splash_screen.dart';
import 'package:ecommerce/features/adresses/presentation/screens/add_address_screen.dart';
import 'package:ecommerce/features/adresses/presentation/screens/saved_address_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/reset_password_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/verify_code_screen.dart';
import 'package:ecommerce/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/category/presentation/screens/product_details_screen.dart';
import 'package:ecommerce/features/category/presentation/screens/sub_category_products_screen.dart';
import 'package:ecommerce/features/profile/presentation/screens/setting_screen.dart';
import 'package:ecommerce/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';
  static const String cart = '/cart';
  static const String productDetails = '/product-details';
  static const String subCategoryProducts = '/sub-category-products';
  static const String addAddress = '/add-address';
  static const String savedAddress = '/saved-address';
  static const String privacyPolicy = '/privacy-policy';
  static const String wishlist = '/wishlist';
  static const String setting = '/setting';
}

/// Key listener that notifies GoRouter when EasyLocalization locale updates
final localeChangeNotifierProvider = Provider<Listenable>((ref) {
  return ValueNotifier<String>('');
});

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyCode,
        name: 'verify-code',
        builder: (context, state) {
          final email = state.extra as String;
          return VerifyCodeScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'reset-password',
        builder: (context, state) {
          final email = state.extra as String;
          return ResetPasswordScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.cart,
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.productDetails,
        name: 'product-details',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ProductDetailsScreen(product: product);
        },
      ),
      GoRoute(
        path: AppRoutes.subCategoryProducts,
        name: 'sub-category-products',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          return SubCategoryProductsScreen(
            subCategoryId: args['subCategoryId'] as String,
            subCategoryName: args['subCategoryName'] as String,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.addAddress,
        name: 'add-address',
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        path: AppRoutes.savedAddress,
        name: 'saved-address',
        builder: (context, state) => const SavedAddressScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacyPolicy,
        name: 'privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),
      GoRoute(
        path: AppRoutes.wishlist,
        name: 'wishlist',
        builder: (context, state) => const WishlistScreen(),
      ),
      GoRoute(
        path: AppRoutes.setting,
        name: 'setting',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error?.toString() ?? 'Route not found'),
      ),
    ),
  );
});