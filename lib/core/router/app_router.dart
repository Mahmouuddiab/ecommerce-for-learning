import 'package:ecommerce/core/screens/splash_screen.dart';
import 'package:ecommerce/features/adresses/presentation/screens/add_address_screen.dart';
import 'package:ecommerce/features/adresses/presentation/screens/saved_address_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/verify_code_screen.dart';
import 'package:ecommerce/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/category/presentation/screens/product_details_screen.dart';
import 'package:ecommerce/features/category/presentation/screens/sub_category_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/sign-up',
        name: 'sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),

      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: '/verify-code',
        name: 'verify-code',
        builder: (context, state) {
          final email = state.extra as String;

          return VerifyCodeScreen(
            email: email,
          );
        },
      ),

      GoRoute(
        path: '/reset-password',
        name: 'reset-password',
        builder: (context, state) {
          final email = state.extra as String;

          return ResetPasswordScreen(
            email: email,
          );
        },
      ),

      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),

      GoRoute(
        path: '/product-details',
        name: 'product-details',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ProductDetailsScreen(product: product);
        },
      ),

      GoRoute(
        path: '/sub-category-products',
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
        path: '/add-address',
        name: 'add-address',
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        path: '/saved-address',
        name: 'saved-address',
        builder: (context, state) => const SavedAddressScreen(),
      ),

    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  );
});